import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_template/application/auth/auth_bloc.dart';
import 'package:starter_template/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:starter_template/presentation/routes/router.gr.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
            () => {},
            (a) => a.fold((l) {
                  var snackBar = SnackBar(
                    content: Text(l.map(
                        serverError: (_) => "Server Error",
                        emailAlreadyInUse: (_) => "Email Already In Use",
                        invalidEmailAndPasswordCombination: (_) =>
                            "Invalid Email And Password Combination")),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }, (r) {
                  context.router.replaceNamed(const MainRoute().path);
                  context
                      .read<AuthBloc>()
                      .add(const AuthEvent.authCheckRequested());
                }));
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              const Center(child: Icon(Icons.person)),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  label: Text("Email"),
                ),
                autocorrect: false,
                onChanged: (value) => context
                    .read<SignInFormBloc>()
                    .add(SignInFormEvent.emailChanged(value)),
                validator: (value) => context
                    .read<SignInFormBloc>()
                    .state
                    .emailAddress
                    .value
                    .fold(
                        (l) => l.maybeWhen(
                              invalidEmail: (failedValue) => "Invalid Email",
                              orElse: () => null,
                            ),
                        (r) => null),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  label: Text("Password"),
                ),
                autocorrect: false,
                obscureText: true,
                onChanged: (value) => context
                    .read<SignInFormBloc>()
                    .add(SignInFormEvent.passwordChanged(value)),
                validator: (value) =>
                    context.read<SignInFormBloc>().state.password.value.fold(
                        (l) => l.maybeWhen(
                              shortPassword: (failedValue) =>
                                  "Invalid Password",
                              orElse: () => null,
                            ),
                        (r) => null),
              ),
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            context.read<SignInFormBloc>().add(
                                const SignInFormEvent
                                    .signInWithEmailAndPasswordPressed());
                          },
                          child: const Text("Sign In"))),
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            context.read<SignInFormBloc>().add(
                                const SignInFormEvent
                                    .registerWithEmailAndPasswordPressed());
                          },
                          child: const Text("Register")))
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<SignInFormBloc>()
                        .add(const SignInFormEvent.signInWithGooglePressed());
                  },
                  child: const Text("Sign In With Goole"))
            ],
          ),
        );
      },
    );
  }
}
