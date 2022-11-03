import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pcs/DatabaseHelper.dart';
import 'package:pcs/HomePage.dart';
import 'package:pcs/NewCandidatePage.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:pcs/PCSCandidateDataModel.dart';
import 'package:pcs/ScheduleDataModel.dart';
import 'package:sqflite/sqflite.dart';
import 'PCSListCard.dart';
import 'ReminderPage.dart';
import 'TextStyles.dart';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  //init the database
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  DatabaseHelper.myDb = await openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'DB1111.db'),
    onCreate: (db, version) async {
      // Run the CREATE TABLE statement on the database.
      await db.execute(
          'CREATE TABLE PCSCandidates(id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'firstName TEXT, lastName TEXT, gender TEXT, '
          'registeredMonth TEXT, registeredDay TEXT, registeredYear TEXT, '
          'completedMonth TEXT, completedDay TEXT, completedYear TEXT)'
      );

      await db.execute(
          'CREATE TABLE Schedule(id INTEGER, hour INTEGER, '
              'minute INTEGER, meridian TEXT, isMondaySelected INTEGER, '
              'isTuesdaySelected INTEGER, isWednesdaySelected INTEGER, isThursdaySelected INTEGER, '
              'isFridaySelected INTEGER, isSaturdaySelected INTEGER, isSundaySelected INTEGER)'
      );

    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  AwesomeNotifications().initialize('resource://drawable/res_notification_app_icon', [
    NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        defaultColor: Colors.blue,
        importance: NotificationImportance.High,
        soundSource: 'resource://raw/res_notification')
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PCS',
      theme: ThemeData(
          primarySwatch: Colors.blue, fontFamily: 'NokiaPureHeadline'),
      home: MyHomePage(title: 'PCS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 1;
  int _selectedIndex = 1;
  static List<Widget> _widgetList = <Widget>[
    HomePage(),
    ListView(),
    ReminderPage() // NotificationsPage()
  ];

  void setUpScheduleForTheFirstTime() async{
    // a default alarm schedule is inserted to the db, when the user runs the app for the first time
    //after that, the schedule is updated, not inserted

    List<ScheduleDataModel> mySchedule = await DatabaseHelper.getSchedule();
    if(mySchedule.isEmpty){
      // the schedule is being inserted for the first time
      insertScheduleForTheFirstTime();
    }

  }

  void insertScheduleForTheFirstTime() async{
    await DatabaseHelper.insertASchedule(ScheduleDataModel(1, 1, 0, 'AM', -1, -1, -1, -1, -1, -1, -1));
    // this is read as: 1:00 AM and days are not set yet!
  }

  void fetchPCSCandidatesFromDB() async {
    List<PCSCandidateDataModel> myPCSList =
        await DatabaseHelper.getAllPCSCandidates();

    if (myPCSList.isEmpty) {
      setState(() {
        _widgetList[1] = Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/emptyList.jpg'),
            Padding(
              padding: const EdgeInsets.fromLTRB(45.0, 10.0, 45.0, 10.0),
              child: Text(
                'የ PCS ዝርዝርዎ ባዶ ነው። አዲስ ሰው ሲመዘግቡ ዝርዝርዎ እዚህ ገፅ ላይ ይመጣል።',
                style: TextStyles.myDefaultStyle,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
      });
      return;
    }

    setState(() {
      _widgetList[1] = Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.1,
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover),
        ),
        child: ListView(
          children: myPCSList
              .map(
                (e) => PCSListCard(e, fetchPCSCandidatesFromDB),
              )
              .toList(),
        ),
      );
    });
  }

  void _changeIndex(int newIndex) {
    //this method is called when a new tab is selected
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  void addNewCandidate() {
    setState(() {
      //display the new candidate page
      _widgetList[1] = ListView(children: [NewCandidatePage(fetchPCSCandidatesFromDB)]);
    });
  }

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: this.context,
            builder: (context) => AlertDialog(
                  title: Text('የኖቲፊኬሽን ፈቃድ'),
                  content: Text(
                    'መተግበርያው በትክክል እንዲሰራ፣ ኖቲፊኬሽን እንዲታይ ይፍቀዱ!',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        //close the app
                        SystemNavigator.pop();
                      },
                      child: Text(
                        'አይ',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        AwesomeNotifications()
                            .requestPermissionToSendNotifications()
                            .then((_) => Navigator.pop(context));
                      },
                      child: Text(
                        'እሺ',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ));
      }
    });

    /*
    // What to do when a new notification is created!
    // The snack bar was being used for demo purposes only!

    AwesomeNotifications().createdStream.listen((notification) {
      ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
        content: Text('Notification created on ${notification.channelKey}'),
      ));
    });
     */

    //what to do when an action is taken on the notification displayed
    //decreases the notifications badge counter for iOS - mandatory
    //and go to the home page if it is tapped
    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'scheduled_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
            (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
      }

      //////////////////////////////////// Navigate to the Home page ////////////////////////////////////////////
      Navigator.pushAndRemoveUntil(
          this.context,
          MaterialPageRoute(builder: (_) => MyHomePages(title: 'PCS')),
          (route) => route.isFirst);
    });

  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: this.context,
      builder: (context) => AlertDialog(
        title: new Text('መውጣት ይፈልጋሉ?'),
        content: new Text('እርግጠኛ ነዎት መውጣት ይፈልጋሉ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
            child: new Text('አትውጣ'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // <-- SEE HERE
            child: new Text('አዎ ውጣ', style: TextStyle(color: Colors.red),),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {

    if(count == 1){ // count is used to run this command only once
      setUpScheduleForTheFirstTime();
      fetchPCSCandidatesFromDB();
      count++;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _widgetList.elementAt(_selectedIndex),
        floatingActionButton: (_selectedIndex == 1)
            ? FloatingActionButton(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue[800],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewCandidatePage(fetchPCSCandidatesFromDB)),
                  );
                },
                tooltip: 'አዲስ ሰው ይመዝግቡ',
                child: Icon(Icons.person_add_alt_1),
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ስለ PCS'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'PCS ዝርዝሬ'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'ማስታወሻ'),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.yellow,
          backgroundColor: Colors.blue,
          onTap: _changeIndex,
        ),
      ),
    );
  }
}
