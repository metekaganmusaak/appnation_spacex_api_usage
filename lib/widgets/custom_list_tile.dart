import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile({
    Key? key,
    required this.title,
    required this.trailing,
    this.isImage = false,
  }) : super(key: key);

  final String title;
  final String trailing;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: isImage ? Image.network(trailing) : Text(trailing),
    );
  }
}
