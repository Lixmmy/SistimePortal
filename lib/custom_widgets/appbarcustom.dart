import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final bool showArrowBack;
  final void Function()? onBackFunction;
  final List<Widget>? actions;
  const AppBarCustom({
    super.key,
    required this.title,
    this.onBackFunction,
    this.showArrowBack = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: showArrowBack
          ? IconButton(
              onPressed: onBackFunction,
              icon: Icon(Icons.arrow_back),
            )
          : Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
    actions: actions,
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
