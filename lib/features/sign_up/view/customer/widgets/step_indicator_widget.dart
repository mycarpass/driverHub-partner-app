import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/widgets/dotted_line.dart';
import 'package:flutter/material.dart';

class StepIndicatorWidget extends StatefulWidget {
  const StepIndicatorWidget(
      {super.key, required this.currentStep, required this.countSteps});

  final int currentStep;
  final int countSteps;

  @override
  State<StatefulWidget> createState() => _StepIndicatorWidgetState();
}

class _StepIndicatorWidgetState extends State<StepIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.countSteps,
        separatorBuilder: (context, index) {
          return Center(
            child: HorizontalDottedLine(
              color: index < widget.currentStep
                  ? AppColor.accentColor
                  : AppColor.borderColor,
            ),
          );
        },
        itemBuilder: (context, index) => Center(
          child: SizedBox(
            height: 24,
            child: Container(
                width: 24,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    border: Border.all(
                        color: index < widget.currentStep
                            ? AppColor.borderColor
                            : Colors.transparent)),
                child: CircleAvatar(
                  backgroundColor: index == widget.currentStep
                      ? AppColor.accentColor
                      : index < widget.currentStep
                          ? AppColor.primaryColor
                          : AppColor.borderColor,
                  child: Text(
                    (index + 1).toString(),
                  ).body_bold(
                      style: TextStyle(
                          fontSize: 14,
                          color: index == widget.currentStep
                              ? AppColor.blackColor
                              : index < widget.currentStep
                                  ? AppColor.accentColor
                                  : AppColor.whiteColor.withOpacity(0.2))),
                )),
          ),
        ),
      ),
    );
  }
}
