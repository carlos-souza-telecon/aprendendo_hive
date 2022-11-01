import 'package:aprendendo_hive/models/pessoa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CadastrarPessoaPage extends StatefulWidget {
  const CadastrarPessoaPage({super.key});

  @override
  State<CadastrarPessoaPage> createState() => _CadastrarPessoaPageState();
}

class _CadastrarPessoaPageState extends State<CadastrarPessoaPage> {
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _formPessoaKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Pessoa'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formPessoaKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                  ),
                  validator: _nomeValidator,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _idadeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Idade',
                  ),
                  validator: _idadeValidator,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formPessoaKey.currentState!.validate()) {
                    var nome = _nomeController.text;
                    var idade = int.parse(_idadeController.text);
                    var pessoa = Pessoa(nome, idade);
                    Navigator.pop(context, pessoa);
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _nomeValidator(String? nomeDigitado) {
    if (nomeDigitado != null && nomeDigitado!.length >= 3) return null;
    return 'O nome deve ter pelo menos 3 caracteres.';
  }

  String? _idadeValidator(String? idadeDigitada) {
    try {
      int idade = int.parse(idadeDigitada!);
      if (idade > 0) return null;
      return 'A idade deve ser maior que zero.';
    } catch (e) {
      return 'Idade inválida.';
    }
  }
}
