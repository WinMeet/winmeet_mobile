import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:winmeet_mobile/app/router/app_router.gr.dart';
import 'package:winmeet_mobile/app/widgets/button/custom_elevated_button.dart';
import 'package:winmeet_mobile/app/widgets/input/email_input_field.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_heading.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
import 'package:winmeet_mobile/core/utils/snackbar/snackbar_utils.dart';
import 'package:winmeet_mobile/feature/auth/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:winmeet_mobile/injection.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<ForgotPasswordCubit>(),
        child: const _ForgotPasswordViewBody(),
      ),
    );
  }
}

class _ForgotPasswordViewBody extends StatelessWidget {
  const _ForgotPasswordViewBody() : super();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          context.router.replace(const LoginRoute());

          SnackbarUtils.showSnackbar(
            context: context,
            message: 'Password reset link sent to the email provided. (Check your spam.)',
          );
        } else if (state.status.isSubmissionFailure) {
          SnackbarUtils.showSnackbar(
            context: context,
            message: state.errorMessage.toString(),
          );
        }
      },
      child: Padding(
        padding: context.paddingAllDefault,
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WinMeetHeading(
                  text: 'Forgot Password',
                ),
                const Text(
                  'Please provide your email and we will send you a link to reset your password',
                ),
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (context, state) {
                    return EmailInputField(
                      textInputAction: TextInputAction.next,
                      isValid: state.email.invalid,
                      labelText: 'Email',
                      onChanged: (email) => context.read<ForgotPasswordCubit>().emailChanged(email: email),
                    );
                  },
                ),
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (context, state) {
                    return CustomElevatedButton(
                      buttonText: 'Reset',
                      isValid: state.status.isValidated,
                      onPressed: () => context.read<ForgotPasswordCubit>().formSubmitted(),
                      status: state.status,
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      child: const Text('Login'),
                      onPressed: () => context.router.replace(
                        const LoginRoute(),
                      ),
                    ),
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
