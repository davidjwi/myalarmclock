import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:alarmclock/alarmclock.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My Alarm App',
      theme: new ThemeData(primarySwatch: Colors.red),
      home: new MyHomePage(title: 'Alarm Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var firstAlarmValue = new DateTime.now().add(new Duration(minutes:400));
  var secondAlarmValue = new DateTime.now().add(new Duration(minutes:465));
  var thirdAlarmValue = new DateTime.now().add(new Duration(minutes:505));

  String firstAlarmFormatted, secondAlarmFormatted, thirdAlarmFormatted = '';

  int newHour, newMinute, newFirstHour, newFirstMinute, newAfterHour, newAfterMinute = 0;

  void _setAlarm(int setAlarmHour, int setAlarmMinute) {
    Alarmclock.setAlarm(skipui:true, hour:setAlarmHour, minute:setAlarmMinute);
  }

  void _getwakeuptimes() {
    firstAlarmFormatted = new DateFormat('jm').format(firstAlarmValue);
    secondAlarmFormatted = new DateFormat('jm').format(secondAlarmValue);
    thirdAlarmFormatted = new DateFormat('jm').format(thirdAlarmValue);
    newHour = secondAlarmValue.hour;
    newMinute = secondAlarmValue.minute;
    newFirstHour = firstAlarmValue.hour;
    newFirstMinute = firstAlarmValue.minute;
    newAfterHour = thirdAlarmValue.hour;
    newAfterMinute = thirdAlarmValue.minute;
  }

  void _updateClocks() {
    setState(() {
      _getwakeuptimes();
    });
  }

  Container buildStandardContainer(Row childRow) {
    return Container(
        padding: const EdgeInsets.all(34.0),
        alignment: Alignment.center,
        child: childRow,
        );
  }
  
  Row buildStandardRow(String formattedTimeValue, int newAlarmHour, int newAlarmMinute) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text( 
              '$formattedTimeValue',
              style: new TextStyle( fontSize: 30.0,),
              ),
          FloatingActionButton(
              onPressed: () => _setAlarm(newAlarmHour, newAlarmMinute),
              child: new Icon(Icons.alarm),
              ),
        ],
        );
  
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

    Widget firstRow = buildStandardContainer(
        buildStandardRow(firstAlarmFormatted, newFirstHour, newFirstMinute)
        );

    Widget secondRow = buildStandardContainer(
        buildStandardRow(secondAlarmFormatted, newHour, newMinute)
        );

    Widget thirdRow  = buildStandardContainer(
        buildStandardRow(thirdAlarmFormatted, newAfterHour, newAfterMinute)
        );

     Widget fourthRow = buildStandardContainer(
         Row(
             children: [
               FloatingActionButton(
                   onPressed:_updateClocks,
                   tooltip: 'Update times',
                   child: new Icon(Icons.refresh),
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
             fourthRow,
             ],
             ),
      );
  }
}
