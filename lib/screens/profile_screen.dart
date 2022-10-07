import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        'title': 'Usuario',
        'icon': Icons.supervised_user_circle,
      },
      {
        'title': 'Cuenta',
        'icon': Icons.mail,
      },
      {
        'title': 'Correo',
        'icon': Icons.album,
      },
    ];
    return Scaffold(
        body: ListView.separated(
            padding: AppTheme.paddingGeneralPages,
            physics: AppTheme.physics,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {},
                title: Text(data[index]['title']),
                leading: Icon(data[index]['icon']),
              );
            },
            separatorBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: const Divider(),
                ),
            itemCount: data.length));
  }
}
