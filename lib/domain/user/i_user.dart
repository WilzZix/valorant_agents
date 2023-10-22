abstract class IUser {
  const IUser._();

  Future createUser(String name, String email, String password);
}
