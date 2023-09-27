import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:repaint_mobile/features/common/presentation/widgets/bottom_constrained_padding.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/flat_icon_button.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/wide_elevated_button.dart';
import 'package:repaint_mobile/features/introduction/providers/providers.dart';

@RoutePage()
class IntroductionHomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(introductionHomeControllerProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          FlatIconButton(
            onPressed: () => controller.onSettingsPressed(context),
            icon: Icons.settings,
          ),
          // https://github.com/flutter/flutter/issues/118965
          const SizedBox(width: 16.0),
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48.0,
                      vertical: 32.0,
                    ),
                    child: Image.asset("assets/repaint.png"),
                  ),
                  Text(
                    "Re:paintへようこそ!",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16.0),
                  const Text("Re:paintの説明文（WIP）"), // TODO: 説明文を書く
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: WideElevatedButton(
              onPressed: () => controller.onContinuePressed(context),
              text: "進む",
            ),
          ),
          const BottomPadding(),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
