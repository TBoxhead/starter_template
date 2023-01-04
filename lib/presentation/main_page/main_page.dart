import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_template/application/auth/auth_bloc.dart';
import 'package:starter_template/presentation/routes/router.gr.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main page"),
        leading: IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEvent.signedOut());
              context.router.replaceNamed(const SignInRoute().path);
            },
            icon: const Icon(Icons.logout)),
      ),
    );
  }
}
