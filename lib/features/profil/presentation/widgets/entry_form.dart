import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EntryForm extends StatelessWidget {
  const EntryForm({
    super.key,
    required this.title,
    this.isDate = false,
    this.label,
    required TextEditingController controller,
    this.isDropDown = false,
  }) : _controller = controller;

  final String title;
  final bool isDropDown;
  final String? label;
  final bool isDate;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    Future<void> selectedDate() async {
      DateTime initialDate;
      try {
        initialDate =
            DateFormat('dd MMMM yyyy', 'id_ID').parse(_controller.text);
      } catch (e) {
        initialDate = DateTime.now();
      }
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (pickedDate != null) {
        _controller.text =
            DateFormat('dd MMMM yyyy', 'id_ID').format(pickedDate);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          if (isDropDown)
            DropdownButton<String>(
              items: <String>['Item 1', 'Item 2', 'Item 3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {},
            )
          else
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextField(
                controller: _controller,
                maxLines: 1,
                readOnly: isDate ? true : false,
                decoration: InputDecoration(
                  label: Text(isDate ? 'Tanggal Lahir' : label ?? ''),
                  suffixIcon: isDate ? const Icon(Icons.calendar_today) : null,
                ),
                onTap: () {
                  _controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: _controller.text.length),
                  );
                  if (isDate) {
                    selectedDate();
                  }
                },
                
                
              ),
            ),
        ],
      ),
    );
  }
}
