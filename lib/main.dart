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
  var firstAlarmValue = new DateTime.now().add(new Duration(minutes: 400));
  var secondAlarmValue = new DateTime.now().add(new Duration(minutes: 465));
  var thirdAlarmValue = new DateTime.now().add(new Duration(minutes: 505));

  void _setAlarm(int setAlarmHour, int setAlarmMinute) {
    Alarmclock.setAlarm(
        skipui: true, hour: setAlarmHour, minute: setAlarmMinute);
  }

  String _formatAlarmValue(DateTime datetimeAlarmValue) {
    return new DateFormat('jm').format(datetimeAlarmValue);
  }

  void _updateClocks() {
    setState(() {
      // Update all clock values here
      firstAlarmValue = new DateTime.now().add(new Duration(minutes: 400));
      secondAlarmValue = new DateTime.now().add(new Duration(minutes: 465));
      thirdAlarmValue = new DateTime.now().add(new Duration(minutes: 505));
    });
  }

  Container buildStandardContainer(Row childRow) {
    return Container(
      padding: const EdgeInsets.all(34.0),
      alignment: Alignment.center,
      child: childRow,
    );
  }

  Row buildStandardRow(
      String formattedTimeValue, int newAlarmHour, int newAlarmMinute) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          '$formattedTimeValue',
          style: new TextStyle(
            fontSize: 30.0,
          ),
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
    // This method is rerun every time setState is called

    Widget firstRow = buildStandardContainer(buildStandardRow(
        _formatAlarmValue(firstAlarmValue),
        firstAlarmValue.hour,
        firstAlarmValue.minute));

    Widget secondRow = buildStandardContainer(buildStandardRow(
        _formatAlarmValue(secondAlarmValue),
        secondAlarmValue.hour,
        secondAlarmValue.minute));

    Widget thirdRow = buildStandardContainer(buildStandardRow(
        _formatAlarmValue(thirdAlarmValue),
        thirdAlarmValue.hour,
        thirdAlarmValue.minute));

    Widget fourthRow = buildStandardContainer(
      Row(
        children: [
          FloatingActionButton(
            onPressed: _updateClocks,
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
