import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:repaint_mobile/features/common/presentation/widgets/flat_icon_button.dart';

class CameraScaffold extends StatelessWidget {
  const CameraScaffold({
    super.key,
    required this.preview,
    this.onBackPressed,
    this.children,
  });

  final Widget preview;
  final VoidCallback? onBackPressed;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      maxLines: 1,
      softWrap: false,
      style: Theme.of(context).textTheme.bodyMedium!,
      child: Scaffold(
        appBar: AppBar(
          leading: Row(
            children: [
              const SizedBox(width: 16.0),
              FlatIconButton(
                onPressed: onBackPressed ?? context.popRoute,
                icon: Icons.chevron_left,
              ),
            ],
          ),
          leadingWidth: 64.0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            preview,
            if (children != null) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: children!,
                ),
              ),
              Container(
                height: double.infinity,
                constraints: const BoxConstraints(maxHeight: 96.0),
              ),
            ],
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        extendBodyBehindAppBar: true,
      ),
    );
  }
}
