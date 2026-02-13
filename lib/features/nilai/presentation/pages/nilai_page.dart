import 'package:flutter/material.dart';
import 'package:newsistime/custom_widgets/appbarcustom.dart';
import 'package:newsistime/features/khs/presentation/pages/khs_page.dart';
import 'package:newsistime/features/krs/presentation/pages/krs_page.dart';
import 'package:newsistime/features/pam/presentation/pages/pam_page.dart';
import 'package:newsistime/features/transkrip/presentation/pages/transkrip_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/features/krs/presentation/bloc/krs_bloc.dart';
import 'package:newsistime/injection.dart';

class NilaiPage extends StatelessWidget {
  const NilaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBarCustom(
          isTextRich: true,
          tabBar: TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'KRS'),
              Tab(text: 'KHS'),
              Tab(text: 'TRANSKRIP'),
              Tab(text: 'PAM'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider.value(
              value: myInjection<KrsBloc>(),
              child: const KrsPage(),
            ),
            KhsPage(),
            TranskripPage(),
            PamPage(),
          ],
        ),
      ),
    );
  }
}
