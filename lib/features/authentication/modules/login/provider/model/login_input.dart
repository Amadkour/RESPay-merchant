// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginInput {
  final String password;
  final String? identityId;
  final String? phoneNumber;
  final String? email;
  final String? deviceToken;
  final String osType;
  LoginInput({
    required this.password,
    required this.osType,
    this.deviceToken,
    this.identityId,
    this.phoneNumber,
    this.email,
  });

  LoginInput copyWith({
    String? password,
    String? identityId,
    String? phoneNumber,
    String? email,
    String? deviceToken,
    String? osType,
  }) {
    return LoginInput(
      password: password ?? this.password,
      identityId: identityId ?? this.identityId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      deviceToken: deviceToken ?? this.deviceToken,
      osType: osType ?? this.osType,
    );
  }
}
