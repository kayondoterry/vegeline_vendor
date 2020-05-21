class User {
  final String userId;

  User(this.userId);
}

class LoadingUser extends User {
  LoadingUser():super(null);
}