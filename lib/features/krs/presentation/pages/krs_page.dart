import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsistime/features/krs/presentation/bloc/krs_bloc.dart';

class KrsPage extends StatefulWidget {
  const KrsPage({super.key});

  @override
  State<KrsPage> createState() => _KrsPageState();
}

class _KrsPageState extends State<KrsPage> {
  @override
  void initState() {
    super.initState();
    // Assuming 'nim' is available here. For demonstration, I'm using a hardcoded value.
    // In a real app, you might get this from a user session, route arguments, etc.
    context.read<KrsBloc>().add(const FetchKrsData(nim: '1911003'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Rencana Studi'),
      ),
      body: BlocBuilder<KrsBloc, KrsState>(
        builder: (context, state) {
          if (state is KrsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is KrsError) {
            return Center(
              child: Text('Gagal memuat data: ${state.message}'),
            );
          } else if (state is KrsLoaded) {
            if (state.groupedKrs.isEmpty) {
              return const Center(child: Text('Tidak ada data KRS ditemukan.'));
            }
            // Get the sorted list of semesters
            final semesters = state.groupedKrs.keys.toList();

            return ListView.builder(
              itemCount: semesters.length,
              itemBuilder: (context, index) {
                final semester = semesters[index];
                final krsList = state.groupedKrs[semester]!;
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Text(
                      'Semester $semester',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    children: krsList.map((krs) {
                      return ListTile(
                        title: Text(krs.namaMatakuliah),
                        subtitle: Text(krs.kodeMatakuliah),
                        trailing: Text(krs.namaDosen),
                      );
                    }).toList(),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Silakan muat data KRS.'));
        },
      ),
    );
  }
}
