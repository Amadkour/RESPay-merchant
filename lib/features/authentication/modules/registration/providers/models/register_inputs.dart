import 'package:equatable/equatable.dart';

class RegisterInputs extends Equatable {
  final String? id;
  final String? fullName;
  final String? birthday;
  final String? phone;
  final String? email;
  final String? password;
  final String? passwordConfirmation;
  const RegisterInputs({
    this.id,
    this.fullName,
    this.birthday,
    this.phone,
    this.email,
    this.password,
    this.passwordConfirmation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'full_name': fullName,
      'identity_id': id,
      'dob': birthday,
      'email': email,
      'phone_number': phone!.isEmpty ? '' : phone,
      'password': password,
      'password_confirmation': password,
      'is_merchant': 0
    };
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        fullName,
        birthday,
        phone,
        email,
        password,
        passwordConfirmation,
        
      ];
}
