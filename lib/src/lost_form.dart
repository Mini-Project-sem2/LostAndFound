import 'package:flutter/material.dart';

class LostForm extends StatelessWidget {
  const LostForm({Key? key}) : super(key: key);

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
  String dropdownValue = "government ids & certificate";
  List<String> _itemset = [
    "Electronic items",
    "government ids & certificate",
    "Expensive items",
    "Bag",
    "Book",
    "pet"
  ];

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
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
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
                  child: TextField(
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

                // Date
                Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon: Icon(Icons.calendar_today),
                        labelText: 'Date',
                        hintText: "Date",
                      ),
                      onTap: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2022));
                      },
                    )),

                // Starting location
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Starting location',
                      hintText: 'starting point',
                    ),
                  ),
                ),

                // ending location
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Ending location',
                      hintText: 'ending point',
                    ),
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
                      onPressed: () {},
                    )),
              ],
            ))));
  }
}
