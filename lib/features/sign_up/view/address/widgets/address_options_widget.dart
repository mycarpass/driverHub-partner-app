import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/button_style_extension.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:flutter/material.dart';

class AddressOptionsWidget extends StatefulWidget {
  const AddressOptionsWidget({required this.mainAddress, super.key});

  final String mainAddress;

  @override
  // ignore: library_private_types_in_public_api
  _AddressOptionsWidgetState createState() => _AddressOptionsWidgetState();
}

class _AddressOptionsWidgetState extends State<AddressOptionsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.55,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Scaffold(
          appBar: null,
          body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Container(
                  height: 6,
                  width: 45,
                  decoration: const BoxDecoration(
                      color: AppColor.textTertiaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                )),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 24,
                      color: AppColor.iconPrimaryColor,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width - 124,
                        child: Text(
                          widget.mainAddress,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ).label1_bold()),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: AppColor.accentColor,
                        icon: const Icon(Icons.close_rounded))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: 1,
                  color: AppColor.borderColor,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    style: const ButtonStyle().noStyle(),
                    onPressed: () {
                      Navigator.pop(context, AddressActionOption.select);
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(
                          left: 44,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Selecionar Endereço").body_regular(
                                    style: const TextStyle(
                                        color: AppColor.accentColor)),
                                const Icon(
                                  Icons.check,
                                  color: AppColor.accentColor,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: 1,
                              color: AppColor.borderColor,
                            ),
                          ],
                        ))),
                ElevatedButton(
                    style: const ButtonStyle().noStyle(),
                    onPressed: () {
                      Navigator.pop(context, AddressActionOption.homeset);
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(
                          left: 44,
                          top: 12,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Atribuir a Casa").body_regular(
                                    style: const TextStyle(
                                        color: AppColor.textPrimaryColor)),
                                const Icon(
                                  Icons.home_outlined,
                                  color: AppColor.iconPrimaryColor,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: 1,
                              color: AppColor.borderColor,
                            ),
                          ],
                        ))),
                ElevatedButton(
                  style: const ButtonStyle().noStyle(),
                  onPressed: () {
                    Navigator.pop(context, AddressActionOption.workset);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 44,
                      top: 12,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Atribuir a Trabalho").body_regular(
                                style: const TextStyle(
                                    color: AppColor.textPrimaryColor)),
                            const Icon(
                              Icons.work_outline,
                              color: AppColor.iconPrimaryColor,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 1,
                          color: AppColor.borderColor,
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle().noStyle(),
                  onPressed: () {
                    Navigator.pop(context, AddressActionOption.delete);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 44,
                      top: 12,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Excluir").body_regular(
                                style: const TextStyle(
                                    color: AppColor.errorColor)),
                            const Icon(
                              Icons.delete_outline,
                              color: AppColor.errorColor,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum AddressActionOption { select, homeset, workset, delete }
