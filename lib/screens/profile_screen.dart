import 'package:bajar_de_peso_21_dias/provider/state_global.dart';
import 'package:bajar_de_peso_21_dias/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> entrenamiento = [
      {
        'title': 'Recordatorio',
        'icon': Icons.notifications_active_outlined,
      },
      {
        'title': 'Opciones de sonido',
        'icon': Icons.volume_up_outlined,
      },
      {
        'title': 'Duracion de descanso',
        'icon': Icons.timer_outlined,
      },
    ];

    final List<Map<String, dynamic>> settings = [
      {
        'title': 'Mi perfil',
        'icon': Icons.account_circle_outlined,
      },
      {
        'title': 'Reiniciar progreso',
        'icon': Icons.replay_outlined,
      },
      {
        'title': 'Activar seguimiento de agua',
        'icon': Icons.local_drink_outlined,
      },
      {
        'title': 'Opciones de sonido',
        'icon': Icons.mic_none_outlined,
      },
    ];

    final List<Map<String, dynamic>> apoyanos = [
      {
        'title': 'Compartir con amigos',
        'icon': Icons.share_outlined,
      },
      {
        'title': 'Danos tus sugerencias',
        'icon': Icons.star_outline,
      },
      {
        'title': 'Casos de éxito',
        'icon': Icons.assistant_outlined,
      },
      {
        'title': 'Contáctanos',
        'icon': Icons.mail_outline,
      },
      {
        'title': 'Politica de privacidad',
        'icon': Icons.visibility_outlined,
      },
    ];

    return Scaffold(
        body: SingleChildScrollView(
      physics: AppTheme.physics,
      child: Container(
        padding: AppTheme.paddingGeneralPages,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _HeaderProfile(),
            const SizedBox(
              height: 22,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'ENTRENAMIENTO',
                style: TextStyle(color: AppTheme.primaryColor, fontSize: 16),
              ),
            ),
            ...entrenamiento
                .map((e) => ListTileWithDivider(
                      leading: Icon(e['icon']),
                      onTap: () {},
                      title: e['title'],
                    ))
                .toList(),
            const SizedBox(
              height: 22,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'AJUSTES GENERALES',
                style: TextStyle(color: AppTheme.primaryColor, fontSize: 16),
              ),
            ),
            ...settings
                .map((e) => ListTileWithDivider(
                      leading: Icon(e['icon']),
                      onTap: () {},
                      title: e['title'],
                    ))
                .toList(),
            const SizedBox(
              height: 22,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'AJUSTES GENERALES',
                style: TextStyle(color: AppTheme.primaryColor, fontSize: 16),
              ),
            ),
            ...apoyanos
                .map((e) => ListTileWithDivider(
                      leading: Icon(e['icon']),
                      onTap: () {},
                      title: e['title'],
                    ))
                .toList(),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Versión 0.0.5',
                  style: TextStyle(color: AppTheme.primaryColor, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class _HeaderProfile extends StatelessWidget {
  const _HeaderProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final elapseDays = Provider.of<StateGlobal>(context);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 7),
          height: 1,
          color: const Color.fromARGB(14, 0, 0, 0),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/SVG/girl_profile.svg',
                width: 50,
              ),
              // const SizedBox(width: 20,),
              _createColum(
                  title: 'Dia',
                  icon: Icons.bolt_outlined,
                  value: (Preferences.dayActive + 1).toString()),
              _createColum(
                  title: 'Calorias',
                  icon: Icons.local_fire_department_outlined,
                  value: '400'),
              _createColum(
                  title: 'Minutos', icon: Icons.timer_outlined, value: '190'),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 7),
          height: 1,
          color: const Color.fromARGB(14, 0, 0, 0),
        ),
      ],
    );
  }

  Column _createColum(
      {required String title, required IconData icon, required String value}) {
    return Column(
      children: [
        Icon(icon, size: 27, color: AppTheme.primaryColor),
        const SizedBox(
          height: 4,
        ),
        Text(
          value,
          style: const TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 32,
              fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: AppTheme.blackLight),
        )
      ],
    );
  }
}

class ListTileWithDivider extends StatelessWidget {
  const ListTileWithDivider({
    Key? key,
    required this.title,
    required this.leading,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Widget leading;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title: Text(title),
          leading: leading,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: const Divider(),
        )
      ],
    );
  }
}
