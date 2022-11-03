import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcs/ScheduleDataModel.dart';

import 'DatabaseHelper.dart';
import 'Notifications.dart';
import 'SetAlarmPage.dart';
import 'Strings.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key key}) : super(key: key);

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  bool isSwitched = false;
  String repetition = 'በየቀኑ';
  String hourInString =
      '1'; //these values are used to prevent null pointer errors, they are replaced
  String minuteInString = '00';
  String meridianInString = 'AM';
  int count = 1;

  void updateUI() async {
    //fetch variables (of UI) from db

    // If all days are not selected, it is assumed that notification is turned off
    // in other words, turning notifications off must mark all days as unselected

    //fetch the schedule from the db
    List<ScheduleDataModel> schedule = await DatabaseHelper.getSchedule();
    ScheduleDataModel mySchedule =
        schedule[0]; //pop the first, and the only schedule

    if (mySchedule.areAllDaysUnselected() == true) {
      //all days are not selected
      setState(() {
        isSwitched = false;
        repetition = 'ማስታወሻ ቀን አልቀጠሩም';
        hourInString = '1';
        minuteInString = '00'; // These values are used as default values
        meridianInString = 'AM';
      });
      return; // no need to go to the code below... for better efficiency!
    } else {
      setState(() {
        isSwitched = true;
      });
    }

    //the if statements written below are nested based on their computational efficiency
    if (mySchedule.countSelectedDays() == 1) {
      // Exactly one day is selected
      setState(() {
        repetition = 'ዘወትር ${mySchedule.returnTheFirstSelectedDay()}';
        hourInString = '${mySchedule.hour}';
      });
      if (mySchedule.minute < 10) {
        setState(() {
          minuteInString =
              '0${mySchedule.minute}'; // for formality, say '00' instead of '0'
        });
      } else {
        // directly use the number if it is greater or equal to 10
        setState(() {
          minuteInString = '${mySchedule.minute}';
        });
      }
      setState(() {
        meridianInString = '${mySchedule.meridian}';
      });
    } else if (mySchedule.countSelectedDays() >= 2) {
      // two or more day are selected
      setState(() {
        repetition = 'በሳምንት ${mySchedule.countSelectedDays()} ቀን';
        hourInString = '${mySchedule.hour}';
      });
      if (mySchedule.minute < 10) {
        setState(() {
          minuteInString =
              '0${mySchedule.minute}'; // for formality, say '00' instead of '0'
        });
      } else {
        // directly use the number if it is greater or equal to 10
        setState(() {
          minuteInString = '${mySchedule.minute}';
        });
      }
      setState(() {
        meridianInString = '${mySchedule.meridian}';
      });
    }

    if (mySchedule.countSelectedDays() == 7) {
      // all days are selected
      setState(() {
        repetition = 'በየቀኑ';
      });
    }
  }

  void toggleSwitch(bool isSwitchedTurnedOn) {
    // var isSwitchTurnedIsOn is used for protocol, it must be different from isSwitched

    if (isSwitched == true) {
      //switch is already turned on
      //turn off the switch

      //prompt the user
      showCupertinoDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext) {
            return CupertinoAlertDialog(
              content: Text(
                  'ማስታወሻውን ካጠፉ፣ ከአሁን በኋላ መተግበርያው PCS ስትራቴጂን እንዲተገብሩ አያስታውስዎትም ማለት ነው!'
                  ' እርግጠኛ ነዎት ማስታወሻውን ማጥፋት ይፈልጋሉ?'),
              actions: [
                TextButton(
                    onPressed: () async {
                      //close the alarm service
                      await Notifications.cancelScheduledNotifications();

                      setState((){
                        isSwitched = false;
                      });

                      // mark all days as unselected

                      /* NOTE : this is mandatory, because it is the only way to
                           communicate to our db that notifications are turned off */

                      /*
                        When schedule data is fetched from the db, it is only through this way that
                        the UI infers that notifications are turned off
                         */

                      //prepare the model to be updated
                      await DatabaseHelper.updateSchedule(ScheduleDataModel(
                          1, 1, 0, 'AM', -1, -1, -1, -1, -1, -1, -1));

                      //close the pop-up alert dialog
                      Navigator.of(context).pop();
                    },
                    child: Text('አዎ አጥፋ', style: TextStyle(color: Colors.red),),),
                TextButton(
                    onPressed: () {
                      //close the pop-up alert dialog
                      Navigator.of(context).pop();
                    },
                    child: Text('አይ ተወው'))
              ],
            );
          });
    } else {
      //switch is already turned off
      //turn on the switch
      setState(() {
        isSwitched = true;
      });

      ////////////////////////////////////////////////////////
      //Navigate to the set alarm page
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SetAlarmPage(
                updateUI,
                getHourIndex(),
                getMinuteIndex(),
                getMeridianIndex())),
        // pass the updateUI() handle when navigating to this page
      );

    }
  }

  int getHourIndex() {
    return (int.parse(hourInString) - 1);
  }

  int getMinuteIndex() {
    return int.parse(minuteInString);
  }

  int getMeridianIndex() {
    return (meridianInString == 'AM') ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    if (count == 1) {
      //load it only once per page build
      updateUI();
      count++;
    }

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            opacity: 0.1,
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    'assets/images/notifications.png',
                    fit: BoxFit.contain,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                elevation: 5,
                color: Colors.white.withOpacity(0.9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
                child: ListTile(
                    title: Padding(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ማስታወሻ                '),
                          Switch(
                              value: isSwitched,
                              onChanged: toggleSwitch,
                              activeColor: Colors.blue[800],
                              activeTrackColor: Colors.cyan),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    isThreeLine: true,
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Divider(
                          color: Colors.blue,
                          thickness: 1,
                          indent: 25,
                          endIndent: 25,
                        ),
                        Padding(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                repetition,
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                '     |     ',
                                style: TextStyle(color: Colors.blue),
                              ),
                              Text(
                                hourInString +
                                    ':' +
                                    minuteInString +
                                    ' ' +
                                    meridianInString,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SetAlarmPage(
                                        updateUI,
                                        getHourIndex(),
                                        getMinuteIndex(),
                                        getMeridianIndex())),
                                // pass the updateUI() handle when navigating to this page
                              );
                            },
                            child: Text('የማስታወሻ ቀጠሮዬን ቀይር'),
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size.fromHeight(55)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ))),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
