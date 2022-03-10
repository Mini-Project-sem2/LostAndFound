import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/database/db_funtions.dart';
import 'package:lost_and_found/home/home_page.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

User? _userid;

class FoundForm extends StatelessWidget {
  FoundForm(User? result) {
    _userid = result;
  }

  static const String _title = 'Found form';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text(_title)),
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
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Color mycolor = Colors.lightBlue;

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

                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: _brandController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'name',
                      hintText: 'Enter name',
                    ),
                  ),
                ),

                // color
                Padding(
                  padding: EdgeInsets.all(15),
                  child: ElevatedButton(
                    child: Text(
                      "pick a colour",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(500, 50),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Pick a color!'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: mycolor, //default color
                                  onColorChanged: (Color color) {
                                    //on color picked
                                    setState(() {
                                      mycolor = color;
                                    });
                                  },
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('DONE'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
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
                            String _year, _month, _day;
                            _year = picked.year.toString();
                            _month = picked.month.toString();
                            _day = picked.day.toString();
                            if (_day.length == 1) {
                              _day = "0" + _day;
                            }
                            if (_month.length == 1) {
                              _month = "0" + _month;
                            }
                            _dateController.text = _year.toString() +
                                "-" +
                                _month.toString() +
                                "-" +
                                _day.toString();
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
                          if (_hour.length == 1) {
                            _hour = "0" + _hour;
                          }
                          if (_minute.length == 1) {
                            _minute = "0" + _minute;
                          }
                          _time = _hour + ':' + _minute + ':00';
                          _timeController.text = _time;
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
                        addReport(
                            _userid,
                            _dropdownValue,
                            _brandController.text,
                            mycolor,
                            _descriptionController.text,
                            _dateController.text,
                            _timeController.text,
                            "found");
                        Fluttertoast.showToast(
                            msg: "found form is submitted",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.lightBlueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage(_userid)));
                      },
                    )),
              ],
            ))));
  }
}
