import 'package:chatapp/helper/helper_function.dart';
import 'package:chatapp/pages/Search_page.dart';
import 'package:chatapp/pages/auth/login_page.dart';
import 'package:chatapp/pages/profile_page.dart';
import 'package:chatapp/service/auth_service.dart';
import 'package:chatapp/service/database_service.dart';
import 'package:chatapp/widgets/Widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  String email = "";
  Stream? groups;
  String PhoneNumber = "";
  AuthService authService = new AuthService();
  @override
  void initState() {
    super.initState();
    GetUserDetails();
  }

  GetUserDetails() async {
    await HelperFunctions.getUserName().then((value) {
      setState(() {
        name = value;
      });
    });
    await HelperFunctions.getUseremail().then((value) {
      setState(() {
        email = value;
      });
    });
    await HelperFunctions.getUserNumber().then((value) {
      setState(() {
        PhoneNumber = value;
      });
    });
    //Getting All the user in stream
    await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .GetUserGroup()
        .then((value) {
      setState(() {
        groups = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(context, Search_page());
              },
              icon: Icon(Icons.search))
        ],
        title: Text(
          "Groups",
          style: TextStyle(
              fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey[700],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {},
              selected: true,
              selectedColor: Theme.of(context).primaryColor,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.group),
              title: Text(
                "Groups",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                nextScreenReplace(
                    context,
                    Profile_page(
                      name: name,
                      email: email,
                      phoneNumber: PhoneNumber,
                    ));
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.group),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Log out"),
                        content: Text("Are you sure you want to log out"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "cancel",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await authService.SignOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false);
                            },
                            child: Text(
                              "OK",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      );
                    });
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.exit_to_app),
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            popupDailog(context);
          },
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          )),
    );
  }

  popupDailog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Create a Groups",
              textAlign: TextAlign.left,
            ),
            content: Column(
              children: [],
            ),
          );
        });
  }

  groupList() {
    return StreamBuilder(
        stream: groups,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['groups'] != null) {
              if (snapshot.data['groups'].length > 0) {
                return Text("Hellp");
              } else {
                return NoGroupWidget();
              }
            } else {
              return NoGroupWidget();
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        });
  }

  NoGroupWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                popupDailog(context);
              },
              child: Icon(
                Icons.add_circle,
                color: Colors.grey[700],
                size: 75,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "You've not joined any groups, tap on add icon to create a group or you can also search from top search button.",
              textAlign: TextAlign.center,
              style: TextStyle(),
            )
          ]),
    );
  }
}
