class User {
  final int id;
  final String name;
  final double credit;

  User({
    required this.id,
    required this.name,
    required this.credit,
  });
}

List<User> fakeUsers = [
  User(id: 1, name: 'alireza', credit: 23.5),
  User(id: 2, name: 'sobhan', credit: 105.5),
  User(id: 3, name: 'john', credit: 37.5),
  User(id: 4, name: 'sarah', credit: 91.5),
  User(id: 5, name: 'ahmad', credit: 70.0),
];
