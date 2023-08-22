import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:repaint_mobile/config/app_router.dart';
import 'package:repaint_mobile/config/providers.dart';

class PermissionGuard extends AutoRouteGuard {
  PermissionGuard(this._ref);

  final Ref _ref;
  static final permissions = [
    Permission.notification,
    Permission.location,
    Permission.bluetooth,
    Permission.camera,
  ];

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    await permissions.request();
    final permission = await _ref.refresh(checkPermissionProvider.future);

    if (permission) {
      resolver.next();
    } else {
      resolver.next(false);
      if (router.currentPath != '/introduction/welcome') {
        resolver.redirect(const IntroductionRoute(), replace: true);
      }
    }
  }
}
