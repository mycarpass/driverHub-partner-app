import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/commom_objects/payment_type.dart';
import 'package:flutter/material.dart';

class DropDownPaymentType extends StatelessWidget {
  const DropDownPaymentType({super.key, required this.onChanged});

  final Function(PaymentType) onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<PaymentType>(
      hintText: 'Selecione o meio de pagamento',
      items: PaymentType.values,
      searchHintText: "Buscar",
      initialItem: PaymentType.creditCard,
      excludeSelected: true,
      closedFillColor: AppColor.backgroundColor,
      closedBorder: Border.all(color: AppColor.borderColor),
      expandedFillColor: AppColor.backgroundColor,
      closedSuffixIcon: const Icon(Icons.arrow_drop_down_outlined,
          color: AppColor.iconPrimaryColor),
      expandedBorder: Border.all(color: AppColor.borderColor),
      listItemBuilder: (context, item) => Text(item.value).body_regular(),
      headerBuilder: (context, selectedItem) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Meio de pagamento').caption1_emphasized(
              style: const TextStyle(color: AppColor.textSecondaryColor)),
          const SizedBox(
            height: 4,
          ),
          Text(selectedItem.value).body_regular(
              style: const TextStyle(color: AppColor.textPrimaryColor))
        ],
      ),
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}
