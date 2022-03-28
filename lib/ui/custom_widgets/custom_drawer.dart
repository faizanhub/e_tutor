import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // color: Color(0xff333333),
        child: Column(children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 50.0,
                    child: Text(
                      'E',
                      style: TextStyle(fontSize: 35.0),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "E Tutor",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w800,
                      // color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Divider(
                    height: 1.0,
                    thickness: 1.0,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          //Now let's Add the button for the Menu
          //and let's copy that and modify it

          ListTile(
            onTap: () {
              // Navigator.pop(context);
            },
            leading: Icon(
              Icons.settings,
              // color: Colors.white,
            ),
            title: Text(
              "Settings",
            ),
          ),

          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.info,
              // color: Colors.white,
            ),
            title: Text(
              "About Us",
            ),
          ),

          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.help,
              // color: Colors.white,
            ),
            title: Text(
              "Help",
            ),
          ),
        ]),
      ),
    );
  }
}
