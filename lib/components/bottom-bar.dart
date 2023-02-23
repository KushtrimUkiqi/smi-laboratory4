import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../statics/routes.dart';

enum ItemType { logOutItem, itemTwo, itemThree }

class BottomBarComponent extends StatefulWidget {
  const BottomBarComponent({Key? key}) : super(key: key);

  @override
  State<BottomBarComponent> createState() => _BottomBarComponentState();
}

class _BottomBarComponentState extends State<BottomBarComponent> {
  ItemType? selectedMenu;

  Future<void> _logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer()),
          ),
          Spacer(),
          // IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          PopupMenuButton<ItemType>(
            initialValue: selectedMenu,
            // Callback that sets the selected popup menu item.
            onSelected: (ItemType item) {
              setState(() {
                selectedMenu = item;
                if(selectedMenu == ItemType.logOutItem)
                {
                  _logOut();
                }
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<ItemType>>[
              const PopupMenuItem<ItemType>(
                value: ItemType.logOutItem,
                child: Text('Log out'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
