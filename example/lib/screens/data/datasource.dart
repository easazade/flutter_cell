import 'models/models.dart';

extension IntExt on int {
  Future<Duration> seconds() => Future.delayed(Duration(seconds: this));
}

class DataSource {
  static Future<List<User>> getUsers() async {
    await 2.seconds();
    return fakeUsers;
  }
}
