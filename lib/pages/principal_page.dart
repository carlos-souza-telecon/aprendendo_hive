import 'package:aprendendo_hive/models/pessoa.dart';
import 'package:aprendendo_hive/pages/cadastrar_pessoa_page.dart';
import 'package:aprendendo_hive/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  var _pessoasBox = Hive.box<Pessoa>('pessoas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pessoas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var novaPessoa = await push(context, CadastrarPessoaPage());
          if (novaPessoa != null) {
            setState(() {
              _pessoasBox.add(novaPessoa);
            });
          }
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _cadastrarRonaldo,
              child: Text(
                'Cadastrar Ronaldo',
              ),
            ),
            for (var widgetPessoa in _pesquisarPessoas()) widgetPessoa,
          ],
        ),
      ),
    );
  }

  void _cadastrarRonaldo() {
    var novaPessoa = Pessoa('Ronaldo', 46);
    setState(() {
      _pessoasBox.add(novaPessoa);
    });
  }

  List<Widget> _pesquisarPessoas() {
    //Assim que abre uma lista no flutter
    List<Widget> widgetsPessoas = <Widget>[];

    for (int i = 0; i < _pessoasBox.length; i++) {
      var pessoa = _pessoasBox.getAt(i);

      widgetsPessoas.add(
        //continuar inkwell
        InkWell(
          onLongPress: () {
            setState(() {
              _pessoasBox.deleteAt(i);
            });
          },
          onTap: () async {
            var pessoaAlterada = await push(context, CadastrarPessoaPage());
            if (pessoaAlterada != null) {
              setState(() {
                _pessoasBox.putAt(i, pessoaAlterada);
              });
            }
          },
          child: ListTile(
            title: Text('${i + 1} - ${pessoa?.nome}'),
            subtitle: Text('${pessoa?.idade}'),
          ),
        ),
      );
    }

    return widgetsPessoas;
  }
}
