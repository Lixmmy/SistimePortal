import 'package:flutter/material.dart';
import 'package:newsistime/features/khs/presentation/pages/khs_page.dart';
import 'package:newsistime/features/krs/presentation/pages/krs_page.dart';
import 'package:newsistime/features/pam/presentation/pages/pam_page.dart';

class NilaiPage extends StatelessWidget {
  const NilaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: RichText(
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
                  child: SizedBox(width: 8), // Spacing between logo and text
                ),
                TextSpan(
                  text: 'STMIK',
                  style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                    fontWeight: FontWeight.w200,
                  ),
                ),
                TextSpan(
                  text: ' TIME',
                  style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: 'KRS'),
                  Tab(text: 'KHS'),
                  Tab(text: 'PAM'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(children: [KrsPage(), KhsPage(), PamPage()]),
      ),
    );
  }
}
