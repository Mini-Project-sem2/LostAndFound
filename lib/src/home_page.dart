import 'package:flutter/material.dart';
import 'package:lost_and_found/src/lost_form.dart';
import 'package:lost_and_found/src/found_form.dart';
import 'package:lost_and_found/services/authservice.dart';
import 'package:lost_and_found/utils/user.dart';
import 'package:lost_and_found/widget/sidebar_widget.dart';



Color blueColor = Color(0xFF1167b1);
User? user;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
         drawer:SidebarWidget(),
          appBar:AppBar(
            //automaticallyImplyLeading: true,
            backgroundColor: Colors.blueAccent,
            /*leading: IconButton(
              icon: Icon(
                Icons.home_filled, 
                color: Color(0xFFf5f5f5)
                ),
              onPressed: () => Scaffold.of(context).openDrawer(),
              ),*/
            title: Text(
              'Home page',   
            ),
            centerTitle: true,
            titleSpacing: 10,
            actions: <Widget>[
              Tooltip(
                  message: "logout",
                  triggerMode: TooltipTriggerMode.longPress,
                  child: TextButton.icon(
                    onPressed: () {
                      AuthService().signOut();
                    },
                    icon: Icon(
                      Icons.login_outlined,
                      color: Color(0xFFf5f5f5),
                    ),
                    label: Text(''),
                  )) 
            ]  ), 
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LostForm()));
            },
            child: Container(
                padding: new EdgeInsets.fromLTRB(50, 10, 50, 10),
                height: 50,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Colors.blueAccent,
                    color: blueColor,
                    elevation: 7.0,
                    child: Center(
                        child: Text('Lost',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => FoundForm()));
            },
            child: Container(
                padding: new EdgeInsets.fromLTRB(50, 10, 50, 10),
                height: 50,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Colors.blueAccent,
                    color: blueColor,
                    elevation: 7.0,
                    child: Center(
                        child: Text('Found',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
        ]));
  }

  getProfile() {
    if (user != null && User.dpexist()) {
      return Icon(
        Icons.home_filled,
        color: Color(0xFFf5f5f5),
      );
    } else {
      return Image.network("");
    }
  }
}
