import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repaint_mobile/config/app_router.dart';
import 'package:repaint_mobile/config/providers.dart';
import 'package:repaint_mobile/features/common/domain/entities/user_entity.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/flat_icon_button.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/list_heading.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/settings_tile.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/wide_elevated_button.dart';
import 'package:repaint_mobile/features/visitor/providers/providers.dart';

@RoutePage()
class VisitorSettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(visitorSettingsProvider);
    final controller = ref.watch(visitorSettingsControllerProvider);
    final packageInfo = ref.watch(packageInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("設定"),
        centerTitle: true,
        leading: Row(
          children: [
            const SizedBox(width: 16.0),
            FlatIconButton(
              onPressed: context.popRoute,
              icon: Icons.chevron_left,
            ),
          ],
        ),
        leadingWidth: 64.0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ListHeading("通知設定"),
            const SizedBox(height: 12),
            SettingsTile.toggle(
              title: "スポットに入った際の通知",
              value: settings.value?.notifications.spot ?? false,
              onChanged: controller.onSpotNotificationChanged,
            ),
            const SizedBox(height: 12),
            SettingsTile.toggle(
              title: "イベントからのお知らせ",
              value: settings.value?.notifications.event ?? false,
              onChanged: controller.onEventNotificationChanged,
            ),
            const SizedBox(height: 12),
            SettingsTile.toggle(
              title: "その他の通知",
              value: settings.value?.notifications.other ?? false,
              onChanged: controller.onOtherNotificationChanged,
            ),
            const SizedBox(height: 32),
            const ListHeading("アカウント設定"),
            const SizedBox(height: 12),
            WideElevatedButton(
              onPressed: () async {
                // TODO: ログアウト機能を実装する
                await ref.read(userProvider.notifier).setType(UserType.unknown);
                if (context.mounted) {
                  context.router.pushAndPopUntil(
                    const IntroductionWelcomeRoute(),
                    predicate: (_) => false,
                  );
                }
              },
              text: "ログアウト",
              colors: const WideElevatedButtonColors(
                backgroundColor: Colors.white,
                textColor: Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            const ListHeading("アプリについて"),
            const SizedBox(height: 16),
            SettingsTile.text(
              title: "バージョン",
              titleStyle: Theme.of(context).textTheme.bodyLarge,
              value: packageInfo.value?.version ?? "",
            ),
            const SizedBox(height: 16),
            WideElevatedButton(
              onPressed: () {
                context.pushRoute(const OssLicensesRoute());
              },
              text: "ライセンス",
              colors:
                  const WideElevatedButtonColors(backgroundColor: Colors.white),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
