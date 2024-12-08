import 'package:flutter/material.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.primaryColor, context.secondaryHeaderColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("Eslam Kamel"),
              accountEmail: Text("eslam@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://via.placeholder.com/150"),
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            _createDrawerItem(
              context,
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _createDrawerItem(
              context,
              icon: Icons.settings,
              text: 'Settings',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _createDrawerItem(
              context,
              icon: Icons.contact_mail,
              text: 'Contact Us',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(color: Colors.white70),
            ListTile(
              title: const Text('About', style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.info, color: context.secondaryHeaderColor),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem(BuildContext context,
      {required IconData icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Text(text, style: const TextStyle(color: Colors.white)),
      leading: Icon(icon, color: context.secondaryHeaderColor),
      onTap: onTap,
    );
  }
}
