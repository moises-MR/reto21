import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const data = [
      {
        'title': '',
        'icon': Icons.abc,
      },
      {
        'title': '',
        'icon': Icons.abc,
      },
      {
        'title': '',
        'icon': Icons.abc,
      }
    ];
    return Scaffold(
        body: ListView.separated(
            padding: AppTheme.paddingGeneralPages,
            physics: AppTheme.physics,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {},
                title: Text('sdsd'),
                leading: Icon(Icons.notifications_active_outlined),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: data.length));
  }
}
