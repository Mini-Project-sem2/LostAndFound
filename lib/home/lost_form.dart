import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/database/db_funtions.dart';
import 'package:lost_and_found/home/home_page.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

User? _user;

class LostForm extends StatelessWidget {
  LostForm(User? result) {
    _user = result;
  }
  static const String _title = 'lost form';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String _dropdownValue = "government ids & certificate";
  List<String> _itemset = [
    "Electronic items",
    "government ids & certificate",
    "Expensive items",
    "Bag",
    "Book",
    "pet"
  ];
  TextEditingController _brandController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(1),
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  // dropdown
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: DropdownButton<String>(
                      value: _dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropdownValue = newValue!;
                        });
                      },
                      items: _itemset
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // brand name input field
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: _brandController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Name',
                      hintText: 'Enter Name',
                    ),
                  ),
                ),

                // color
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: _colorController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'color',
                      hintText: 'color of an object',
                    ),
                  ),
                ),

                // Description
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: _descriptionController,
                    minLines: 2,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Description',
                      hintText: 'Description',
                    ),
                  ),
                ),

                Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon: Icon(Icons.calendar_today),
                        labelText: 'Date',
                        hintText: "Date",
                      ),
                      onTap: () async {
                        DateTime selectedDate = DateTime.now();
                        final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            initialDatePickerMode: DatePickerMode.day,
                            firstDate: DateTime(2015),
                            lastDate: DateTime.now());
                        if (picked != null)
                          setState(() {
                            selectedDate = picked;
                            _dateController.text =
                                DateFormat.yMd().format(selectedDate);
                          });
                      },
                    )),

                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: _timeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      prefixIcon: Icon(Icons.access_time),
                      labelText: 'Time',
                      hintText: "Time",
                    ),
                    onTap: () async {
                      String _hour, _minute, _time;
                      TimeOfDay selectedTime = TimeOfDay.now();
                      final TimeOfDay? picked = await showTimePicker(
                          context: context, initialTime: selectedTime);
                      if (picked != null)
                        setState(() {
                          selectedTime = picked;
                          _hour = selectedTime.hour.toString();
                          _minute = selectedTime.minute.toString();
                          _time = _hour + ' : ' + _minute;
                          _timeController.text = _time;
                          _timeController.text = formatDate(
                              DateTime(2019, 08, 1, selectedTime.hour,
                                  selectedTime.minute),
                              [hh, ':', nn, " ", am]).toString();
                        });
                    },
                  ),
                ),

                // submit button
                Padding(
                    padding: EdgeInsets.all(15),
                    child: ElevatedButton(
                      child: Text(
                        "submit",
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Trueno'),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        elevation: 20,
                        minimumSize: Size(500, 50),
                        shadowColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        addLostData(
                            _user,
                            _dropdownValue,
                            _brandController.text,
                            _colorController.text,
                            _descriptionController.text,
                            _dateController.text,
                            _timeController.text);
                        Fluttertoast.showToast(
                            msg: "lost form is submitted",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.lightBlueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage(_user)));
                      },
                    )),
              ],
            ))));
  }
}
