import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuAnchorExample extends StatefulWidget {
  const MenuAnchorExample({super.key});

  @override
  State<MenuAnchorExample> createState() => _MenuAnchorExampleState();
}

class _MenuAnchorExampleState extends State<MenuAnchorExample> {
  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return IconButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            icon: const Icon(Icons.more_horiz),
            tooltip: 'Settings for your Help Request',
          );
        },
        menuChildren: <Widget>[
          MenuItemButton(
            leadingIcon: const Icon(Icons.edit),
            child: Text('Edit', style: TextStyle()),
            onPressed: () => context.go('/home/help-request-form'),
          ),
          MenuItemButton(
            leadingIcon: const Icon(Icons.delete),
            child: Text('Delete', style: TextStyle()),
            onPressed: () => context.go('/home/help-request-form'),
          ),
        ]);
  }
}
