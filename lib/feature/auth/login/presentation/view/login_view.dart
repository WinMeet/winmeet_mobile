import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:winmeet_mobile/app/cubit/app_cubit.dart';
import 'package:winmeet_mobile/app/router/app_router.gr.dart';
import 'package:winmeet_mobile/app/widgets/button/custom_elevated_button.dart';
import 'package:winmeet_mobile/app/widgets/input/email_input_field.dart';
import 'package:winmeet_mobile/app/widgets/input/password_input_field.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_heading.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
import 'package:winmeet_mobile/core/utils/snackbar/snackbar_utils.dart';

import 'package:winmeet_mobile/feature/auth/login/presentation/cubit/login_cubit.dart';
import 'package:winmeet_mobile/injection.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<LoginCubit>(),
        child: const _LoginViewBody(),
      ),
    );
  }
}

class _LoginViewBody extends StatelessWidget {
  const _LoginViewBody() : super();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          context.read<AppCubit>().checkAppState();
        } else if (state.status.isSubmissionFailure) {
          SnackbarUtils.showSnackbar(
            context: context,
            message: 'The email or password you entered is incorrect.',
          );
        }
      },
      child: SafeArea(
        child: Padding(
          padding: context.paddingAllDefault,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WinMeetHeading(
                    text: 'Login',
                  ),
                  const Text(
                    'Enter your email and password to login',
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return EmailInputField(
                        textInputAction: TextInputAction.next,
                        isValid: state.email.invalid,
                        labelText: 'Email',
                        onChanged: (email) => context.read<LoginCubit>().emailChanged(email: email),
                      );
                    },
                  ),
                  Column(
                    children: [
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return PasswordInputField(
                            textInputAction: TextInputAction.done,
                            obscureText: state.isPasswordObscured,
                            isValid: state.password.invalid,
                            labelText: 'Password',
                            errorText: 'Weak Password',
                            onChanged: (password) => context.read<LoginCubit>().passwordChanged(password: password),
                            onPressed: () => context.read<LoginCubit>().passwordVisibilityChanged(),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => context.router.replace(const ForgotPasswordRoute()),
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return CustomElevatedButton(
                            buttonText: 'Login',
                            isValid: state.status.isValidated,
                            onPressed: () => context.read<LoginCubit>().formSubmitted(),
                            status: state.status,
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () => context.router.replace(const RegisterRoute()),
                        child: const Text('Register'),
                      )
                    ],
                  ),
                ].withSpaceBetween(height: context.mediumValue),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
