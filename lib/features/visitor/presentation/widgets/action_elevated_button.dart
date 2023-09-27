import 'package:flutter/material.dart';

class ActionElevatedButtonColors {
  const ActionElevatedButtonColors({
    this.borderColor,
    this.backgroundColor,
    this.textColor = Colors.black,
    this.iconColor = Colors.black,
  });

  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
}

class ActionElevatedButton extends StatelessWidget {
  const ActionElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.colors,
    this.elevation = 3.0,
    this.elevationOnPressed = 4.0,
  }) : super();

  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final ActionElevatedButtonColors? colors;
  final double elevation;
  final double elevationOnPressed;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = colors?.backgroundColor ??
        Theme.of(context).colorScheme.primaryContainer;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.grey.shade400,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          surfaceTintColor: Colors.white,
          padding: EdgeInsets.zero,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Icon(icon, color: colors?.iconColor, size: 80.0),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 40.0),
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(minHeight: 40.0),
                decoration: BoxDecoration(
                  color: backgroundColor,
                ),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors?.textColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
