import 'package:awesome_notifications/awesome_notifications.dart';

class Notifications {
  static Future<void> createAScheduledNotification(
      List<int> weekDayIndex,
      int hour,
      int min,
      bool doesTheUserUse24HourFormat,
      int meridianIndex /* AM's index is 0, PM's index is 1 */
      ) async {
    for (int i = 0; i < weekDayIndex.length; i++) {
      //print used for demo
      /*
      print(
          "\n\nSchedule created for week day ${weekDayIndex[i] + 1} at ${(doesTheUserUse24HourFormat == true) ? (hour) : (hourConverter12HourTo24Hour(meridianIndex, hour))}:$min ///////////////////////////\n\n");
      */

      await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: weekDayIndex[i],
            channelKey: 'scheduled_channel',
            title: '${Emojis.sound_bell} የ PCS ማስታወሻ!',
            body: 'ይፀልዩ፣ እንክብካቤ ያሳዩ፣ ይመስክሩ',
            bigPicture: 'asset://assets/images/pcs_reminder_picture.png',
            notificationLayout: NotificationLayout.BigPicture,
          ),
          schedule: NotificationCalendar(
            repeats: true,
            weekday: weekDayIndex[i] +
                1, //because weekday starts from 1, i.e., monday=1
            hour: (doesTheUserUse24HourFormat == true)
                ? (hour)
                : (hourConverter12HourTo24Hour(meridianIndex, hour)),
            minute: min,
            second: 0,
            millisecond: 0,
          ));
    }
  }

  static int hourConverter12HourTo24Hour(
      int selectedMeridianIndex, int hourToBeConverted) {
    //because the notification timer only uses 24 hour format
    if (selectedMeridianIndex == 0) {
      //hour is in AM
      // do nothing, just return the hour as it is!
      return hourToBeConverted;
    } else {
      //hour is in PM
      //add 12 to the hour
      int hourConverted = hourToBeConverted + 12;
      //if the hour is 24, make it 0, because 0 is used instead of 24
      if (hourConverted == 24) {
        hourConverted = 0;
      }
      return hourConverted;
    }
  }

  static Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
}
