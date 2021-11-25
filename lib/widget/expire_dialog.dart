import 'package:flutter/material.dart';

import '../model/expire.dart';

class ExpireDialog extends StatefulWidget {
  final Expire expire;
  final Function(String name, String date) onClickedDone;

  const ExpireDialog({
    Key key,
    this.expire,
    this.onClickedDone,
  }) : super(key: key);

  @override
  _ExpireDialogState createState() => _ExpireDialogState();
}

class _ExpireDialogState extends State<ExpireDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.expire != null) {
      final expire = widget.expire;

      nameController.text = expire.name;
      dateController.text = expire.date;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.expire != null;
    final title = isEditing ? 'Edit Expiration' : 'Add Expiration';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildDate(),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
    controller: nameController,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Enter Name',
    ),
    validator: (name) =>
    name != null && name.isEmpty ? 'Enter a name' : null,
  );

  Widget buildDate() => TextFormField(
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Enter Date',
    ),
    validator: (date) => date != null && !RegExp(r'(\d{4}-?\d\d-?\d\d)').hasMatch(date) ? 'Enter date in the format yyyy-mm-dd' : null,
    controller: dateController,
  );



  Widget buildCancelButton(BuildContext context) => TextButton(
    child: Text('Cancel'),
    onPressed: () => Navigator.of(context).pop(),
  );

  Widget buildAddButton(BuildContext context, {bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState.validate();

        if (isValid) {
          final name = nameController.text;
          final date = dateController.text;

          widget.onClickedDone(name, date);

          Navigator.of(context).pop();
        }
      },
    );
  }
}