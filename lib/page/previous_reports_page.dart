import 'package:flutter/material.dart';
<<<<<<< HEAD

class PreviousReportsPage extends StatelessWidget {
=======
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/page/lost_reports_page.dart';
import 'package:lost_and_found/page/found_reports_page.dart';

User? _user;

class PreviousReportsPage extends StatelessWidget {
  PreviousReportsPage(User? user) {
    _user = user;
  }

>>>>>>> 48b142eb6f37215b1c2a69d9996768ca85f4a42e
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Your Previous Reports'),
          centerTitle: true,
<<<<<<< HEAD
          backgroundColor: Colors.red,
        ),
      );
=======
          backgroundColor: Colors.blueAccent,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 150),
            Padding(
                padding: EdgeInsets.all(0.0),
                child: ElevatedButton(
                  child: Text(
                    "Lost Reports",
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
                  onPressed: () => selectedItem(context, 0),
                )),
            const SizedBox(height: 42),
            Padding(
                padding: EdgeInsets.all(0.0),
                child: ElevatedButton(
                  child: Text(
                    "Found Reports",
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
                  onPressed: () => selectedItem(context, 1),
                )),
          ],
        ),
      );

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LostReportsPage(_user),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FoundReportsPage(_user),
        ));
        break;
    }
  }
>>>>>>> 48b142eb6f37215b1c2a69d9996768ca85f4a42e
}
