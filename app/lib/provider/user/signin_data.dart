import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInStateNotifier extends StateNotifier<SignInState> {
  SignInStateNotifier() : super(SignInState.initial());

  Future<void> startPhoneVerification(String phoneNumber) async {
    print('전화 인증 시작: $phoneNumber');

    Future.delayed(Duration(seconds: 2), () {
      state = state.copyWith(isPhoneVerified: true);
      print('인증 완료: phoneNumber: $phoneNumber');
    });

    Future.delayed(Duration(seconds: 1), () {
      String verificationId = 'dummy_verification_id';
      state = state.copyWith(verificationId: verificationId);
      print('인증 코드 전송됨, verificationId: $verificationId');
    });

    // Future.delayed(Duration(seconds: 3), () {
    //   print('인증 실패: 오류 메시지');
    //   // 인증 실패 상태 처리
    //   state = state.copyWith(isPhoneVerified: false);
    // });
  }

  void verifyCode(String code) {
    if (code == '200') {
      state = state.copyWith(isPhoneVerified: true);
    }
  }

  void updatePasswordConfirm(String password) {
    state = state.copyWith(passwordConfirm: password);
    print(state.passwordConfirm);
    state.comparedPw();
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
    print(state.password);
    state.comparedPw();
  }
}

class SignInState {
  late bool isEqualed;
  String? password;
  String? passwordConfirm;
  final bool isPhoneVerified;
  final String? verificationId;
  final String? errorMessage;

  SignInState({
    required this.isPhoneVerified,
    this.verificationId,
    this.errorMessage,
    required this.isEqualed,
    this.password,
    this.passwordConfirm,
  });

  factory SignInState.initial() {
    return SignInState(
        isPhoneVerified: false,
        verificationId: null,
        errorMessage: null,
        isEqualed: false,
        password: '',
        passwordConfirm: '');
  }

  SignInState copyWith({
    bool? isPhoneVerified,
    bool? isEqualed,
    String? verificationId,
    String? errorMessage,
    String passwordConfirm = '',
    String password = '',
  }) {
    return SignInState(
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      verificationId: verificationId ?? this.verificationId,
      errorMessage: errorMessage ?? this.errorMessage,
      isEqualed: isEqualed ?? this.isEqualed,
      passwordConfirm:
          passwordConfirm.isNotEmpty ? passwordConfirm : this.passwordConfirm,
      password: password.isNotEmpty ? password : this.password,
    );
  }

  bool comparedPw() {
    if (password != null && passwordConfirm != null) {
      isEqualed = password == passwordConfirm;
    } else {
      isEqualed = false;
    }
    return isEqualed;
  }
}

final signInProvider = StateNotifierProvider<SignInStateNotifier, SignInState>(
  (ref) => SignInStateNotifier(),
);

class PasswordControllerNotifier extends StateNotifier<TextEditingController> {
  PasswordControllerNotifier() : super(TextEditingController());

  void updateText(String text) {
    state.text = text;
    state.selection = TextSelection.collapsed(offset: state.text.length);
  }
}

final passwordConfirmControllerProvider =
    ChangeNotifierProvider((ref) => TextEditingController());
final passwordControllerProvider =
    ChangeNotifierProvider((ref) => TextEditingController());
