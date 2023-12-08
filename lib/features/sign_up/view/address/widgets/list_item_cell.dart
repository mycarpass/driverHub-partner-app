import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_circular_loading.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/address/address_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressListItemCell extends StatelessWidget {
  const AddressListItemCell(
      {super.key,
      required this.title,
      required this.description,
      this.showChevron = true,
      this.icon = Icons.location_on_outlined});

  final String title;
  final String description;
  final IconData icon;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 30,
              color: AppColor.iconPrimaryColor,
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              children: [
                SizedBox(
                    width: MediaQuery.sizeOf(context).width - 132,
                    child: Text(title).label1_bold()),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 132,
                  child: Text(description).body_regular(
                    style: const TextStyle(
                      color: AppColor.textTertiaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            showChevron
                ? BlocBuilder<AddressPresenter, DHState>(
                    builder: (contex, state) {
                    return state is DHLoadingState
                        ? const DHCircularLoading(
                            color: AppColor.accentColor,
                          )
                        : const Icon(
                            Icons.chevron_right,
                            size: 30,
                            color: AppColor.iconPrimaryColor,
                          );
                  })
                : const SizedBox(
                    width: 30,
                  ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          height: 1,
          color: AppColor.borderColor,
        )
      ],
    );
  }
}
