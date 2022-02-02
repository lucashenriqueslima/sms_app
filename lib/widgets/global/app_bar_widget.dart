import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget({Key? key, required this.title, this.showBackButton = true})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  final String title;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryVariant,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary, //change your color here
        ),
        elevation: 1,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
    );
  }
}
