import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/elevated_text_button.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/flat_icon_button.dart';

@RoutePage()
class QRCodeReaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatIconButton(
          onPressed: context.popRoute,
          icon: Icons.chevron_left,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // TODO: カメラを実装する
          const Expanded(
            child: Placeholder(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Column(
              children: [
                Text(
                  "QRコードを読み取ってください",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20.0),
                Text(
                  'カメラが起動しない場合は、設定から使用許可をお願いします',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                ElevatedTextButton(
                  // TODO: 設定画面に遷移できるようにする
                  onPressed: () {},
                  text: "設定に進む",
                  colors: const ElevatedTextButtonColors(
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 96.0),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBodyBehindAppBar: true,
    );
  }
}
