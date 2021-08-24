import 'package:cadastro_de_alunos/models/student.dart';
import 'package:cadastro_de_alunos/models/db_local.dart';
import 'package:cadastro_de_alunos/repository/student/student_repository.dart';
import 'package:sqflite/sqflite.dart';

class StudentDBRepository implements StudentRepository {
  @override
  late DBLocal dbLocal;

  StudentDBRepository() {
    dbLocal = DBLocal(
      table: "students",
    );
  }

  @override
  Future<Student> find(int id) async {
    Database database = await dbLocal.getConnection();
    var data = await database.query(
      dbLocal.table,
      where: "id=",
      whereArgs: [id],
    );
    database.close();
    return Student.fromMap(data.first);
  }

  @override
  Future<List<Student>> findAll() async {
    Database database = await dbLocal.getConnection();
    var data = await database.query(
      dbLocal.table,
    );
    database.close();
    return data.map((student) => Student.fromMap(student)).toList();
  }

  @override
  Future<int> insert(Student entity) async {
    Database database = await dbLocal.getConnection();
    int result = await database.insert(dbLocal.table, entity.toMap());
    database.close();
    return result;
  }

  @override
  Future<int> remove({
    required String conditions,
    required List conditionValues,
  }) async {
    Database database = await dbLocal.getConnection();
    int result = await database.delete(
      dbLocal.table,
      where: conditions,
      whereArgs: conditionValues,
    );
    database.close();
    return result;
  }

  @override
  Future<int> update({
    required Student entity,
    required String conditions,
    required List conditionValues,
  }) async {
    Database database = await dbLocal.getConnection();
    int result = await database.update(
      dbLocal.table,
      entity.toMap(),
      where: conditions,
      whereArgs: conditionValues,
    );
    database.close();
    return result;
  }
}
