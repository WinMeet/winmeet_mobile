import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:winmeet_mobile/app/constants/assets.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_body_large.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_heading.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
import 'package:winmeet_mobile/feature/onboarding/data/model/onboarding_model.dart';
import 'package:winmeet_mobile/feature/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:winmeet_mobile/feature/onboarding/presentation/widgets/dots_indicator.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  final List<OnboardingModel> onboardingItems = [
    const OnboardingModel(
      imagePath: Assests.onboarding1,
      title: 'Easy Scheduling Ahead',
      description:
          'WinMeet is your scheduling automation platform for eliminating the back-and-forth emails for finding the perfect tim',
    ),
    const OnboardingModel(
      imagePath: Assests.onboarding2,
      title: 'Create Events Quickly',
      description:
          'Creating events can be a time-consuming and complex task, but with WinMeet, you can create events quickly and easily',
    ),
    const OnboardingModel(
      imagePath: Assests.onboarding3,
      title: 'Schedule as a Group',
      description: "With WinMeet's collaborative scheduling tools, planning group events has never been easier",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.paddingAllDefault,
          child: Column(
            children: [
              const Spacer(),
              Expanded(
                flex: 4,
                child: PageView.builder(
                  itemCount: onboardingItems.length,
                  itemBuilder: (context, index) => _OnboardingPage(
                    item: onboardingItems[index],
                  ),
                  onPageChanged: (index) => context.read<OnboardingCubit>().changeCurrentIndex(index: index),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(width: context.lowValue),
                  scrollDirection: Axis.horizontal,
                  itemCount: onboardingItems.length,
                  itemBuilder: (context, index) {
                    return BlocSelector<OnboardingCubit, OnboardingState, int>(
                      selector: (state) => state.currentIndex,
                      builder: (context, state) => DotsIndicator(
                        isSelected: state == index,
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => context.read<OnboardingCubit>().completeOnboarding(),
                child: const Text('Get Started'),
              ),
            ].withSpaceBetween(height: context.mediumValue),
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.item,
  });

  final OnboardingModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SvgPicture.asset(item.imagePath),
        ),
        WinMeetHeading(
          text: item.title,
          textAlign: TextAlign.center,
        ),
        WinMeetBodyLarge(
          text: item.description,
          textAlign: TextAlign.center,
        ),
      ].withSpaceBetween(height: context.mediumValue),
    );
  }
}
