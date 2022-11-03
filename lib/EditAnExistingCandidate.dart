import 'package:flutter/material.dart';
import 'package:pcs/PCSCandidateDataModel.dart';

import 'DatabaseHelper.dart';
import 'Strings.dart';
import 'TextStyles.dart';

class EditAnExistingCandidate extends StatefulWidget {
  EditAnExistingCandidate(this.dataModel, this.refreshPCSList);
  final PCSCandidateDataModel dataModel;
  var refreshPCSList;

  @override
  _EditAnExistingCandidateState createState() =>
      _EditAnExistingCandidateState();
}

enum genderOptions { male, female, unselected }

class _EditAnExistingCandidateState extends State<EditAnExistingCandidate> {
  genderOptions _currentSelection = genderOptions.unselected;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //these controllers help us to get the texts of the corresponding text fields
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var yearController = TextEditingController();

  var _dropdownValueForMonth = Strings.monthsOfTheYear[0]; //default value
  void dropdownCallBackForMonth(String selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValueForMonth = selectedValue;
      });
    }
  }

  var _dropdownValueForDay =
      Strings.getDaysOfTheMonthAsAStringArray()[0]; //default value
  void dropdownCallBackForDay(String selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValueForDay = selectedValue;
      });
    }
  }

  String getSelectedGender() {
    if (_currentSelection == genderOptions.male) {
      return "male";
    } else if (_currentSelection == genderOptions.female) {
      return "female";
    } else {
      return "unselected";
    }
  }

  int count = 1; //to make sure the initialization is called only once!

  @override
  Widget build(BuildContext context) {
    //update the UI with existing data
    if (count == 1) {
      firstNameController.text = widget.dataModel.firstName;
      lastNameController.text = widget.dataModel.lastName;
      _currentSelection = (widget.dataModel.gender == 'male')
          ? genderOptions.male
          : genderOptions.female;
      _dropdownValueForMonth = widget.dataModel.registeredMonth;
      _dropdownValueForDay = widget.dataModel.registeredDay;
      yearController.text = widget.dataModel.registeredYear;
    }
    count++;

    const snackBar = SnackBar(
      content: Text('እባክዎ ፆታ ይምረጡ!'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 1),
    );
    const snackBar2 = SnackBar(
      content: Text('እባክዎ አመቱን ያስገቡ!'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 1),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('መረጃ አስተካክል'),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 0.1,
                  image: AssetImage("assets/images/register.jpg"),
                  fit: BoxFit.cover),
            ),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(16.0, 35.0, 16.0, 16.0),
                      child: Center(
                        child: Container(
                            width: 80,
                            height: 80,
                            child: Image.asset(
                              'assets/images/edit.png',
                              fit: BoxFit.contain,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'ስም',
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        controller: firstNameController,
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'እባክዎ ይህን ይሙሉት';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'የአባት ስም',
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        controller: lastNameController,
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'እባክዎ ይህን ይሙሉት';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 8.0, 16.0, 8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: Colors.grey[600],
                            ),
                            Radio<genderOptions>(
                              value: genderOptions.male,
                              groupValue: _currentSelection,
                              onChanged: (genderOptions value) {
                                setState(() {
                                  _currentSelection = value;
                                });
                              },
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _currentSelection = genderOptions.male;
                                });
                              },
                              child: Text(
                                'ወንድ',
                                style: TextStyles.myDefaultStyle,
                              ),
                            ),
                            Radio<genderOptions>(
                              value: genderOptions.female,
                              groupValue: _currentSelection,
                              onChanged: (genderOptions value) {
                                setState(() {
                                  _currentSelection = value;
                                });
                              },
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _currentSelection = genderOptions.female;
                                });
                              },
                              child: Text(
                                'ሴት',
                                style: TextStyles.myDefaultStyle,
                              ),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 8.0, 16.0, 8.0),
                      child: Text(
                        'ፀሎት የጀመሩበት ቀን ',
                        style: TextStyles.myDefaultStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 8.0, 0.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 120,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[600]),
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  items: Strings.monthsOfTheYear
                                      .map<DropdownMenuItem<String>>(
                                          (String x) {
                                    return DropdownMenuItem<String>(
                                      value: x,
                                      child: Text(
                                        x,
                                      ),
                                    );
                                  }).toList(),
                                  isExpanded: true,
                                  value: _dropdownValueForMonth,
                                  onChanged: dropdownCallBackForMonth,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 80,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[600]),
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  items: (_dropdownValueForMonth ==
                                          Strings.monthsOfTheYear[12])
                                      ? Strings.puagmeDays()
                                          .map<DropdownMenuItem<String>>(
                                              (String x) {
                                          return DropdownMenuItem<String>(
                                            value: x,
                                            child: Text(
                                              x,
                                            ),
                                          );
                                        }).toList()
                                      : Strings
                                              .getDaysOfTheMonthAsAStringArray()
                                          .map<DropdownMenuItem<String>>(
                                              (String x) {
                                          return DropdownMenuItem<String>(
                                            value: x,
                                            child: Text(
                                              x,
                                            ),
                                          );
                                        }).toList(),
                                  isExpanded: true,
                                  value: _dropdownValueForDay,
                                  onChanged: dropdownCallBackForDay,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 80,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'አመት',
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              controller: yearController,
                              validator: (String value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 32.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size.fromHeight(55)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ))),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            //input is valid
                            //further validations need to be done

                            //check if gender is selected
                            if (_currentSelection == genderOptions.unselected) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }

                            //check if proper year is inserted
                            if (yearController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar2);
                              return;
                            }

                            //submit the data to the database
                            await DatabaseHelper.updateAPCSCandidate(
                                PCSCandidateDataModel(
                                    firstNameController.text,
                                    lastNameController.text,
                                    getSelectedGender(),
                                    _dropdownValueForMonth,
                                    _dropdownValueForDay,
                                    yearController.text,
                                    widget.dataModel.id));

                            // refresh the list on the home page
                            widget.refreshPCSList();

                            //return to the home page
                            Navigator.pop(context, true);
                          }
                        },
                        child: const Text(
                          'አስተካክል',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
