import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color borderColor;
  final double elevation;

  CustomAppBar({
    required this.title,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.blue,
    this.elevation = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.blue,
      elevation: elevation,
      shape: Border(
        bottom: BorderSide(
          color: Colors.blue,
          width: 2.0,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}