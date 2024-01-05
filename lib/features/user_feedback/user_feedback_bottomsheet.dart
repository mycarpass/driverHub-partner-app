import 'package:dh_cache_manager/interactor/infrastructure/dh_cache_manager.dart';
import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:driver_hub_partner/features/login/interactor/cache_key/email_key.dart';
import 'package:driver_hub_partner/features/user_feedback/user_feedback_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class UserFeedbackBottomSheet extends StatelessWidget {
  UserFeedbackBottomSheet({super.key});

  final DHCacheManager _dhCacheManager =
      DHInjector.instance.get<DHCacheManager>();

  void name(String feedback) async {
    SentryId sentryId = await Sentry.captureMessage("create_sale");

    var email = await _dhCacheManager.getString(EmailTokenKey());
    var name = await _dhCacheManager.getString(NameTokenKey());

    final userFeedback = SentryUserFeedback(
      eventId: sentryId,
      comments: feedback,
      email: email,
      name: name,
    );

    Sentry.captureUserFeedback(userFeedback);
  }

  TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.85,
        child: Scaffold(
          body: SingleChildScrollView(
            child: BlocProvider(
              create: (context) => UserFeedbackPresenter(),
              child: Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      const Text("Sua experiência").label1_bold(),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                              "Nos conte como foi sua experiência nessa etapa do app, queremos te ouvir e seguir evoluindo para te ajudar a crescer e gerenciar seu negócio da melhor maneira possível ;)")
                          .body_bold(),
                      const SizedBox(
                        height: 12,
                      ),
                      DHTextField(
                        controller: feedbackController,
                        hint: "Feedback",
                        icon: (Icons.feedback),
                        onChanged: (_) {},
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () => name(feedbackController.text),
                          child: const Text(
                            "Contribuir",
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
