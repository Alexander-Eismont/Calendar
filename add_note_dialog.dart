import 'package:flutter/material.dart';

class AddNoteDialog extends StatefulWidget {
  final DateTime selectedDate;
  final void Function(String text, TimeOfDay time, bool notify) onSave;

  AddNoteDialog({required this.selectedDate, required this.onSave});

  @override
  _AddNoteDialogState createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  TextEditingController _textController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _notify = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Новая заметка"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: "Текст заметки"),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Время: ${_selectedTime.format(context)}"),
                TextButton(
                  onPressed: () async {
                    TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime,
                    );
                    if (picked != null) {
                      setState(() => _selectedTime = picked);
                    }
                  },
                  child: Text("Выбрать"),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _notify,
                  onChanged: (val) => setState(() => _notify = val!),
                ),
                Text("Напоминание"),
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Отмена"),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSave(
              _textController.text.trim(),
              _selectedTime,
              _notify,
            );
            Navigator.of(context).pop();
          },
          child: Text("Сохранить"),
        )
      ],
    );
  }
}