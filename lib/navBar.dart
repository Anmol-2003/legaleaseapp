import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: MediaQuery.sizeOf(context).width * 0.6,
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 75, 83, 241),
                    boxShadow:  [
                      BoxShadow(blurRadius: 0.5, color: Colors.black45)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Theme.of(context).primaryColor,
                      backgroundImage:
                          const AssetImage("assets/anmol.jpg"),
                    ),
                    const SizedBox(height: 10,),
                    const Text("Anmol Bhardwaj", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                  ],
                )),
            ListTile(
              title: const Text(
                "History",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                "Settings",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              onTap: () {},
            ),
          ],
        ));
  }
}
