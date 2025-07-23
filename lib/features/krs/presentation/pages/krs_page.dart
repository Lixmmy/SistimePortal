import 'package:flutter/material.dart';

class KrsPage extends StatelessWidget {
  const KrsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FittedBox(
        child: DataTable(
          columnSpacing: 10,
          dataRowMinHeight: 40,
          dataRowMaxHeight: 50,
          columns: [
            DataColumn(label: Text('Tahun Ajaran')),
            DataColumn(label: Text('Semester')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Aksi')),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Text('2023/2024')),
                DataCell(Text('Ganjil')),
                DataCell(Text('Aktif')),
                DataCell(IconButton(icon: Icon(Icons.edit), onPressed: () {})),
              ],
            ),
             DataRow(
              cells: [
                DataCell(Text('2023/2024')),
                DataCell(Text('Ganjil')),
                DataCell(Text('Aktif')),
                DataCell(IconButton(icon: Icon(Icons.edit), onPressed: () {})),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
