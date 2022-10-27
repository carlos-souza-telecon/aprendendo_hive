import 'package:aprendendo_hive/models/pessoa.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var pessoasBox = Hive.box<Pessoa>('pessoas');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pessoas'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ElevatedButton(
            onPressed: () {
              //pessoasBox.deleteFromDisk();
              var novaPessoa = Pessoa(
                nome: 'Ronaldinho',
                idade: 99,
              );
              setState(() {
                pessoasBox.put(novaPessoa.id, novaPessoa);
              });
            },
            child: Text('Cadastrar Pessoa'),
          ),
          for (int i = 0; i < pessoasBox.length; i++)
            InkWell(
              onTap: () {
                setState(() {
                  var pessoa = pessoasBox.getAt(i);
                  pessoa?.nome = 'Ronaldo';
                  pessoa?.save();
                });
              },
              onLongPress: () {
                setState(() {
                  var pessoa = pessoasBox.getAt(i);
                  pessoasBox.delete(pessoa!.id);
                });
              },
              child: ListTile(
                title: Text(
                  '${pessoasBox.getAt(i)?.nome}',
                ),
                subtitle: Text(
                  '${pessoasBox.getAt(i)?.id}',
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
