import 'package:hive/hive.dart';

part 'pessoa.g.dart';

@HiveType(typeId: 1)
class Pessoa {
  @HiveField(0)
  String nome;

  @HiveField(1)
  int idade;

  Pessoa(this.nome, this.idade);
//quando for criar uma pessoa, precisa dar nome e idade(É o que isso está fazendo)
}
