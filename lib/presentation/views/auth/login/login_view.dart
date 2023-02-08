import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/form_status.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/router/app_router.gr.dart';
import '../../../../locator.dart';
import '../../../../logic/auth/login/login_bloc.dart';
import '../../../widgets/button/custom_elevated_button.dart';
import '../../../widgets/input/email_input_field.dart';
import '../../../widgets/input/password_input_field.dart';

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
      listener: (context, state) {
        if (state.status == FormStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage.toString()),
            ),
          );
        } else if (state.status == FormStatus.success) {
          context.router.replace(const NavbarRouter());
        }
      },
      child: Padding(
        padding: context.paddingAllDefault,
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: context.theme.textTheme.headlineMedium,
                ),
                SizedBox(
                  height: context.highValue,
                ),
                const Text(
                  'Enter your email and password to login',
                ),
                SizedBox(
                  height: context.mediumValue,
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return EmailInputField(
                      textInputAction: TextInputAction.next,
                      isValidEmail: state.isValidEmail,
                      onChanged: (email) => context.read<LoginBloc>().add(
                            LoginEvent.emailChanged(email),
                          ),
                    );
                  },
                ),
                SizedBox(
                  height: context.mediumValue,
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return PasswordInputField(
                      labelText: 'Password',
                      obscureText: state.isPasswordObscured,
                      textInputAction: TextInputAction.next,
                      isValid: state.isValidPassword,
                      onPressed: () => context.read<LoginBloc>().add(
                            const LoginEvent.passwordVisibilityChanged(),
                          ),
                      onChanged: (password) => context.read<LoginBloc>().add(
                            LoginEvent.passwordChanged(password),
                          ),
                    );
                  },
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.router.replace(const ForgotPasswordRoute()),
                    child: const Text('Forgot Password?'),
                  ),
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        buttonText: 'Login',
                        isValid: (state.isValidPassword ?? false) && (state.isValidEmail ?? false),
                        status: state.status,
                        onPressed: () => context.read<LoginBloc>().add(
                              const LoginEvent.loginSubmitted(),
                            ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: context.highValue,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      child: const Text('Register'),
                      onPressed: () => context.router.replace(
                        const RegisterRoute(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
