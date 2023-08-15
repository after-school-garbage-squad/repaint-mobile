import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/bottom_constrained_padding.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/flat_icon_button.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/wide_elevated_button.dart';

@RoutePage()
class IntroductionExplainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            const SizedBox(width: 16.0),
            FlatIconButton(
              onPressed: context.popRoute,
              icon: Icons.chevron_left,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
        child: Column(
          children: [
            ConstrainedBox(
              // TODO: 実際の画像のサイズに合わせる
              constraints: const BoxConstraints(maxHeight: 480.0),
              child: const AspectRatio(
                aspectRatio: 1,
                // TODO: 画像を設定する
                child: Placeholder(fallbackWidth: double.infinity),
              ),
            ),
            const SizedBox(height: 32.0),
            Text(
              '参加するためには、配布されたQRコードを読み取る必要があります。',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            WideElevatedButton(
              onPressed: () {
                context.navigateNamedTo("qrcode_reader");
              },
              text: "QRコードの読み取りに進む",
            ),
            const BottomConstrainedPadding(),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
