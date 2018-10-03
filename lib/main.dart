import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:alarmclock/alarmclock.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My Alarm App',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(title: 'Alarm Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _firstTime = new DateTime.now().add(new Duration(minutes:400));
  var _wakeupTime = new DateTime.now().add(new Duration(minutes:465));
  var _afterTime = new DateTime.now().add(new Duration(minutes:505));
  String _formattedTime = '';
  String _fmtFirstTime, _fmtAfterTime = '';
  int newHour = 0;
  int newMinute = 0;
  int newFirstHour, newFirstMinute, newAfterHour, newAfterMinute = 0;

  void _setAlarm(int anHour, int anMinute) {
    Alarmclock.setAlarm(skipui:true, hour:anHour, minute:anMinute);
  }

  void _getwakeuptimes() {
    _formattedTime = new DateFormat('jm').format(_wakeupTime);
    _fmtFirstTime = new DateFormat('jm').format(_firstTime);
    _fmtAfterTime = new DateFormat('jm').format(_afterTime);
    newHour = _wakeupTime.hour;
    newMinute = _wakeupTime.minute;
    newFirstHour = _firstTime.hour;
    newFirstMinute = _firstTime.minute;
    newAfterHour = _afterTime.hour;
    newAfterMinute = _afterTime.minute;
  }

  void _updateClocks() {
    setState(() {
      _getwakeuptimes();
    });
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    _getwakeuptimes();

    Widget firstRow = Container(
        padding: const EdgeInsets.all(34.0),
        alignment: Alignment.center,
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  '$_fmtFirstTime',
                  style: new TextStyle( fontSize: 30.0,),
                  ),
              FloatingActionButton(
                  onPressed: () => _setAlarm(newFirstHour, newFirstMinute),
                  child: new Icon(Icons.alarm),
                  ),
            ],
            ),
        );

    Widget secondRow = Container(
        padding: const EdgeInsets.all(34.0),
        alignment: Alignment.center,
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  '$_formattedTime',
                  style: new TextStyle( fontSize: 30.0,),
                  ),
              FloatingActionButton(
                  onPressed: () => _setAlarm(newHour, newMinute),
                  child: new Icon(Icons.alarm),
                  ),
            ],
            ),
        );

    Widget thirdRow = Container(
        padding: const EdgeInsets.all(34.0),
        alignment: Alignment.center,
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  '$_fmtAfterTime',
                  style: new TextStyle( fontSize: 30.0,),
                  ),
              FloatingActionButton(
                  onPressed: () => _setAlarm(newAfterHour, newAfterMinute),
                  child: new Icon(Icons.alarm),
                  ),
            ],
            ),
        );

    return new Scaffold(
        appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: ListView(
          children: [
             firstRow,
             secondRow,
             thirdRow,
             ],
             ),
      );
  }
}
//            new FloatingActionButton(
//                onPressed: _updateClocks,
//                tooltip: 'Wake up at',
//                child: new Icon(Icons.add),
//                ),
