import 'package:base_project/core/styles/colors.dart';
import 'package:flutter/material.dart';

class SmallRoundedCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double size; // default 24
  final double borderRadius; // default 4
  final Color activeColor;
  final Color borderColor;
  final Color checkColor;

  const SmallRoundedCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 24.0,
    this.borderRadius = 4.0,
    this.activeColor = ColorManager.mainAppColor,
    this.borderColor = Colors.grey,
    this.checkColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    // It's common to keep at least 48x48 tap-target for accessibility.
    // The visual box is size x size, but we wrap it to provide a larger
    // GestureDetector area while keeping the visual at 24x24.
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onChanged(!value),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: value ? activeColor : Colors.transparent,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: value ? activeColor : borderColor,
                width: 2,
              ),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: value
                  ? Icon(
                Icons.check,
                key: const ValueKey('checked'),
                size: size * 0.6, // check icon scales with box
                color: checkColor,
              )
                  : const SizedBox.shrink(key: ValueKey('unchecked')),
            ),
          ),
        ),
      ),
    );
  }
}
