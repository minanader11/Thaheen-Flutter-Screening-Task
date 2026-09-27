import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/other/custom_text.dart';

class SpeedSelectorSheet extends StatelessWidget {
  final double currentSpeed;
  final ValueChanged<double> onSpeedSelected;

  const SpeedSelectorSheet({
    super.key,
    required this.currentSpeed,
    required this.onSpeedSelected,
  });

  static const List<double> availableSpeeds = [1.0, 1.25, 1.5, 2.0];

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          CustomText(
            text: s.playbackSpeed,
            style: TextStyles.titleLarge,
          ),
          SizedBox(height: 12.h),
          ...availableSpeeds.map((speed) {
            final isSelected = (currentSpeed - speed).abs() < 0.01;
            return Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(4.r),
                onTap: () {
                  Navigator.pop(context);
                  onSpeedSelected(speed);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: '${speed}x',
                        style: isSelected
                            ? TextStyles.titleMedium.copyWith(color: ColorManager.primary)
                            : TextStyles.bodyLarge,
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_rounded,
                          color: ColorManager.primary,
                          size: 20.r,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
