import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';


/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
      // ignore: avoid_unused_constructor_parameters
      LoginInitialParams initialParams,
      )   : loginResult = const FutureResult.empty(),
        user = const User.anonymous();

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.loginResult,
    required this.user,
  });

  final FutureResult<Either<LogInFailure, User>> loginResult;
  final User user;


  @override
  String get password => user.password;

  @override
  String get username => user.username;

  @override
  bool get isLoading => loginResult.isPending();

  @override
  bool get isLoginEnabled => user.username.isNotEmpty & user.password.isNotEmpty;

  LoginPresentationModel copyWith({
    FutureResult<Either<LogInFailure, User>>? loginResult,
    User? user,
  }) =>
      LoginPresentationModel._(
        loginResult: loginResult ?? this.loginResult,
        user: user ?? this.user,
      );



}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {

  bool get isLoading;
  bool get isLoginEnabled;
  String get username;
  String get password;

}
