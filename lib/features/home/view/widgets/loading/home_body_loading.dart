import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_skeleton.dart';

class HomeBodyLoading extends StatelessWidget {
  const HomeBodyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 4,
            ),
            DHSkeleton(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                height: 60,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            DHSkeleton(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                height: 180,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            DHSkeleton(
              child: Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
