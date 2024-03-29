import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:winmeet_mobile/app/router/app_router.gr.dart';
import 'package:winmeet_mobile/app/widgets/button/custom_elevated_button.dart';
import 'package:winmeet_mobile/app/widgets/input/email_input_field.dart';
import 'package:winmeet_mobile/app/widgets/input/password_input_field.dart';
import 'package:winmeet_mobile/app/widgets/input/text_input_field.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_heading.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
import 'package:winmeet_mobile/core/utils/snackbar/snackbar_utils.dart';
import 'package:winmeet_mobile/feature/auth/register/presentation/cubit/register_cubit.dart';
import 'package:winmeet_mobile/injection.dart';

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
          SnackbarUtils.showSnackbar(
            context: context,
            message: 'Your account has been created!',
          );
        } else if (state.status.isSubmissionFailure) {
          SnackbarUtils.showSnackbar(
            context: context,
            message: 'Oops! Something went wrong with your registration.',
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
                    text: 'Register',
                  ),
                  const Text(
                    'Enter your information to register',
                  ),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return TextInputField(
                        labelText: 'Name *',
                        errorLabel: 'Name cannot be empty',
                        prefixIcon: const Icon(Icons.person),
                        textInputAction: TextInputAction.next,
                        isValid: state.name.invalid,
                        onChanged: (name) => context.read<RegisterCubit>().nameChanged(name: name),
                      );
                    },
                  ),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return TextInputField(
                        labelText: 'Surname *',
                        errorLabel: 'Surname cannot be empty',
                        prefixIcon: const Icon(Icons.person),
                        textInputAction: TextInputAction.next,
                        isValid: state.surname.invalid,
                        onChanged: (surname) => context.read<RegisterCubit>().surnameChanged(surname: surname),
                      );
                    },
                  ),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return EmailInputField(
                        textInputAction: TextInputAction.next,
                        isValid: state.email.invalid,
                        labelText: 'Email *',
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
                        labelText: 'Password *',
                        errorText: 'At least 8 chars and contain Uppercase Lowercase & Number',
                        onChanged: (password) => context.read<RegisterCubit>().passwordChanged(password: password),
                        onPressed: () => context.read<RegisterCubit>().passwordVisibilityChanged(),
                      );
                    },
                  ),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return CustomElevatedButton(
                        buttonText: 'Register',
                        isValid: state.status.isValidated,
                        onPressed: () => context.read<RegisterCubit>().formSubmitted(),
                        status: state.status,
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
      ),
    );
  }
}
