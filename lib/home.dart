import 'package:flutter/material.dart';
import 'expense.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double balance=0.0;
  double amount = 0.0;
  String name = '';
  String type ='null';
  List<Expense> E = [];
  bool show = false;



  void updateAmount(String s) {
    setState(() {
      amount = double.parse(s);
    });
  }

  void updateName(String s) {
    setState(() {
      name = s.trim();
    });
  }

  void updateType(String s) {
    setState(() {
      type = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Balance: $balance"),
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const Text("Transaction: "),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Name: "),
                  MyTextField(
                    f: updateName,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Amount: "),
                  MyTextField(
                    f: updateAmount,
                  ),
                ],
              ),
              MyRadio(
                value1: 'income',
                value2: 'expense',
                groupValue: type,
                change: updateType,
              ),
              AddButton(
                  n: name,
                  t: type,
                  a: amount,
                  E: E,
                  f: (){setState(() {
                    balance += (type == 'income' ? amount : -amount);
                    show=true;
                  });}
              ),
              if(show)
                Expanded(child: MyTable(E: E))
            ],
          ),
        ));
  }
}

class MyRadio extends StatefulWidget {
  final String value1;
  final String value2;
  final dynamic groupValue;
  final Function change;


  const MyRadio({
    required this.change,
    required this.value1,
    required this.value2,
    required this.groupValue,
    super.key,
  });

  @override
  State<MyRadio> createState() => _MyRadioState();
}

class _MyRadioState extends State<MyRadio> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
                value: widget.value1,
                groupValue: widget.groupValue,
                onChanged: (value) {
                  widget.change(value);
                }),
            Text(widget.value1)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
                value: widget.value2,
                groupValue: widget.groupValue,
                onChanged: (value) {
                  widget.change(value);
                }),
            Text(widget.value2)
          ],
        )
      ],
    );
  }
}

class AddButton extends StatelessWidget {
  final String n;
  final String t;
  final double a;
  final List<Expense> E;
  final Function f;

  const AddButton({
    required this.n,
    required this.t,
    required this.a,
    required this.E,
    required this.f,
    super.key,
  });

  void add(double x, String n, String t) {
    var expense = Expense(t, n, x);
    E.add(expense);
    //print(expense);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          add(a, n, t);
          f();
        },
        child: const Text("add"));
  }
}

class MyTextField extends StatelessWidget {
  final Function(String) f;

  const MyTextField({
    required this.f,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextField(
        onChanged: (text) {
          f(text);
        },
      ),
    );
  }
}

/*class MyTable extends StatelessWidget {
  final List<Expense> E;
  const MyTable({super.key,required this.E});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        const TableRow(
          children: [
            TableCell(child: Text('Type')),
            TableCell(child: Text('Name')),
            TableCell(child: Text('Amount')),
            TableCell(child: Text('Time')),
          ]
        ),
        ...E.map((exp){
          return TableRow(
            children: [
              TableCell(child: Text(exp.type)),
              TableCell(child: Text(exp.name)),
              TableCell(child: Text(exp.amount as String)),
              TableCell(child: Text(exp.time))
            ]
          );
        })
      ],
    );
  }
}*/

class MyTable extends StatefulWidget {
  final List<Expense> E;
  const MyTable({super.key,required this.E});

  @override
  State<MyTable> createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        const TableRow(
            children: [
              TableCell(child: Text('Type')),
              TableCell(child: Text('Name')),
              TableCell(child: Text('Amount')),
              TableCell(child: Text('Time')),
            ]
        ),
        ...widget.E.map((exp){
          Color backgroundColor = exp.type == 'income' ? Colors.green : Colors.red;
          return TableRow(
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              children: [

                TableCell(child: Text(exp.type),),
                TableCell(child: Text(exp.name)),
                TableCell(child: Text(exp.amount.toString())),
                TableCell(child: Text(exp.time))
              ]
          );
        })
      ],
    );
  }
}