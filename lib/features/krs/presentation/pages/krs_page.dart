import 'package:flutter/material.dart';
import 'package:newsistime/custom_widgets/form_alert.dart';

class KrsPage extends StatelessWidget {
  const KrsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FittedBox(
        child: DataTable(
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
                DataCell(IconButton(icon: Icon(Icons.edit), onPressed: () {
                  showDialog(context: context, builder: (BuildContext context){
                    return FormAlert();
                  });
                })),
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
