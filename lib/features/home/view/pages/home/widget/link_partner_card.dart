import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class LinkPartnerCard extends StatelessWidget {
  const LinkPartnerCard({
    super.key,
    required this.link,
  });

  final String link;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColor.supportColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.link,
                            color: AppColor.textPrimaryColor,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text("Compartilhe seu Link").body_bold(),
                        ],
                      ),
                      IconButton(
                          constraints: const BoxConstraints(),
                          style: const ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: MaterialStatePropertyAll(EdgeInsets.zero),
                          ),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            FlutterShareMe().shareToSystem(msg: link);
                          },
                          icon: const Icon(
                            Icons.ios_share_rounded,
                            size: 20,
                          ))
                      // const Expanded(child: SizedBox.shrink()),
                    ]),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                        "Envie para seus clientes e receba agendamentos por aqui totalmente integrados! :)")
                    .caption1_regular(
                        style: const TextStyle(
                            color: AppColor.textSecondaryColor)),
                const SizedBox(
                  height: 12,
                ),
                Container(
                    height: 40,
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    decoration: BoxDecoration(
                        color: AppColor.whiteColor.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      children: [
                        Flexible(
                            child: Text(
                          link,
                          overflow: TextOverflow.ellipsis,
                        ).body_bold()),
                        IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: link));
                              DHSnackBar().showSnackBar(
                                  'Sucesso!',
                                  'O Link foi copiado com sucesso, compartilhe com seus clientes!',
                                  DHSnackBarType.success);
                            },
                            icon: const Icon(
                              Icons.copy,
                              size: 20,
                            ))
                      ],
                    )),
              ]),
        ));
  }
}
