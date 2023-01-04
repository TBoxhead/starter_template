import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_template/application/auth/auth_bloc.dart';
import 'package:starter_template/injection.dart';
import 'package:starter_template/presentation/routes/router.gr.dart';
import 'package:starter_template/presentation/sign_in/sign_in_page.dart';

class AppWidget extends StatelessWidget {
  final _appRouter = AppRouter();

  AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt.getAsync<AuthBloc>(),
      builder: (BuildContext context, AsyncSnapshot<AuthBloc> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) =>
                  snapshot.data!..add(const AuthEvent.authCheckRequested()),
            )
          ],
          child: MaterialApp.router(
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
          ),
        );
      },
    );
  }
}
