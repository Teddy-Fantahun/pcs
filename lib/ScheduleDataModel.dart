
class ScheduleDataModel{
  int id; // is always 1, because there will be only one schedule at a time
  int hour;
  int minute;
  String meridian; // possible values are "AM" and "PM"
  int isMondaySelected; //if selected it is 1, otherwise -1
  int isTuesdaySelected;
  int isWednesdaySelected;
  int isThursdaySelected;
  int isFridaySelected;
  int isSaturdaySelected;
  int isSundaySelected;

  ScheduleDataModel(this.id,this.hour, this.minute, this.meridian,
      this.isMondaySelected,this.isTuesdaySelected,this.isWednesdaySelected,
      this.isThursdaySelected,this.isFridaySelected,this.isSaturdaySelected,
      this.isSundaySelected);

  // Convert a Schedule into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hour': hour,
      'minute': minute,
      'meridian': meridian,
      'isMondaySelected' : isMondaySelected,
      'isTuesdaySelected' : isTuesdaySelected,
      'isWednesdaySelected' : isWednesdaySelected,
      'isThursdaySelected' : isThursdaySelected,
      'isFridaySelected' : isFridaySelected,
      'isSaturdaySelected' : isSaturdaySelected,
      'isSundaySelected' : isSundaySelected
    };
  }

  // Implement toString to make it easier to see information about
  // the schedule when using the print statement.
  @override
  String toString() {
    return 'Schedule{id: $id, hour: $hour, minute: $minute, meridian: $meridian, '
        'isMondaySelected: $isMondaySelected, isTuesdaySelected: $isTuesdaySelected,  isWednesdaySelected: $isWednesdaySelected,  isThursdaySelected: $isThursdaySelected, '
        'isFridaySelected: $isFridaySelected, isSaturdaySelected: $isSaturdaySelected, isSundaySelected: $isSundaySelected}';
  }


  //////////////////////////////////////////////////////////
  ///////////// Helper Functions  /////////////////////////
  /////////////////////////////////////////////////////////

  bool areAllDaysUnselected(){

    if(isMondaySelected==1 || isTuesdaySelected==1 ||
        isWednesdaySelected==1 || isThursdaySelected==1 ||
        isFridaySelected==1 || isSaturdaySelected==1 ||
        isSundaySelected==1){
      return false;
    }
    else{
      return true;
    }

  }

  int countSelectedDays(){
    int count = 0;

    if(isMondaySelected==1){
      count++;
    }
    if(isTuesdaySelected==1){
      count++;
    }
    if(isWednesdaySelected==1){
      count++;
    }
    if(isThursdaySelected==1){
      count++;
    }
    if(isFridaySelected==1){
      count++;
    }
    if(isSaturdaySelected==1){
      count++;
    }
    if(isSundaySelected==1){
      count++;
    }

    return count;

  }

  String returnTheFirstSelectedDay(){

    if(isMondaySelected==1){
      return "ሰኞ";
    }
    if(isTuesdaySelected==1){
      return "ማክሰኞ";
    }
    if(isWednesdaySelected==1){
      return "እሮብ";
    }
    if(isThursdaySelected==1){
      return "ሀሙስ";
    }
    if(isFridaySelected==1){
      return "አርብ";
    }
    if(isSaturdaySelected==1){
      return "ቅዳሜ";
    }
    if(isSundaySelected==1){
      return "እሁድ";
    }

    return null;

  }

}