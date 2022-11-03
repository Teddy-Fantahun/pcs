import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pcs/TextStyles.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            opacity: 0.1,
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              height: 350,
              width: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          'assets/images/notifications.png',
                          fit: BoxFit.contain,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50.0, 35.0, 50.0, 10.0),
                      child: Text(
                        'ለመዘገቧቸው ሰዎች ሳይረሱ በቋሚነት እንዲፀልዩ ማስታወሻ (Notification) ቢኖርዎት ይመከራል። ',
                        style: TextStyles.myDefaultStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size.fromHeight(55)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ))),
                        onPressed: () async {

                        },
                        child: const Text(
                          'ማስታወሻ ቅጠር',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
