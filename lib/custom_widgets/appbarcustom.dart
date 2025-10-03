import 'package:flutter/material.dart';
import 'package:newsistime/core/theme/theme.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final bool isTextRich;
  final String title;
  final List<Widget>? action;
  final TabBar? tabBar;
  final bool isShowBackButton; // Default value is true, can be overridden
  final Widget? leading;
  const AppBarCustom({
    super.key,
    this.isTextRich = false,
    this.title = '',
    this.action,
    this.tabBar,
    this.isShowBackButton = false,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isTextRich
          ? RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Image.asset(
                      'images/logo_stmik.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                  WidgetSpan(
                    child: SizedBox(width: 8),
                  ), // Spacing between logo and text
                  TextSpan(
                    text: 'STMIK',
                    style: Theme.of(context).appBarTheme.titleTextStyle
                        ?.copyWith(fontWeight: FontWeight.w200),
                  ),
                  TextSpan(
                    text: ' TIME',
                    style: Theme.of(context).appBarTheme.titleTextStyle
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          : Text(title),
      actions: action,
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? AppTheme.surfaceDarkColorA0 :Colors.white,
         
        ), child: tabBar),
      ),
      leading: isShowBackButton ? leading : null,
    );
  }

  @override
  Size get preferredSize {
    if (tabBar != null) {
      return Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
    }
    return Size.fromHeight(kToolbarHeight);
  }
}
