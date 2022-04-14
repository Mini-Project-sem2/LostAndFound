import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/database/db_funtions.dart';
import 'package:lost_and_found/global_constant.dart';
import 'package:lost_and_found/home/home_page.dart';
import 'package:date_format/date_format.dart';
import 'package:lost_and_found/utils/formhelper.dart';

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
  String _categoryValue = "Pet";
  String _subCategoryValue = "other";
  List<String> _itemset = [
    "Electronic items",
    "Government ids & certificate",
    "Daily Accessories",
    "Pet"
  ];

  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();

  Color mycolor = Colors.lightBlue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(15),
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
                      isExpanded: true,
                      value: _categoryValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      onChanged: (String? newValue) {
                        setState(() {
                          _categoryValue = newValue!;
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
                      isExpanded: true,
                      hint: Text('Select sub-category'),
                      value: _subCategoryValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      onChanged: (String? newValue) {
                        setState(() {
                          _subCategoryValue = newValue!;
                        });
                      },
                      items: getsubcategory(_categoryValue)
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
                            _dateController.text = formatDate(
                                selectedDate, [yyyy, '-', mm, '-', dd]);
                          });
                      },
                    )),

                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          "   Select Time",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: _startTimeController,
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
                            _hour = '0' + _hour;
                          }
                          if (_minute.length == 1) {
                            _minute = '0' + _minute;
                          }
                          _time = _hour + ':' + _minute + ':' + '00';
                          _startTimeController.text = _time;
                        });
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: _endTimeController,
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
                            _hour = '0' + _hour;
                          }
                          if (_minute.length == 1) {
                            _minute = '0' + _minute;
                          }
                          _time = _hour + ':' + _minute + ':' + '00';
                          _endTimeController.text = _time;
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
                            _confirmDetails();
                            // addReport(
                            //     user: _user,
                            //     category: _categoryValue,
                            //     subcategory: _subCategoryValue,
                            //     color: mycolor,
                            //     description: _descriptionController.text,
                            //     date: _dateController.text,
                            //     time: _startTimeController.text,
                            //     endTime: _endTimeController.text,
                            //     collection: "lost");
                            // toast("lost form submitted");
                          } catch (e) {
                            toast(
                                "lost form not submitted due to ${e.toString()}"
                                    .toString());
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage(_user)));
                        })),
              ],
            ))));
  }

  void _confirmDetails() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Confirm Details'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                const SizedBox(height: 16),
                Text(
                  'Category: $_categoryValue',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  'Sub-Category: $_subCategoryValue',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  'Color: $mycolor',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  'Description: ${_descriptionController.text}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  'Date: ${_dateController.text}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  'Lost Between: ${_startTimeController.text} to ${_endTimeController.text}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: [
            new ElevatedButton(
                child: Text(
                  "Confirm",
                  style: TextStyle(color: Colors.white, fontFamily: 'Trueno'),
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
                        user: _user,
                        category: _categoryValue,
                        subcategory: _subCategoryValue,
                        color: mycolor,
                        description: _descriptionController.text,
                        date: _dateController.text,
                        time: _startTimeController.text,
                        endTime: _endTimeController.text,
                        collection: "lost");
                    toast("lost form submitted");
                  } catch (e) {
                    toast("lost form not submitted due to ${e.toString()}"
                        .toString());
                  }
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage(_user)));
                }),
            const SizedBox(height: 16),
            new ElevatedButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white, fontFamily: 'Trueno'),
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
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }
}
