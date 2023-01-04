import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_template/application/auth/auth_bloc.dart';
import 'package:starter_template/presentation/routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: ((value) {}),
          authentificated: ((value) {
            context.router.replaceNamed(const MainRoute().path);
          }),
          unauthentificated: ((value) {
            context.router.replaceNamed(const SignInRoute().path);
          }),
        );
      },
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
