import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';

class SettingMenuTile extends StatelessWidget {
  const SettingMenuTile(
     {
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.onTap,
    this.trailing,
  });
  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: TColors.primary,
      ),
      title: Text(title),
      subtitle: Text(subTitle),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
