import 'package:sqflite/sqflite.dart';

abstract class Migration{
  void crete(Batch batch);
  void upgrade(Batch batch);
}