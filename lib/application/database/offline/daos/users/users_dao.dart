import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../models/user_model.dart';
import '../../tables/users.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  final AppDatabase db;

  UsersDao(this.db) : super(db);

  // stream all users
  Stream<List<UserModel>> watchAllUsers() =>
      select(users).map((user) => UserModel(user: user)).watch();

  Future<int> insertUser(Map<String, dynamic> user) =>
      into(users).insert(
        UsersCompanion(
          name: Value(user['name']),
          username: Value(user['username']),
          password: Value(user['password']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future updateUser(UsersCompanion user) => update(users).replace(user);

  Future deleteUser(User user) => delete(users).delete(user);

  Future<int> insertOrAbortUser(Map<String, dynamic> user) =>
      into(users).insert(
        UsersCompanion(
          name: Value(user['name']),
          username: Value(user['username']),
          password: Value(user['password']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
        onConflict: DoNothing(
          target: <Column>[users.username],
        ),
        mode: InsertMode.insertOrAbort,
      );

  Future<UserModel> login(String username, String password) =>
      (select(users)
        ..where((usr) => usr.username.equals(username))..where((usr) =>
            usr.password.equals(password)))
          .map((user) => UserModel(user: user))
          .getSingle();
}
