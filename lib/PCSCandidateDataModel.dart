import 'package:flutter/material.dart';

class PCSCandidateDataModel{
  int id;
  String firstName;
  String lastName;
  String gender;
  String registeredMonth;
  String registeredDay;
  String registeredYear;
  String completedMonth;
  String completedDay;
  String completedYear;

  PCSCandidateDataModel(this.firstName, this.lastName, this.gender,
      this.registeredMonth,this.registeredDay,this.registeredYear,
      [this.id, this.completedMonth,this.completedDay,this.completedYear]);

  // Convert a PCSCandidate into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'gender' : gender,
      'registeredMonth' : registeredMonth,
      'registeredDay' : registeredDay,
      'registeredYear' : registeredYear,
      'completedMonth' : completedMonth,
      'completedDay' : completedDay,
      'completedYear' : completedYear
    };
  }

  // Implement toString to make it easier to see information about
  // each PCSCandidate when using the print statement.
  @override
  String toString() {
    return 'PCSCandidate{id: $id, firstName: $firstName, lastName: $lastName, '
        'gender: $gender, registeredMonth: $registeredMonth,  registeredDay: $registeredDay,  registeredYear: $registeredYear, '
        'completedMonth: $completedMonth, completedDay: $completedDay, completedYear: $completedYear}';
  }

  String getSelectedDate() {
    //returns the selected Date as the following string format -> 'month day, year' -> example: Meskerem 23, 2025
    String response = registeredMonth + " ";
    response += registeredDay + ", ";
    response += registeredYear;
    return response;
  }

}