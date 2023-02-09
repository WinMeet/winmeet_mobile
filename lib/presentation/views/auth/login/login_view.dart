import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:winmeet_mobile/app/router/app_router.gr.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
import 'package:winmeet_mobile/locator.dart';
import 'package:winmeet_mobile/logic/auth/login/login_bloc.dart';
import 'package:winmeet_mobile/presentation/widgets/button/custom_elevated_button.dart';
import 'package:winmeet_mobile/presentation/widgets/input/email_input_field.dart';
import 'package:winmeet_mobile/presentation/widgets/input/password_input_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<LoginBloc>(),
        child: const _LoginViewBody(),
      ),
    );
  }
}

class _LoginViewBody extends StatelessWidget {
  const _LoginViewBody() : super();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          context.router.replace(const NavbarRouter());
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage.toString()),
            ),
          );
        }
      },
      child: Padding(
        padding: context.paddingAllDefault,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: context.textTheme.headlineMedium,
                ),
                const Text(
                  'Enter your email and password to login',
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return EmailInputField(
                      textInputAction: TextInputAction.next,
                      isValid: state.email.invalid,
                      onChanged: (email) => context.read<LoginBloc>().add(LoginEvent.emailChanged(email)),
                    );
                  },
                ),
                Column(
                  children: [
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return PasswordInputField(
                          textInputAction: TextInputAction.done,
                          obscureText: state.isPasswordObscured,
                          isValid: state.password.invalid,
                          labelText: 'Password',
                          errorText: 'Weak Password',
                          onChanged: (password) => context.read<LoginBloc>().add(LoginEvent.passwordChanged(password)),
                          onPressed: () => context.read<LoginBloc>().add(const LoginEvent.passwordVisibilityChanged()),
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
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: context.width,
                          child: CustomElevatedButton(
                            buttonText: 'Login',
                            isValid: state.status.isValidated,
                            onPressed: () => context.read<LoginBloc>().add(const LoginEvent.formSubmitted()),
                            status: state.status,
                          ),
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
    );
  }
}
