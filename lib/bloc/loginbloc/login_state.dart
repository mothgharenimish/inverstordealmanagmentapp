class LoginState {
  final String email;
  final String password;
  final bool isValid;
  final String errorMessage;

  LoginState({
    this.email = '',
    this.password = '',
    this.isValid = false,
    this.errorMessage = '',
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isValid,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}