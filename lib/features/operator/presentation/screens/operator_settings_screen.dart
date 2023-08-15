import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/list_heading.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/settings_scaffold.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/wide_elevated_button.dart';

@RoutePage()
class OperatorSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsScaffold(
      children: [
        const ListHeading("アカウント設定"),
        const SizedBox(height: 16),
        WideElevatedButton(
          onPressed: () {
            // TODO: ログアウト処理を実装する
            context.navigateNamedTo("/introduction");
          },
          text: "ログアウト",
          colors: const WideElevatedButtonColors(
            backgroundColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.red,
          ),
        )
      ],
    );
  }
}
