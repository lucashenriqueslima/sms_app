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
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        leading: showBackButton != true
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Center(
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    onTap: () => Navigator.pop(context),
                    child: Stack(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
