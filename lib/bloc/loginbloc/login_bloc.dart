import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<EmailChanged>((event, emit) {
      final email = event.email;
      final isEmailValid = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(email);

      emit(
        state.copyWith(
          email: email,
          isValid: isEmailValid && state.password.length >= 6,
          errorMessage: isEmailValid ? '' : 'Invalid email',
        ),
      );
    });

    on<PasswordChanged>((event, emit) {
      final password = event.password;

      emit(
        state.copyWith(
          password: password,
          isValid: state.email.isNotEmpty && password.length >= 6,
          errorMessage:
          password.length < 6 ? 'Password must be 6 chars' : '',
        ),
      );
    });

    on<LoginSubmitted>((event, emit) {
      emit(state.copyWith(errorMessage: 'Login Success'));
    });
  }
}