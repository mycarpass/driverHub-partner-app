import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_skeleton.dart';

class CustomersBodyLoading extends StatelessWidget {
  const CustomersBodyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            DHSkeleton(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColor.blackColor,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                height: 100,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            DHSkeleton(
              child: Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
