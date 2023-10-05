import 'package:auto_route/auto_route.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:repaint_api_client/repaint_api_client.dart';
import 'package:repaint_mobile/config/app_router.dart';
import 'package:repaint_mobile/features/common/providers/providers.dart';

class VisitorSettingsController {
  VisitorSettingsController(this._client, this._user);

  final RepaintApiClient _client;
  final VisitorUser _user;

  Future<void> onSpotNotificationChanged(bool value) async {
    await _user.setNotifications(
      (notifications) => notifications.copyWith(spot: value),
    );
  }

  Future<void> onEventNotificationChanged(bool value) async {
    await _user.setNotifications(
      (notifications) => notifications.copyWith(event: value),
    );
  }

  Future<void> onOtherNotificationChanged(bool value) async {
    await _user.setNotifications(
      (notifications) => notifications.copyWith(other: value),
    );
  }

  Future<void> onDeleteAccountPressed(BuildContext context) async {
    final user = await _user.future;
    if (user.visitorIdentification == null) return;
    await _client.getVisitorApi().deleteVisitor(
          visitorId: user.visitorIdentification!.visitorId,
          deleteVisitorRequest: DeleteVisitorRequest(
            eventId: user.visitorIdentification!.eventId,
          ),
        );
    await _user.clear();
  }

  void onLicensePressed(BuildContext context) {
    context.pushRoute(const OssLicensesRoute());
  }
}
