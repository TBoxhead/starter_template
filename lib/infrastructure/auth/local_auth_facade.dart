import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter_template/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:starter_template/domain/auth/i_auth_facade.dart';
import 'package:starter_template/domain/auth/user.dart';
import 'package:starter_template/domain/auth/value_objects.dart';
import 'package:starter_template/domain/core/errors.dart';
import 'package:starter_template/domain/core/value_objects.dart';
import 'package:uuid/uuid.dart';

@Injectable(as: IAuthFacade)
class LocalAuthFacade implements IAuthFacade {
  final SharedPreferences sharedPreferences;

  LocalAuthFacade(this.sharedPreferences);

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required EmailAddress emailAddress, required Password password}) async {
    try {
      var inputEmail = emailAddress.getOrCrash();
      var inputPassword = password.getOrCrash();
      String? savedEmail = sharedPreferences.getString("email");

      if (savedEmail != null && savedEmail == inputEmail) {
        return left(const AuthFailure.emailAlreadyInUse());
      }

      sharedPreferences.setString("email", inputEmail);
      sharedPreferences.setString("password", inputPassword);
      return right(unit);
    } on UnexpectedValueError {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required EmailAddress emailAddress, required Password password}) async {
    try {
      String? savedEmail = sharedPreferences.getString("email");
      String? savedPassword = sharedPreferences.getString("password");
      if (savedEmail != null &&
          savedPassword != null &&
          emailAddress.getOrCrash() == savedEmail &&
          password.getOrCrash() == savedPassword) {
        sharedPreferences.setBool("isLoggedIn", true);
        return right(unit);
      } else {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      }
    } on UnexpectedValueError {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    sharedPreferences.setBool("isLoggedIn", true);
    return right(unit);
  }

  @override
  Future<Option<User>> getSignedInUser() async {
    var isLoggedIn = sharedPreferences.getBool("isLoggedIn");

    if (isLoggedIn == null) {
      return optionOf(null);
    }

    if (!isLoggedIn) {
      return optionOf(null);
    }

    var emailAddress = sharedPreferences.getString("email");
    emailAddress = isLoggedIn && emailAddress != null
        ? emailAddress
        : "googleAccount@google.com";
    return optionOf(User(
        id: UniqueId(),
        name: StringSingleLine(emailAddress.split("@")[0]),
        emailAddress: EmailAddress(emailAddress)));
  }

  @override
  Future<void> signOut() async {
    sharedPreferences.setBool("isLoggedIn", false);
  }
}
