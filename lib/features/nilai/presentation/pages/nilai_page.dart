import 'package:flutter/material.dart';
import 'package:sistime_portal/custom_widgets/appbarcustom.dart';
import 'package:sistime_portal/features/khs/presentation/bloc/khs_bloc.dart';
import 'package:sistime_portal/features/khs/presentation/pages/khs_page.dart';
import 'package:sistime_portal/features/krs/presentation/pages/krs_page.dart';
import 'package:sistime_portal/features/transkrip/presentation/pages/transkrip_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistime_portal/features/krs/presentation/bloc/krs_bloc.dart';
import 'package:sistime_portal/injection.dart';

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
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'KRS'),
              Tab(text: 'KHS'),
              Tab(text: 'TRANSKRIP'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider.value(
              value: myInjection<KrsBloc>(),
              child: const KrsPage(),
            ),
            BlocProvider.value(value: myInjection<KhsBloc>(), child: KhsPage()),
            TranskripPage(),
          ],
        ),
      ),
    );
  }
}
