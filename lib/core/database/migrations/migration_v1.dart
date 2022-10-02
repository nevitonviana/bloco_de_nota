import 'package:sqflite_common/sqlite_api.dart';

import 'migration.dart';

class MigrationV1 implements Migration {
  @override
  void crete(Batch batch) {
    batch.execute('''
    create table todo(
    id Integer primary key autoincrement,
    descricao varchar(500) not null,
    finalizado integer
    )
    ''');
  }

  @override
  void upgrade(Batch batch) {}
}
