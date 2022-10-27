import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';
import 'package:sprintf/sprintf.dart';


class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
    this.logInUseCase,
  );

  final LoginNavigator navigator;
  final LogInUseCase logInUseCase;

  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;



  void usernameChanged(String value) {
    emit(_model.copyWith(user: _model.user.copyWith(username: value)));
  }
  void passwordChanged(String value) {
    emit(_model.copyWith(user: _model.user.copyWith(password: value)));
  }
  Future<void> clickButton() async {
    emit(_model.copyWith(loginResult: const FutureResult.pending()));
    final result = await logInUseCase
        .execute(username: _model.user.username, password: _model.user.password);
    emit(_model.copyWith(loginResult: const FutureResult.empty()));
    result.fold(
          (fail) => navigator.showError(fail.displayableFailure()), //todo!
          (success) => unawaited( navigator.showAlert(title: appLocalizations.logInSuccessTitle, message: sprintf(appLocalizations.logInSuccessMessage, [success.username]))),
    );
  }
}
