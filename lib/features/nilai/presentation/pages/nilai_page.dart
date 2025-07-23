import 'package:flutter/material.dart';
import 'package:newsistime/custom_widgets/appbarcustom.dart';
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
        appBar: AppBarCustom(
          isTextRich: true,
          tabBar: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'KRS'),
              Tab(text: 'KHS'),
              Tab(text: 'PAM'),
            ],
          ),
          
        ),
        body: TabBarView(children: [KrsPage(), KhsPage(), PamPage()]),
      ),
    );
  }
}
