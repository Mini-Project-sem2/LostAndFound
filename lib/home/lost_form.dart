import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/database/db_funtions.dart';
import 'package:lost_and_found/home/home_page.dart';
import 'package:date_format/date_format.dart';

User? _user;

class LostForm extends StatelessWidget {
  LostForm(User? result) {
    _user = result;
  }
  static const String _title = 'lost form';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text(_title)),
        body: const Center(
          child: LostFormWidget(),
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class LostFormWidget extends StatefulWidget {
  const LostFormWidget({Key? key}) : super(key: key);

  @override
  State<LostFormWidget> createState() => _LostFormWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _LostFormWidgetState extends State<LostFormWidget> {
  String _dropdownValue = "government ids & certificate";
  late String _dropdownValue1 = "Other";
  List<String> _itemset = [
    "Electronic items",
    "government ids & certificate",
    "Daily Accessories",
    "Bag",
    "Book",
    "pet"
  ];
  List<String> Electronic_items = ['Laptop', 'mobile', 'charger', 'Other'];
  List<String> Daily_Accessories = ['watch', 'footwear', 'umbrella', 'wallet', 'keys', 'Other'];
  List<String> sub_Category = ['Other'];

  TextEditingController _brandController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _timeController1 = TextEditingController();

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
                        if (newValue == 'Electronic items') {
                          sub_Category = Electronic_items;
                        } else if (newValue == 'Daily Accessories') {
                          sub_Category = Daily_Accessories;
                        } else {
                          sub_Category = [];
                        }
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
                  padding: const EdgeInsets.all(15),
                  // dropdown
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: DropdownButton<String>(
                      hint: Text('Select sub-category'),
                      value: _dropdownValue1,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      onChanged: (String? newValue1) {
                        setState(() {
                          _dropdownValue1 = newValue1!;
                        });
                      },
                      items: sub_Category
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
                      labelText: 'Brand name',
                      hintText: 'Enter Brand',
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
                            selectedDate = picked;
                            _dateController.text = selectedDate.day.toString() +
                                "/" +
                                selectedDate.month.toString() +
                                "/" +
                                selectedDate.year.toString();
                          });
                      },
                    )),

                Padding(
                  padding: EdgeInsets.only(left:15, top:15, right:15), //apply padding to three sides
                  child: Text("Lost between", textAlign: TextAlign.left,),
                ),
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

                
                Padding(
                  padding: EdgeInsets.all(15),
                    
                  child: TextField(
                    controller: _timeController1,
                    decoration: InputDecoration(
                      labelText: 'Time',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      prefixIcon: Icon(Icons.access_time),
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
                          _timeController1.text = _time;
                          _timeController1.text = formatDate(
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
                          try {
                            addReport(
                                _user,
                                _dropdownValue,
                                _brandController.text,
                                mycolor,
                                _descriptionController.text,
                                _dateController.text,
                                _timeController.text,
                                "lost");
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
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg:
                                    "lost form not submitted due to ${e.toString()}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.lightBlueAccent,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomePage(_user)));
                          }
                        })),
              ],
            ))));
  }
}
