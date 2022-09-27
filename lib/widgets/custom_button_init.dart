import 'package:flutter/cupertino.dart';
import '../theme/app_theme.dart';

class CustomButtonInit extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final TextStyle? style;
  const CustomButtonInit(
      {Key? key, required this.onPressed, required this.title, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      color: AppTheme.primaryColor,
      child: Text(
        title,
        style: style,
      ),
      // borderRadius: BorderRadius.circular(40),
    );
  }
}
