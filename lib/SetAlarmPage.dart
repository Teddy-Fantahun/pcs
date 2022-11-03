import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DatabaseHelper.dart';
import 'Notifications.dart';
import 'ScheduleDataModel.dart';
import 'Strings.dart';
import 'TextStyles.dart';

class SetAlarmPage extends StatefulWidget {
  SetAlarmPage(this.refreshReminderPage, this.selectedHourIndex,
      this.selectedMinuteIndex, this.selectedMeridianIndex);
  var refreshReminderPage; // to update the UI of the Reminder page (dashboard) from this page

  //we need also to keep track of the currently selected index of the Hour, Minute and AM/PM
  int selectedHourIndex; // each index need to be interpreted for data processing
  int selectedMinuteIndex; //these are just the positional indexes of the cupertino pickers
  int selectedMeridianIndex; // AM or PM

  @override
  _SetAlarmPageState createState() => _SetAlarmPageState();
}

class _SetAlarmPageState extends State<SetAlarmPage> {
  int count = 1;

  //scroll controller for the cupertino pickers
  FixedExtentScrollController scrollControllerForHour;
  FixedExtentScrollController scrollControllerForMin;
  FixedExtentScrollController scrollControllerForMer;

  //the above assigned values are just used to prevent null pointer errors, they will be replaced

  bool isDailyAlarmSwitchedOn = true;

  static Color unselectedDayColor = Colors.grey;
  static Color selectedDayColor = Colors.blue;

  //this array holds the status of the days, i.e. whether the days are selected or not
  //selected days have a blue color, where as unselected colors have a dark grey color
  //the sequence starts from sunday and proceeds to saturday
  static var colorsOfDays = <Color>[
    selectedDayColor,
    selectedDayColor,
    selectedDayColor,
    selectedDayColor,
    selectedDayColor,
    selectedDayColor,
    selectedDayColor,
  ];

  void updateDB() async {
    //update the db

    //prepare the model to be updated
    await DatabaseHelper.updateSchedule(ScheduleDataModel(
        1,
        widget.selectedHourIndex + 1,
        widget.selectedMinuteIndex,
        (widget.selectedMeridianIndex == 0) ? ('AM') : ('PM'),
        (colorsOfDays[0] == selectedDayColor) ? (1) : (-1),
        (colorsOfDays[1] == selectedDayColor) ? (1) : (-1),
        (colorsOfDays[2] == selectedDayColor) ? (1) : (-1),
        (colorsOfDays[3] == selectedDayColor) ? (1) : (-1),
        (colorsOfDays[4] == selectedDayColor) ? (1) : (-1),
        (colorsOfDays[5] == selectedDayColor) ? (1) : (-1),
        (colorsOfDays[6] == selectedDayColor) ? (1) : (-1)));
  }

  //update the UI
  void updateUI() async {
    //fetch UI variables from the db
    //fetch the schedule from the db
    List<ScheduleDataModel> schedule = await DatabaseHelper.getSchedule();
    ScheduleDataModel mySchedule =
        schedule[0]; //pop the first, and the only schedule

    setState(() {
      isDailyAlarmSwitchedOn =
          (mySchedule.countSelectedDays() == 7) ? true : false;
      colorsOfDays[0] = (mySchedule.isMondaySelected == 1)
          ? (selectedDayColor)
          : (unselectedDayColor);
      colorsOfDays[1] = (mySchedule.isTuesdaySelected == 1)
          ? (selectedDayColor)
          : (unselectedDayColor);
      colorsOfDays[2] = (mySchedule.isWednesdaySelected == 1)
          ? (selectedDayColor)
          : (unselectedDayColor);
      colorsOfDays[3] = (mySchedule.isThursdaySelected == 1)
          ? (selectedDayColor)
          : (unselectedDayColor);
      colorsOfDays[4] = (mySchedule.isFridaySelected == 1)
          ? (selectedDayColor)
          : (unselectedDayColor);
      colorsOfDays[5] = (mySchedule.isSaturdaySelected == 1)
          ? (selectedDayColor)
          : (unselectedDayColor);
      colorsOfDays[6] = (mySchedule.isSundaySelected == 1)
          ? (selectedDayColor)
          : (unselectedDayColor);
    });
  }

