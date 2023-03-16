import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:winmeet_mobile/app/router/app_router.gr.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
import 'package:winmeet_mobile/injection.dart';
import 'package:winmeet_mobile/logic/auth/login/login_cubit.dart';
import 'package:winmeet_mobile/presentation/widgets/button/custom_elevated_button.dart';
import 'package:winmeet_mobile/presentation/widgets/input/email_input_field.dart';
import 'package:winmeet_mobile/presentation/widgets/input/password_input_field.dart';

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
          context.router.replace(const NavbarRoute());
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
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return EmailInputField(
                      textInputAction: TextInputAction.next,
                      isValid: state.email.invalid,
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
                        return SizedBox(
                          width: context.width,
                          child: CustomElevatedButton(
                            buttonText: 'Login',
                            isValid: state.status.isValidated,
                            onPressed: () => context.read<LoginCubit>().formSubmitted(),
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
