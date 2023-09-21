import 'package:permission_handler/permission_handler.dart';
import 'package:repaint_mobile/config/guards.dart';
import 'package:repaint_mobile/config/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_providers.g.dart';

@Riverpod(keepAlive: true)
Future<bool> permission(PermissionRef ref) async {
  final logger = ref.read(loggerProvider);
  final permissions = await PermissionGuard.permissions.request();
  permissions.forEach((permission, status) {
    logger.d("$permission: ${status.name}");
  });
  return permissions.values.every((status) => status.isGranted);
}
