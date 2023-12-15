import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:driver_hub_partner/features/commom_objects/extensions/date_extensions.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedules_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/emptystate/empty_state_list.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/schedules/solicitation_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ScheduledListView extends StatefulWidget {
  ScheduledListView({super.key});

  @override
  State<ScheduledListView> createState() => _ScheduledListViewState();
}

class _ScheduledListViewState extends State<ScheduledListView> {
  List<ScheduleDataDto> schedules = [];
  late DateTime daySelected;
  @override
  void didChangeDependencies() {
    dynamic args = ModalRoute.of(context)?.settings.arguments;
    schedules = args['schedules'] ?? [];
    daySelected = args['day'];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // var presenter = context.read<SchedulesPresenter>();
    return Scaffold(
      appBar: AppBar().backButton(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocBuilder<SchedulesPresenter, DHState>(
          builder: (context, state) {
            return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(daySelected.formatDate('dd, EEEE', 'pt_BR'))
                      .title2_bold(),
                  const SizedBox(
                    height: 24,
                  ),
                  schedules.isEmpty
                      ? const EmptyStateList(
                          text:
                              'Nenhum agendamento encontrado para a data selecionada.',
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 32),
                          itemCount: schedules.length,
                          itemBuilder: (context, index) {
                            return SolicitationListItemWidget(
                              solicitationDataDto: schedules[index],
                            );
                          },
                        ),
                ]);
          },
        ),
      ),
    );
  }
}
