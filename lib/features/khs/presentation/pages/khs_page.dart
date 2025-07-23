import 'package:flutter/material.dart';

class KhsPage extends StatelessWidget {
  const KhsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FittedBox(
        child: DataTable(
          columnSpacing: 5,
          dataTextStyle: Theme.of(context).dataTableTheme.dataTextStyle?.copyWith(
            fontSize: 20
          ),
          headingTextStyle: Theme.of(context).dataTableTheme.headingTextStyle?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          dataRowMinHeight: 40,
          dataRowMaxHeight: 60,
          columns: [
            DataColumn(label: Text('No')),
            DataColumn(label: Text('Tahun Ajaran')),
            DataColumn(label: Text('Semester')),
            DataColumn(label: Text('IPK Semester'),),
            DataColumn(label: Text('Aksi', ),headingRowAlignment: MainAxisAlignment.end),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Text('1')),
                DataCell(Text('2023/2024')),
                DataCell(Text('6')),
                DataCell(Text('4.00'),),
                DataCell(
                  Row(
                    children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                      IconButton(icon: Icon(Icons.print), onPressed: () {}),
                    ],
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('1')),
                DataCell(Text('2023/2024')),
                DataCell(Text('7')),
                DataCell(Text('4.00')),
                DataCell(
                  Row(
                    children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                      IconButton(icon: Icon(Icons.print), onPressed: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
