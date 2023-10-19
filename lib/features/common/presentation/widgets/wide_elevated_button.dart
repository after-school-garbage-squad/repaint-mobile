import 'package:flutter/material.dart';

class WideElevatedButtonColors {
  const WideElevatedButtonColors({
    this.backgroundColor,
    this.shadowColor,
    this.textColor = Colors.black,
    this.iconColor = Colors.black,
  });

  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? textColor;
  final Color? iconColor;
}

class WideElevatedButton extends StatelessWidget {
  const WideElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.colors,
    this.elevation = 1.0,
    this.elevationOnPressed = 3.0,
    this.disabled = false,
  });

  final VoidCallback onPressed;
  final String text;
  final IconData? icon;
  final WideElevatedButtonColors? colors;
  final double elevation;
  final double elevationOnPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final color = colors?.backgroundColor ??
        Theme.of(context).colorScheme.primaryContainer;

    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12.0),
        foregroundColor: Colors.grey.shade600,
        backgroundColor: color,
        shadowColor: colors?.shadowColor,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ).merge(
        ButtonStyle(
          elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return elevationOnPressed;
            }
            return elevation;
          }),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: colors?.iconColor),
            const SizedBox(width: 8.0),
          ],
          Expanded(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: colors?.textColor),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
