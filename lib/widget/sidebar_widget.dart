import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/global_constant.dart';
import 'package:lost_and_found/page/previous_reports_page.dart';
import 'package:lost_and_found/page/main_profile_page.dart';
import 'package:lost_and_found/page/notifications_page.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

User? _user;

class SidebarWidget extends StatelessWidget {
  SidebarWidget(User? curruser) {
    _user = curruser;
  }
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final urlImage = _user?.photoURL != null
        ? _user?.photoURL
        : 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Drawer(
      child: Material(
        color: GlobalResource.BLUE_COLOUR,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage.toString(),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Divider(color: Colors.white70),
                ],
              ),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'Profile',
                    icon: TablerIcons.user,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Previous Reports',
                    icon: TablerIcons.history,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Notifications',
                    icon: TablerIcons.bell,
                    onClicked: () => selectedItem(context, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
  }) =>
      InkWell(
        child: Container(
          padding: const EdgeInsets.fromLTRB(115.0, 40.0, 0.0, 0.0),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Spacer(),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainProfilePage(_user),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PreviousReportsPage(_user),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NotificationsPage(),
        ));
        break;
    }
  }
}