  void toggleSwitchOfDailyAlarm(bool isSwitchedTurnedOn) {
    // var isSwitchTurnedIsOn is used for protocol, it must be different from isSwitched

    if (isDailyAlarmSwitchedOn == true) {
      //switch is already turned on
      //turn off the switch
      setState(() {
        isDailyAlarmSwitchedOn = false;
      });
      //select one day - such as monday and unselect the rest
      setState(() {
        colorsOfDays[0] = selectedDayColor;
        colorsOfDays[1] = unselectedDayColor;
        colorsOfDays[2] = unselectedDayColor;
        colorsOfDays[3] = unselectedDayColor;
        colorsOfDays[4] = unselectedDayColor;
        colorsOfDays[5] = unselectedDayColor;
        colorsOfDays[6] = unselectedDayColor;
      });
    } else {
      //switch is already turned off
      //turn on the switch
      setState(() {
        isDailyAlarmSwitchedOn = true;
      });
      //select all the days
      setState(() {
        colorsOfDays[0] = selectedDayColor;
        colorsOfDays[1] = selectedDayColor;
        colorsOfDays[2] = selectedDayColor;
        colorsOfDays[3] = selectedDayColor;
        colorsOfDays[4] = selectedDayColor;
        colorsOfDays[5] = selectedDayColor;
        colorsOfDays[6] = selectedDayColor;
      });
    }
  }

  void configureEverdayToogleButton() {
    //if one of the days become unselected, it turns off the toggle button which says "Everyday"
    if (colorsOfDays[0] == unselectedDayColor ||
        colorsOfDays[1] == unselectedDayColor ||
        colorsOfDays[2] == unselectedDayColor ||
        colorsOfDays[3] == unselectedDayColor ||
        colorsOfDays[4] == unselectedDayColor ||
        colorsOfDays[5] == unselectedDayColor ||
        colorsOfDays[6] == unselectedDayColor) {
      setState(() {
        isDailyAlarmSwitchedOn = false;
      });
    }

    //it also turns the toggle button on when all the days are selected
    if (colorsOfDays[0] == selectedDayColor &&
        colorsOfDays[1] == selectedDayColor &&
        colorsOfDays[2] == selectedDayColor &&
        colorsOfDays[3] == selectedDayColor &&
        colorsOfDays[4] == selectedDayColor &&
        colorsOfDays[5] == selectedDayColor &&
        colorsOfDays[6] == selectedDayColor) {
      setState(() {
        isDailyAlarmSwitchedOn = true;
      });
    }
  }

  bool doesTheUserUse24HourFormat() {
    //check if the user uses 12 hour format or 24 hour format
    bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    return is24HoursFormat;
  }

  void scheduleNotification() async {
    //clear all scheduled notifications first
    await Notifications.cancelScheduledNotifications();

    //get the selected days of the week as a list of integers
    List<int> selectedWeeksIndex = [];
    for (int i = 0; i < Strings.daysOfTheWeek.length; i++) {
      if (colorsOfDays[i] == selectedDayColor) {
        selectedWeeksIndex.add(i);
      }
    }

    await Notifications.createAScheduledNotification(
        selectedWeeksIndex,
        widget.selectedHourIndex + 1, //because selectedHourIndex starts from 0
        widget.selectedMinuteIndex,
        doesTheUserUse24HourFormat(),
        widget.selectedMeridianIndex);
  }

