import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:repaint_mobile/config/providers.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/app_dialog.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/camera_scaffold.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/material_banner.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/snackbar.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/wide_elevated_button.dart';

@RoutePage()
class VisitorQRCodeReaderScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(visitorQRCodeReaderControllerProvider.future);

    ref.listen(
      networkErrorProvider,
      (previous, next) => showNetworkErrorSnackBar(context, next),
    );

    ref.listen(
      bluetoothServiceProvider,
      (previous, next) => showBluetoothErrorMaterialBanner(
        context,
        previous?.value,
        next.value,
      ),
    );

    ref.listen(
      locationServiceProvider,
      (previous, next) => showLocationErrorMaterialBanner(
        context,
        previous?.value,
        next.value,
      ),
    );

    return CameraScaffold(
      preview: MobileScanner(
        onDetect: (capture) async =>
            (await controller).onQRCodeScanned(context, capture),
      ),
      children: const [
        Center(child: Text('スポットのQRコードを読み込んでください')),
      ],
    );
  }
}

class VisitorQRCodeReaderScannedDialog extends StatelessWidget {
  const VisitorQRCodeReaderScannedDialog({
    required this.onMoveToHome,
  });

  final VoidCallback onMoveToHome;

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      automaticallyImplyLeading: false,
      children: [
        const Spacer(),
        const Icon(Icons.palette, size: 96.0),
        const SizedBox(height: 32.0),
        Text(
          "パレットを入手しました!",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 32.0),
        WideElevatedButton(
          onPressed: onMoveToHome,
          text: "ホームに戻る",
        ),
        const Spacer(),
      ],
    );
  }
}
