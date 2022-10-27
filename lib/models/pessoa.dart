import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'pessoa.g.dart';

@HiveType(typeId: 1)
class Pessoa extends HiveObject {
  @HiveField(0)
  String? nome;
  @HiveField(1)
  int? idade;
  @HiveField(2)
  String? id = Uuid().v4();

  Pessoa({this.nome, this.idade});
}
