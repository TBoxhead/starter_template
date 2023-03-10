import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_template/domain/auth/i_auth_facade.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade;
  AuthBloc(this._authFacade) : super(const AuthState.initial()) {
    on<AuthCheckRequested>((event, emit) async {
      final userOption = await _authFacade.getSignedInUser();
      userOption.fold(
        () => emit(const AuthState.unauthentificated()),
        (a) => emit(const AuthState.authentificated()),
      );
    });
    on<SignedOut>((event, emit) {
      _authFacade.signOut();
      emit(const AuthState.unauthentificated());
    });
  }
}
