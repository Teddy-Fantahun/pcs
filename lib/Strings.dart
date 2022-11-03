import 'package:flutter/material.dart';
import 'package:pcs/DescriptionPage.dart';
import 'package:pcs/MainCard.dart';

class Strings {

  static final monthsOfTheYear = <String>[
    'መስከረም',
    'ጥቅምት',
    'ህዳር',
    'ታህሳስ',
    'ጥር',
    'የካቲት',
    'መጋቢት',
    'ሚያዚያ',
    'ግንቦት',
    'ሰኔ',
    'ሀምሌ',
    'ነሀሴ',
    'ጷጉሜ'
  ];

  static final daysOfTheWeek = <String>['ሰ', 'ማ', 'ረ', 'ሀ', 'አ', 'ቅ', 'እ'];

  static List<String> getDaysOfTheMonthAsAStringArray(){
    var daysOfTheMonth = <String> [];
    for(int i=1; i<=30; i++){
      daysOfTheMonth.add(i.toString());
    }
    return daysOfTheMonth;
  }

  static List<String> puagmeDays(){
    var daysOfTheMonth = <String> [];
    for(int i=1; i<=6; i++){
      daysOfTheMonth.add(i.toString());
    }
    return daysOfTheMonth;
  }

  static List<String> getHoursOfTheDayAsAStringArray(){
    var hoursOfTheDay = <String> [];
    for(int i=1; i<=12; i++){
      hoursOfTheDay.add(i.toString());
    }
    return hoursOfTheDay;
  }

  static List<String> getMinutesOfAnHourAsAStringArray(){
    var minutesOfAnHour = <String> [];
    for(int i=0; i<=59; i++){
      if(i<10){
        minutesOfAnHour.add('0' + i.toString());
        // eg. say 00 instead of 0 - for better readability
      }
      else{
        minutesOfAnHour.add(i.toString());
      }
    }
    return minutesOfAnHour;
  }

  static List<String> get_AM_and_PM_AsAStringArray(){
    var AM_and_PM_AsAStringArray = <String> [];
    AM_and_PM_AsAStringArray.add('AM');
    AM_and_PM_AsAStringArray.add('PM');
    return AM_and_PM_AsAStringArray;
  }

  static List<String> getYearsAsAnArrayString(int minimumYear, int maximumYear){
    var years = <String> [];
    for(int i=minimumYear; i<=maximumYear; i++){
      years.add(i.toString());
    }
    return years;
  }
}