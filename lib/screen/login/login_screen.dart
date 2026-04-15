import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investorapp/screen/bottomnavigation/bottomnavigation.dart';
import 'package:investorapp/screen/deal/deallisted/deallisted.dart';
import '../../bloc/loginbloc/login_bloc.dart';
import '../../bloc/loginbloc/login_event.dart';
import '../../bloc/loginbloc/login_state.dart';



class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Investor App")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 40),
                Text("Login to Continue",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.indigo),),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  onChanged: (value) {
                    context.read<LoginBloc>().add(EmailChanged(value));
                  },
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  onChanged: (value) {
                    context.read<LoginBloc>().add(PasswordChanged(value));
                  },
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.isValid
                        ? () {
                      context.read<LoginBloc>().add(LoginSubmitted());
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavScreen(),
                        ),
                      );

                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: const Color(0xFF228B22),
                    ),
                    child: const Text("Login",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}