  bool isAtLeastOneDaySelected() {
    for (int i = 0; i < colorsOfDays.length; i++) {
      if (colorsOfDays[i] == selectedDayColor) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    scrollControllerForHour =
        FixedExtentScrollController(initialItem: (widget.selectedHourIndex));
    scrollControllerForMin =
        FixedExtentScrollController(initialItem: (widget.selectedMinuteIndex));
    scrollControllerForMer = FixedExtentScrollController(
        initialItem: (widget.selectedMeridianIndex));
  }

  Future<bool> _onWillPop() async {
    widget.refreshReminderPage();
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    if (count == 1) {
      updateUI(); // called once per build
      count++;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ማስታወሻ ቅጠር'),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.6,
                image: AssetImage("assets/images/alarmbg.png"),
                fit: BoxFit.cover),
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                    child: Center(
                      child: Container(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            'assets/images/clock.png',
                            fit: BoxFit.contain,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                    child: Text(
                      'የማስታወሻ ሰዓት',
                      style: TextStyles.myDefaultStyleBold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 80,
                              height: 120,
                              child: CupertinoPicker(
                                itemExtent: 40,
                                looping: true,
                                scrollController: scrollControllerForHour,
                                selectionOverlay: Container(
                                  color: Colors.blue.withOpacity(0.3),
                                ),
                                backgroundColor: Colors.blue[400].withOpacity(0.1),
                                children: Strings.getHoursOfTheDayAsAStringArray()
                                    .map((e) => Center(
                                  child: Text(
                                    e,
                                    style: TextStyles.myDefaultStyle, //TextStyles.myDefaultStyle
                                  ),
                                ))
                                    .toList(),
                                onSelectedItemChanged: (int index) {
                                  widget.selectedHourIndex = index;
                                },
                              ),
                            ),
                            SizedBox(
                              //A placeholder for ':' symbol, which separates hours and minutes
                              width: 40,
                              height: 120,
                              child: CupertinoPicker(
                                itemExtent: 40,
                                looping: false,
                                selectionOverlay: Container(
                                  color: Colors.blue.withOpacity(0.3),
                                ),
                                backgroundColor: Colors.blue[400].withOpacity(0.1),
                                children: <Widget>[
                                  Center(
                                      child: Text(
                                        ':',
                                        style: TextStyles.myDefaultStyleBold,
                                      ))
                                ],
                                onSelectedItemChanged: (int index) {},
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              height: 120,
                              child: CupertinoPicker(
                                itemExtent: 40,
                                looping: true,
                                scrollController: scrollControllerForMin,
                                selectionOverlay: Container(
                                  color: Colors.blue.withOpacity(0.3),
                                ),
                                backgroundColor: Colors.blue[400].withOpacity(0.1),
                                children: Strings.getMinutesOfAnHourAsAStringArray()
                                    .map((e) => Center(
                                  child: Text(
                                    e,
                                    style: TextStyles.myDefaultStyle,
                                  ),
                                ))
                                    .toList(),
                                onSelectedItemChanged: (int index) {
                                  widget.selectedMinuteIndex = index;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              height: 120,
                              child: CupertinoPicker(
                                itemExtent: 40,
                                scrollController: scrollControllerForMer,
                                selectionOverlay: Container(
                                  color: Colors.blue.withOpacity(0.3),
                                ),
                                backgroundColor: Colors.blue[400].withOpacity(0.1),
                                children: Strings.get_AM_and_PM_AsAStringArray()
                                    .map((e) => Center(
                                  child: Text(
                                    e,
                                    style: TextStyles.myDefaultStyle,
                                  ),
                                ))
                                    .toList(),
                                onSelectedItemChanged: (int index) {
                                  widget.selectedMeridianIndex = index;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    child: Text(
                      'የማስታወሻ ቀን',
                      style: TextStyles.myDefaultStyleBold,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: InkWell(
                          onTap: (){
                            toggleSwitchOfDailyAlarm(isDailyAlarmSwitchedOn);
                          },
                          child: Container(
                            width: 300,
                            height: 60,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('ሁሉንም ቀናት                '),
                                Switch(
                                    value: isDailyAlarmSwitchedOn,
                                    onChanged: toggleSwitchOfDailyAlarm,
                                    activeColor: Colors.blue[800],
                                    activeTrackColor: Colors.cyan //Colors.blue[300],
                                ),
                              ],
                            ),
                            color: Colors.blue.withOpacity(0.1),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                    child: Text(
                      'ቀን ይምረጡ',
                      style: TextStyles.myDefaultStyleBold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: Strings.daysOfTheWeek
                          .asMap()
                          .map((i, e) => MapEntry(
                          i,
                          ElevatedButton(
                            onPressed: () {
                              if (colorsOfDays[i] == unselectedDayColor) {
                                setState(() {
                                  colorsOfDays[i] = selectedDayColor;
                                });
                              } else {
                                setState(() {
                                  colorsOfDays[i] = unselectedDayColor;
                                });
                              }
                              configureEverdayToogleButton();
                            },
                            child: Text(
                              e,
                              style: TextStyle(fontSize: 14),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(30, 30),
                              shape: const CircleBorder(),
                              primary: colorsOfDays[i],
                            ),
                          )))
                          .values
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0,8.0,0.0,40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              //check if at least one day is selected
                              if (isAtLeastOneDaySelected() == false) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('እባክዎ ቢያንስ አንድ ቀን ይምረጡ!')));
                                return;
                              }

                              //start an alarm service
                              scheduleNotification();

                              //update the db
                              updateDB();

                              //refresh the Reminder page dashboard
                              widget.refreshReminderPage();

                              //go back to the previous page
                              setState(() {
                                Navigator.pop(context);
                              });

                              //show confirmation message
                            },
                            child: Text('ቅጠር'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              //refresh the Reminder page dashboard
                              widget.refreshReminderPage();

                              Navigator.pop(context);
                            },
                            child: Text(
                              'ይቅር',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
                              primary: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
