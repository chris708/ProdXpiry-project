import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:food_app/boxes.dart';
import 'package:food_app/model/expire.dart';
import 'package:food_app/widget/expire_dialog.dart';
import 'package:intl/intl.dart';

class ExpirePage extends StatefulWidget {
  @override
  _ExpirePageState createState() => _ExpirePageState();
}

class _ExpirePageState extends State<ExpirePage> {

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('ProdXpiry'),
      centerTitle: true,
      backgroundColor: Color(0xff3cae70),
    ),
    body: ValueListenableBuilder<Box<Expire>>(
      valueListenable: Boxes.getExpiration().listenable(),
      builder: (context, box, _) {
        final expiration = box.values.toList().cast<Expire>();

        return buildContent(expiration);
      },
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Color(0xff3cae70),
      child: Icon(Icons.add),
      onPressed: () => showDialog(
        context: context,
        builder: (context) => ExpireDialog(
          onClickedDone: addExpiration,
        ),
      ),
    ),
  );

  Widget buildContent(List<Expire> expiration) {
    if (expiration.isEmpty) {
      return Center(
        child: Text(
          'No items yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {

      return Column(
        children: [
          SizedBox(height: 24),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: expiration.length,
              itemBuilder: (BuildContext context, int index) {
                final expiration1 = expiration[index];

                return buildExpiration(context, expiration1);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildExpiration(
      BuildContext context,
      Expire expiration1,
      ) {
    final color = DateTime.parse(expiration1.date).difference(DateTime.now()).inDays>=0 ? DateTime.parse(expiration1.date).difference(DateTime.now()).inDays>=10 ? Colors.green : Colors.yellow  : Colors.red;
    final date1 = DateFormat.yMMMd().format(expiration1.createdDate);
    final date = DateTime.parse(expiration1.date).difference(DateTime.now()).inDays.toString() + ' days';

    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          expiration1.name,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(date1),
        trailing: Text(
          date,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          buildButtons(context, expiration1),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Expire expiration1) => Row(
    children: [
      Expanded(
        child: TextButton.icon(
          label: Text('Edit'),
          icon: Icon(Icons.edit),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ExpireDialog(
                expire: expiration1,
                onClickedDone: (name, date) =>
                    editExpiration(expiration1, name, date),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: TextButton.icon(
          label: Text('Delete'),
          icon: Icon(Icons.delete),
          onPressed: () => deleteExpiration(expiration1),
        ),
      )
    ],
  );

  Future addExpiration(String name, String date) async {
    final expiration1 = Expire()
      ..name = name
      ..createdDate = DateTime.now()
      ..date = date;

    final box = Boxes.getExpiration();
    box.add(expiration1);
  }

  void editExpiration(
      Expire expiration1,
      String name,
      String date,
      ) {
    expiration1.name = name;
    expiration1.date = date;

    expiration1.save();
  }

  void deleteExpiration(Expire expiration1) {

    expiration1.delete();

  }
}