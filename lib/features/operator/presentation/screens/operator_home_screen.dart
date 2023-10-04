import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/flat_icon_button.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/wide_elevated_button.dart';
import 'package:repaint_mobile/features/operator/presentation/widgets/operator_elevated_tile.dart';
import 'package:repaint_mobile/features/operator/providers/event_providers.dart';
import 'package:repaint_mobile/features/operator/providers/providers.dart';

@RoutePage()
class OperatorHomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(operatorEventProvider);
    final controller = ref.watch(operatorHomeControllerProvider.future);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("管理者画面"),
        centerTitle: true,
        actions: [
          FlatIconButton(
            onPressed: () async =>
                (await controller).onSettingsPressed(context),
            icon: Icons.settings,
          ),
          // https://github.com/flutter/flutter/issues/118965
          const SizedBox(width: 16.0),
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          children: [
            OperatorElevatedTile(
              automaticallyImplyTail: false,
              padding: const EdgeInsets.all(16),
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                event.maybeWhen(
                  data: (data) => Text(
                    "選択中のイベント: ${data?.name}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  orElse: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
                const SizedBox(height: 16),
                WideElevatedButton(
                  onPressed: () async =>
                      (await controller).onChangeEventPressed(context),
                  text: "イベントを変更",
                  colors: WideElevatedButtonColors(
                    backgroundColor: Colors.transparent,
                    textColor: Theme.of(context).colorScheme.primary,
                  ),
                  elevation: 0.0,
                  elevationOnPressed: 0.0,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // OperatorElevatedTile.action(
            //   onTap: () async =>
            //       (await controller).onQRCodeReaderPressed(context),
            //   title: "QRコードを読み取る",
            //   icon: Icons.qr_code_scanner,
            // ),
            const SizedBox(height: 16),
            OperatorElevatedTile.action(
              onTap: () async => (await controller).onCameraPressed(context),
              title: "写真を撮影する",
              icon: Icons.camera_alt,
            ),
            const SizedBox(height: 16),
            OperatorElevatedTile.action(
              onTap: () async =>
                  (await controller).onBeaconListPressed(context),
              title: "ビーコンを設定する",
              icon: Icons.settings_input_antenna,
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
