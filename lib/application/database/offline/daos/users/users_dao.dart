import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../tables/users.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  final AppDatabase db;

  UsersDao(this.db) : super(db);

  // stream all users
  Stream<List<User>> watchAllUsers() => select(users).watch();

  Future<int> insertUser(Map<String, dynamic> user) => into(users).insert(
        UsersCompanion(
          name: Value(user['name']),
          username: Value(user['username']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future updateUser(User user) => update(users).replace(user);

  Future deleteUser(User user) => delete(users).delete(user);
}
