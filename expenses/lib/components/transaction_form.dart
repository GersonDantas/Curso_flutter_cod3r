import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate;

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate ?? DateTime.now());
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      // print('dentro do then');
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });

    // print('fora do then');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitForm,
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm,
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    _selectedDate == null
                        ? 'Nenhuma data selecionada'
                        : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate!)}',
                  ),
                ),
                TextButton(
                  child: Text(
                    'Selecione a data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _showDatePicker,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  child: Text(
                    'Nova Transação',
                  ),
                  onPressed: _submitForm,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
