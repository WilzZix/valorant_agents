class UserModel {
  final String? email;
  final String? displayName;
  final String? phoneNumber;
  final String? refreshToken;

  UserModel(
      {this.email, this.displayName, this.phoneNumber = '', this.refreshToken});
}
