import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_template/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:starter_template/injection.dart';
import 'package:starter_template/presentation/sign_in/widgets/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: FutureBuilder(
        future: getIt.getAsync<SignInFormBloc>(),
        builder:
            (BuildContext context, AsyncSnapshot<SignInFormBloc> snapshot) {
          if (!snapshot.hasData) {
            return Text("not loading yet");
          }
          return BlocProvider<SignInFormBloc>(
            create: (context) => snapshot.data!,
            child: const SignInForm(),
          );
        },
      ),
    );
  }
}
