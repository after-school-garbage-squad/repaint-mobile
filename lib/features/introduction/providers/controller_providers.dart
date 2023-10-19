import 'package:repaint_mobile/config/providers.dart';
import 'package:repaint_mobile/features/introduction/application/introduction_manual_controller.dart';
import 'package:repaint_mobile/features/introduction/application/introduction_qrcode_scanner_controller.dart';
import 'package:repaint_mobile/features/introduction/application/introduction_settings_controller.dart';
import 'package:repaint_mobile/features/introduction/application/introduction_stepper_controller.dart';
import 'package:repaint_mobile/features/introduction/application/introduction_welcome_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controller_providers.g.dart';

@Riverpod(dependencies: [])
IntroductionManualController introductionManualController(
  IntroductionManualControllerRef ref,
) {
  return const IntroductionManualController();
}

@Riverpod(
  dependencies: [VisitorUser, fcmRegistrationToken, apiClient],
)
Future<IntroductionQRCodeReaderController> introductionQRCodeReaderController(
  IntroductionQRCodeReaderControllerRef ref,
) async {
  return IntroductionQRCodeReaderController(
    ref.watch(apiClientProvider),
    // ignore: avoid_manual_providers_as_generated_provider_dependency
    ref.watch(visitorUserProvider.notifier),
    await ref.watch(fcmRegistrationTokenProvider.future),
  );
}

@Riverpod(dependencies: [])
IntroductionSettingsController introductionSettingsController(
  IntroductionSettingsControllerRef ref,
) {
  return IntroductionSettingsController(
    ref.watch(auth0Provider),
  );
}

@Riverpod()
IntroductionStepperController introductionStepperController(
  IntroductionStepperControllerRef ref,
) {
  return IntroductionStepperController(
    ref.watch(introductionStepperProvider.notifier),
  );
}

@Riverpod()
IntroductionWelcomeController introductionWelcomeController(
  IntroductionWelcomeControllerRef ref,
) {
  return const IntroductionWelcomeController();
}
