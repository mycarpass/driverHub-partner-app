import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/enum/customer_status.dart';
import 'package:flutter/material.dart';

class CustomerItemWidget extends StatelessWidget {
  const CustomerItemWidget({
    super.key,
    required this.customerDto,
  });

  final CustomerDto customerDto;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0)),
      onPressed: () => null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColor.backgroundTertiary,
                  child: Text(
                    customerDto.getInitialsName(),
                    overflow: TextOverflow.ellipsis,
                  ).caption1_bold(),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Text(customerDto.name).body_bold(),
                        const SizedBox(
                          width: 4,
                        ),
                        customerDto.isSubscribed
                            ? const Icon(
                                CustomIcons.dhCrown,
                                color: AppColor.supportColor,
                                size: 12,
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(customerDto.phone).body_regular(),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.monetization_on_outlined,
                          size: 16,
                          color: AppColor.supportColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text("Gastou ${customerDto.spentValue ?? "R\$ 0,00"}")
                            .caption1_regular()
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Icon(
              Icons.check_circle_outlined,
              color: customerDto.status == CustomerStatus.verified
                  ? AppColor.accentColor
                  : AppColor.iconPrimaryColor,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
