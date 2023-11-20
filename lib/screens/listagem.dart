import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FirebaseListScreen extends StatefulWidget {
  @override
  _FirebaseListScreenState createState() => _FirebaseListScreenState();
}

class Despesa {
  String nome;
  String descricao;
  double valor;
  String data;

  Despesa({
    required this.nome,
    required this.descricao,
    required this.valor,
    required this.data,
  });
}

class _FirebaseListScreenState extends State<FirebaseListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('custo').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Despesa> despesas = snapshot.data!.docs.map((doc) {
              return Despesa(
                nome: doc['nome'],
                descricao: doc['descrição'],
                valor: doc['valor'].toDouble(),
                data: doc['data'],
              );
            }).toList();

            return ListView.builder(
              itemCount: despesas.length,
              itemBuilder: (context, index) {
                Despesa despesa = despesas[index];
                final formattedValor =
                    NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                        .format(despesa.valor);
                return ListTile(
                  title: Text(despesa.nome),
                  subtitle: Text(despesa.descricao + " - " + despesa.data),
                  trailing: Text(formattedValor),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
