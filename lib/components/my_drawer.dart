import 'package:flutter/material.dart';
import 'package:note_app/WeatherPage.dart';
import 'package:note_app/components/drawer_tile.dart';
import 'package:note_app/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        children: [
          DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                "Note App",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          DrawerTile(
            title: "Notes",
            leading: const Icon(Icons.home),
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            title: "Settings",
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingPage()),
              );
            },
          ),
          DrawerTile( // เพิ่ม Weather Tile
            title: "Weather",
            leading: const Icon(Icons.wb_sunny),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WeatherPage()), // ลิงก์ไปยัง WeatherPage
              );
            },
          ),
        ],
      ),
    );
  }
}
