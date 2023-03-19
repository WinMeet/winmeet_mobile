import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:winmeet_mobile/app/router/app_router.gr.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
import 'package:winmeet_mobile/feature/auth/register/presentation/cubit/register_cubit.dart';
import 'package:winmeet_mobile/injection.dart';
import 'package:winmeet_mobile/presentation/widgets/button/custom_elevated_button.dart';
import 'package:winmeet_mobile/presentation/widgets/input/email_input_field.dart';
import 'package:winmeet_mobile/presentation/widgets/input/normal_input_field.dart';
import 'package:winmeet_mobile/presentation/widgets/input/password_input_field.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<RegisterCubit>(),
        child: const _RegisterViewBody(),
      ),
    );
  }
}

class _RegisterViewBody extends StatelessWidget {
  const _RegisterViewBody() : super();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          context.router.replace(const LoginRoute());
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Account created'),
              ),
            );
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
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
                  'Register',
                  style: context.textTheme.headlineMedium,
                ),
                const Text(
                  'Enter your name, email and password to register',
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return NormalInputField(
                      labelText: 'Name',
                      errorLabel: 'Name cannot be empty',
                      textInputAction: TextInputAction.next,
                      isValid: state.name.invalid,
                      onChanged: (name) => context.read<RegisterCubit>().nameChanged(name: name),
                    );
                  },
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return EmailInputField(
                      textInputAction: TextInputAction.next,
                      isValid: state.email.invalid,
                      onChanged: (email) => context.read<RegisterCubit>().emailChanged(email: email),
                    );
                  },
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return PasswordInputField(
                      textInputAction: TextInputAction.next,
                      obscureText: state.isPasswordObscured,
                      isValid: state.password.invalid,
                      labelText: 'Password',
                      errorText: 'Weak Password',
                      onChanged: (password) => context.read<RegisterCubit>().passwordChanged(password: password),
                      onPressed: () => context.read<RegisterCubit>().passwordVisibilityChanged(),
                    );
                  },
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return PasswordInputField(
                      textInputAction: TextInputAction.done,
                      obscureText: state.isPasswordObscured,
                      isValid: state.confirmPassword.invalid,
                      labelText: 'Confirm Password',
                      errorText: 'Passwords do not match',
                      onChanged: (confirmPassword) =>
                          context.read<RegisterCubit>().confirmPasswordChanged(confirmPassword: confirmPassword),
                      onPressed: () => context.read<RegisterCubit>().passwordVisibilityChanged(),
                    );
                  },
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: context.highValue,
                      child: CustomElevatedButton(
                        buttonText: 'Register',
                        isValid: state.status.isValidated,
                        onPressed: () => context.read<RegisterCubit>().formSubmitted(),
                        status: state.status,
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () => context.router.replace(const LoginRoute()),
                      child: const Text('Login'),
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
