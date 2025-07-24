import 'package:flutter/material.dart';

class FormAlert extends StatelessWidget {
  const FormAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth * 0.8,
              maxHeight: constraints.maxHeight * 0.8,
            ),
            child: SingleChildScrollView(child: _buildForm(context)),
          );
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            child: DataTable(
              columns: [
                DataColumn(label: Text('Tahun Ajaran')),
                DataColumn(label: Text('Semester')),
                DataColumn(label: Text('Status')),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text('2023/2024')),
                    DataCell(Text('Ganjil')),
                    DataCell(Text('Aktif')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('2023/2024')),
                    DataCell(Text('Ganjil')),
                    DataCell(Text('Aktif')),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
