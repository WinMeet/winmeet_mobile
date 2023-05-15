import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:winmeet_mobile/app/constants/asset_constants.dart';
import 'package:winmeet_mobile/app/cubit/app_cubit.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_body_large.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_heading.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
import 'package:winmeet_mobile/feature/onboarding/data/model/onboarding_model.dart';
import 'package:winmeet_mobile/feature/onboarding/presentation/widgets/dots_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int _currentPageIndex = 0;

  final List<OnboardingModel> onboardingItems = [
    const OnboardingModel(
      imagePath: AssestsConstants.onboarding1,
      title: 'Easy Scheduling Ahead',
      description:
          'WinMeet is your scheduling automation platform for eliminating the back-and-forth emails for finding the perfect time',
    ),
    const OnboardingModel(
      imagePath: AssestsConstants.onboarding2,
      title: 'Create Meetings Quickly',
      description:
          'Creating meetings can be a time-consuming and complex task, but with WinMeet, you can create meetings quickly and easily',
    ),
    const OnboardingModel(
      imagePath: AssestsConstants.onboarding3,
      title: 'Schedule as a Group',
      description: "With WinMeet's collaborative scheduling tools, planning group meetings has never been easier",
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
                  onPageChanged: (index) => setState(() => _currentPageIndex = index),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(width: context.lowValue),
                  scrollDirection: Axis.horizontal,
                  itemCount: onboardingItems.length,
                  itemBuilder: (context, index) => DotsIndicator(isSelected: _currentPageIndex == index),
                ),
              ),
              ElevatedButton(
                onPressed: () => context.read<AppCubit>().completeOnboarding(),
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
  const _OnboardingPage({required this.item});

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
