import 'dart:io';

import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/home/presenter/subscription_presenter.dart';
import 'package:driver_hub_partner/features/home/view/pages/home/widget/bottomsheets/subscription_intro_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

// ignore: must_be_immutable
class SubscriptionHomeCard extends StatefulWidget {
  SubscriptionHomeCard({
    required this.daysTrialLeft,
    super.key,
  });

  int daysTrialLeft = 0;

  @override
  State<SubscriptionHomeCard> createState() => _SubscriptionHomeCardState();
}

class _SubscriptionHomeCardState extends State<SubscriptionHomeCard> {
  late List<StoreProduct> storeProducts;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    storeProducts = await Purchases.getProducts(
        Platform.isAndroid
            ? [
                'android_monthly_partners:android-monthly-partners-plan',
                'android_monthly_partners:android-yearly-partners-plan'
              ]
            : ['ios_monthly_partners', 'ios_yearly_partners'],
        productCategory: ProductCategory.subscription);
    storeProducts.sort((a, b) => a.price.compareTo(b.price));
  }

  @override
  Widget build(BuildContext context) {
    var presenter = context.read<SubscriptionPresenter>();
    return Container(
      margin: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const MaterialStatePropertyAll(
                EdgeInsets.fromLTRB(16, 16, 16, 16),
              ),
              backgroundColor: MaterialStatePropertyAll(
                  widget.daysTrialLeft <= 0
                      ? AppColor.warningColor
                      : AppColor.successColor)),
          onPressed: () async {
            await showModalBottomSheet<bool?>(
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              builder: (_) => BlocProvider.value(
                  value: presenter,
                  child: SubscriptionIntroBottomSheet(
                    storeProducts: storeProducts,
                  )),
            );

            //await Purchases.restorePurchases();

            // print(products);
            // Offerings offerings = await Purchases.getOfferings();
            // print(offerings);

            // Purchases.setSimulatesAskToBuyInSandbox(true);
            // Purchases.addReadyForPromotedProductPurchaseListener(
            //     (productID, startPurchase) async {
            //   print('Received readyForPromotedProductPurchase event for '
            //       'productID: $productID');

            //   try {
            //     final purchaseResult = await startPurchase.call();
            //     print('Promoted purchase for productID '
            //         '${purchaseResult.productIdentifier} completed, or product was'
            //         'already purchased. customerInfo returned is:'
            //         ' ${purchaseResult.customerInfo}');
            //   } on PlatformException catch (e) {
            //     print('Error purchasing promoted product: ${e.message}');
            //   }
            // });
            // try {
            //   CustomerInfo purchaserInfo =
            //       await Purchases.purchasePackage(package);
            //   if (purchaserInfo
            //       .entitlements.all["my_entitlement_identifier"]!.isActive) {
            //     // Unlock that great "pro" content
            //   }
            // } on PlatformException catch (e) {
            //   var errorCode = PurchasesErrorHelper.getErrorCode(e);
            //   if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
            //     print(e);
            //   }
            // }

            // dynamic customerInfo =
            //     await Purchases.purchaseStoreProduct(products[0]);
            // print(customerInfo);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Icon(
                  CustomIcons.dhStarFill,
                  color: AppColor.iconSecondaryColor,
                  size: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(widget.daysTrialLeft <= 0
                        ? "Seu teste gratuito acabou :|"
                        : "Seu teste gratuito acaba em ${widget.daysTrialLeft} dia(s)")
                    .body_bold(),
                const Expanded(child: SizedBox.shrink()),
              ]),
              const SizedBox(
                height: 8,
              ),
              Text(widget.daysTrialLeft <= 0
                      ? "Clique para assinar e volte a usar de onde parou :)"
                      : "Clique para aproveitar o desconto e assinar agora!")
                  .caption1_regular(),
            ],
          )),
    );
  }
}
