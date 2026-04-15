import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investorapp/bloc/fliterbloc/dealfilter.dart';
import 'package:investorapp/bloc/loginbloc/login_bloc.dart';
import 'package:investorapp/screen/deal/dealdata.dart';
import 'package:investorapp/screen/deal/deallisted/deallisted.dart';
import 'package:investorapp/screen/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        // BlocProvider<InterestBloc>(
        //   create: (context) => InterestBloc(),
        // ),

        BlocProvider<DealFilter>(
          create: (_) => DealFilter(),
          child:  Deallisted(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}