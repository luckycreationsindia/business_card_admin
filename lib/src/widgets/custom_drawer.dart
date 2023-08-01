import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  final int selectedIndex;

  const CustomDrawer({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    TextStyle selectedTextStyle = const TextStyle(color: Color(0xFF41BBFF));
    Color selectedIconColor = const Color(0xFF41BBFF);

    return Drawer(
      backgroundColor: const Color(0xFF171B2D),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            height: 162,
            child: Column(
              children: [
                Image.asset("images/logo.png", height: 100),
                const Spacer(),
                const Text('Digital Business Card - Admin'),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.table_chart,
                    color: selectedIndex == 0 ? selectedIconColor : null,
                  ),
                  dense: selectedIndex != 0,
                  title: Text(
                    'Dashboard',
                    style: selectedIndex == 0 ? selectedTextStyle : null,
                  ),
                  selected: selectedIndex == 0,
                  onTap: () => context.go('/'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: selectedIndex == 1 ? selectedIconColor : null,
                  ),
                  dense: selectedIndex != 1,
                  title: Text(
                    'Add Customer',
                    style: selectedIndex == 1 ? selectedTextStyle : null,
                  ),
                  selected: selectedIndex == 1,
                  onTap: () => context.go('/add_customer'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: selectedIndex == 2 ? selectedIconColor : null,
                  ),
                  dense: selectedIndex != 2,
                  title: Text(
                    'Customer List',
                    style: selectedIndex == 2 ? selectedTextStyle : null,
                  ),
                  selected: selectedIndex == 2,
                  onTap: () => context.go('/list_customer'),
                ),
              ],
            ),
          ),
          const Divider(),
          const AboutListTile(
            dense: true,
            icon: Icon(Icons.account_balance_wallet_outlined),
          ),
        ],
      ),
    );
  }
}
