import 'package:flutter/material.dart';

class OperatorElevatedTile extends StatelessWidget {
  const OperatorElevatedTile({
    super.key,
    this.children,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(8.0),
    this.direction = Axis.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.automaticallyImplyTail = true,
    this.onTap,
  });

  final List<Widget>? children;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool automaticallyImplyTail;
  final VoidCallback? onTap;

  factory OperatorElevatedTile.action({
    required VoidCallback onTap,
    required String title,
    IconData? icon,
  }) {
    return OperatorElevatedTile(
      height: 96,
      padding: const EdgeInsets.all(16.0),
      onTap: onTap,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (icon != null) Icon(icon, size: 48),
        const SizedBox(width: 16.0),
        Text(title),
        const Spacer(),
      ],
    );
  }

  factory OperatorElevatedTile.beacon({
    required VoidCallback onTap,
    required String name,
    required double rssi,
    required String hwid,
  }) {
    return _OperatorElevatedBeaconTile(
      name: name,
      rssi: rssi,
      hwid: hwid,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16.0),
      color: Colors.white,
      elevation: 1.0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          child: Flex(
            direction: direction,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: [
              ...?children,
              if (automaticallyImplyTail)
                Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OperatorElevatedBeaconTile extends OperatorElevatedTile {
  const _OperatorElevatedBeaconTile({
    required this.name,
    required this.rssi,
    required this.hwid,
    super.onTap,
  });

  final String name;
  final double rssi;
  final String hwid;

  @override
  Widget build(BuildContext context) {
    final valueTextStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: const Color(0xff9e9e9e));

    return OperatorElevatedTile(
      padding: const EdgeInsets.all(16.0),
      onTap: onTap,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: Theme.of(context).textTheme.bodyLarge),
              const Divider(),
              Row(
                children: [
                  const Text("RSSI"),
                  const Spacer(),
                  Text("${rssi}dBm", style: valueTextStyle),
                ],
              ),
              Row(
                children: [
                  const Text("HWID"),
                  const Spacer(),
                  Text(hwid, style: valueTextStyle),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 8.0),
      ],
    );
  }
}
