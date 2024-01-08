import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_circular_loading.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/checklist/add_checklist_photo_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/checklist/add_checklist_photo_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddChecklisPhotoBottomSheet extends StatelessWidget {
  AddChecklisPhotoBottomSheet(
      {super.key, required this.id, this.isSavingSchedulePhoto = true});

  final bool isSavingSchedulePhoto;

  final int id;

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.85,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: BlocProvider(
            create: (context) => AddChecklistPhotoPresenter(),
            child: Builder(
              builder: (context) {
                var presenter = context.read<AddChecklistPhotoPresenter>();

                return GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: const Text("Checklist de Fotos").body_bold(),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            "Clique no botão abaixo para \nadicionar fotos ao seu checklist",
                            textAlign: TextAlign.center,
                          ).body_regular(),
                          const SizedBox(
                            height: 24,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: BlocBuilder<AddChecklistPhotoPresenter,
                                DHState>(builder: (context, state) {
                              if (state is DHLoadingState) {
                                return const DHCircularLoading();
                              }
                              if (state is CapturedPhotoState ||
                                  state is SavingPhotoState) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 180,
                                      child: Image.asset(presenter.image!.path),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: AppColor.accentColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                      ),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                const MaterialStatePropertyAll(
                                                    1),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    AppColor.backgroundColor)),
                                        onPressed: () {
                                          presenter.renovePhoto();
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.change_circle_outlined,
                                              color:
                                                  AppColor.iconSecondaryColor,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            const Text('Tirar outra')
                                                .body_bold()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Container(
                                  decoration: const BoxDecoration(
                                      color: AppColor.supportColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  child: IconButton(
                                    onPressed: () {
                                      presenter.takePhoto();
                                    },
                                    iconSize: 100,
                                    icon: const Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 48,
                                      color: AppColor.iconPrimaryColor,
                                    ),
                                  ));
                            }),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          BlocBuilder<AddChecklistPhotoPresenter, DHState>(
                              builder: (context, state) {
                            if (state is! CapturedPhotoState &&
                                state is! SavingPhotoState) {
                              return const SizedBox.shrink();
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Descrição (opcional)')
                                    .body_regular(),
                                DHTextField(
                                  //cursorWidth: 0,
                                  controller: descriptionController,
                                  minLines: 2,
                                  maxLines: 3,
                                  icon: Icons.description_outlined,
                                  // controller: presenter.descriptionController,
                                  hint:
                                      "Ex: Pequeno amassado na lateral dianteira do lado do motorista",
                                  keyboardType: TextInputType.multiline,
                                  onChanged: (text) {
                                    // presenter.serviceEntity.description = text;
                                  },
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        var photoId = 0;
                                        if (presenter.image != null) {
                                          if (isSavingSchedulePhoto) {
                                            photoId = await presenter
                                                .saveSchedulePhoto(
                                              CheckListPhoto(
                                                id: id,
                                                file: presenter.image!,
                                                description:
                                                    descriptionController.text,
                                              ),
                                            );
                                          } else {
                                            photoId =
                                                await presenter.saveSalePhoto(
                                              CheckListPhoto(
                                                id: id,
                                                file: presenter.image!,
                                                description:
                                                    descriptionController.text,
                                              ),
                                            );
                                          }

                                          Navigator.of(context).pop({
                                            "photo": presenter.image,
                                            "description":
                                                descriptionController.text,
                                            "photoId": photoId
                                          });
                                        }
                                      } catch (e) {
                                        rethrow;
                                      }
                                    },
                                    child: state is SavingPhotoState
                                        ? const DHCircularLoading()
                                        : const Text("Enviar foto"),
                                  ),
                                )
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
