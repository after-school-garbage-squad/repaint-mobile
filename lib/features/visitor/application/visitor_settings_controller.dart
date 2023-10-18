import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:repaint_api_client/repaint_api_client.dart';
import 'package:repaint_mobile/config/app_router.dart';
import 'package:repaint_mobile/features/common/domain/entities/user_entity.dart';
import 'package:repaint_mobile/features/common/providers/providers.dart';

class VisitorSettingsController {
  VisitorSettingsController(this._client, this._user, this._userdata);

  final RepaintApiClient _client;
  final VisitorUser _user;
  final VisitorUserEntity _userdata;

  // Future<void> onSpotNotificationChanged(bool value) async {
  //   await _user.setNotifications(
  //     (notifications) => notifications.copyWith(spot: value),
  //   );
  // }
  //
  // Future<void> onEventNotificationChanged(bool value) async {
  //   await _user.setNotifications(
  //     (notifications) => notifications.copyWith(event: value),
  //   );
  // }
  //
  // Future<void> onOtherNotificationChanged(bool value) async {
  //   await _user.setNotifications(
  //     (notifications) => notifications.copyWith(other: value),
  //   );
  // }

  Future<void> onDeleteAccountPressed(BuildContext context) async {
    if (_userdata.visitor == null) return;
    await analytics.logEvent(name: 'delete_visitor_pressed');
    await _client.getVisitorApi().deleteVisitor(
          visitorId: _userdata.visitor!.visitorIdentification.visitorId,
          deleteVisitorRequest: DeleteVisitorRequest(
            eventId: _userdata.visitor!.visitorIdentification.eventId,
          ),
        );
    await _user.clear();
  }

  Future<void> onLicensePressed(BuildContext context) async {
    await analytics.logEvent(name: 'visitor_license_pressed');
    if (context.mounted) {
      context.pushRoute(const OssLicensesRoute());
    }
  }
}
