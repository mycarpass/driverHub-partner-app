import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/enum/customer_status.dart';
import 'package:driver_hub_partner/features/customers/presenter/customers_presenter.dart';
import 'package:driver_hub_partner/features/customers/router/customers_router.dart';
import 'package:driver_hub_partner/features/customers/router/params/customer_detail_param.dart';
import 'package:driver_hub_partner/features/customers/view/pages/detail/customer_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerItemWidget extends StatelessWidget {
  const CustomerItemWidget({
    super.key,
    required this.customerDto,
  });

  final CustomerDto customerDto;

  @override
  Widget build(BuildContext context) {
    var presenter = context.read<CustomersPresenter>();

    return ElevatedButton(
      style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0)),
      onPressed: () async {
        var result = await Navigator.of(context).pushNamed(
          CustomerRoutes.detail,
          arguments: CustomerDetailParams(
            customerDto: customerDto,
          ),
        );
        if (result != null && result == true) {
          presenter.load();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColor.backgroundTertiary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColor.backgroundTransparent,
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
                    Text(customerDto.quantityDoneSales == 1
                            ? '${customerDto.quantityDoneSales} venda realizada'
                            : '${customerDto.quantityDoneSales} vendas realizadas')
                        .body_regular(),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.monetization_on_outlined,
                          size: 16,
                          color: AppColor.accentColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text("Gastou ${customerDto.spentValue?.priceInReal ?? "R\$ 0,00"}")
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
