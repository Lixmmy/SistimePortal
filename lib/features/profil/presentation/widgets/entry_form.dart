import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsistime/core/theme/theme.dart';

class EntryForm extends StatefulWidget {
  const EntryForm({
    super.key,
    required this.title,
    this.isDate = false,
    this.label,
    this.isReadOnly = false,
    required this.controller,
    this.isDropDown = false,
    this.dropdownItems,
    this.isLong = false,
  });

  final String title;
  final bool isDropDown;
  final List<String>? dropdownItems;
  final String? label;
  final bool isReadOnly;
  final bool isDate;
  final bool isLong;
  final TextEditingController controller;

  @override
  State<EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  @override
  Widget build(BuildContext context) {
    Future<void> selectedDate() async {
      DateTime initialDate;
      try {
        initialDate = DateFormat(
          'dd MMMM yyyy',
          'id_ID',
        ).parse(widget.controller.text);
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
        widget.controller.text = DateFormat(
          'dd MMMM yyyy',
          'id_ID',
        ).format(pickedDate);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(widget.title)),
          if (widget.isDropDown)
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.surfaceDarkColorA30
                      : Colors.black,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              width: MediaQuery.of(context).size.width * 0.6,
              child: DropdownButton<String>(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                borderRadius: BorderRadius.circular(5),
                underline: SizedBox.shrink(),
                isExpanded: true,
                value:
                    (widget.dropdownItems?.any(
                          (item) =>
                              item.toLowerCase() ==
                              widget.controller.text.toLowerCase(),
                        ) ??
                        false)
                    ? widget.dropdownItems!.firstWhere(
                        (item) =>
                            item.toLowerCase() ==
                            widget.controller.text.toLowerCase(),
                      )
                    : null,
                items: (widget.dropdownItems ?? [])
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    widget.controller.text = newValue!;
                  });
                },
              ),
            )
          else
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextField(
                controller: widget.controller,
                maxLines: widget.isLong ? 3 : 1,
                readOnly: widget.isReadOnly ? true : false,
                decoration: InputDecoration(
                  label: Text(
                    widget.isDate ? 'Tanggal Lahir' : widget.label ?? '',
                  ),
                  suffixIcon: widget.isDate
                      ? Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        )
                      : widget.isReadOnly
                      ? Icon(
                          Icons.lock,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        )
                      : null,
                ),
                onTap: () {
                  widget.controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: widget.controller.text.length),
                  );
                  if (widget.isDate) {
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
