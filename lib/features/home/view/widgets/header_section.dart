import 'package:base_project/core/constants/images_paths.dart';
import 'package:base_project/core/widgets/other/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderSection extends StatelessWidget {
  final String eventName;
  final int currentDay;
  final int totalDays;
  final bool isConnected;

  const HeaderSection({
    super.key,
    required this.eventName,
    required this.currentDay,
    required this.totalDays,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 10.h),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        border: Border(
          bottom: BorderSide(color: Color(0xFF334155), width: 1),
        ),
      ),
      child: Row(
        children: [
          ImageHelper(image: ImagesPaths.LJFLogo, imageType: ImageType.asset,height: 100.h,),
          // ── Logo + Title ────────────────────────────────────
          // Container(
          //   width: 44.r,
          //   height: 44.r,
          //   decoration: BoxDecoration(
          //     color: const Color(0xFFFFA726),
          //     borderRadius: BorderRadius.circular(10.r),
          //   ),
          //   child: Icon(Icons.emoji_events_rounded,
          //       color: Colors.white, size: 26.r),
          // ),
          // SizedBox(width: 14.w),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Text(
          //       eventName,
          //       style: TextStyle(
          //         fontSize: 22.sp,
          //         fontWeight: FontWeight.w900,
          //         color: Colors.white,
          //         letterSpacing: -0.5,
          //       ),
          //     ),
          //     Text(
          //       '7-Day Competitive Event',
          //       style: TextStyle(
          //         fontSize: 11.sp,
          //         color: const Color(0xFF94A3B8),
          //         fontWeight: FontWeight.w400,
          //       ),
          //     ),
          //   ],
          // ),
          // const Spacer(),
          // // ── Connection indicator ─────────────────────────────
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          //   decoration: BoxDecoration(
          //     color: isConnected
          //         ? const Color(0xFF166534).withOpacity(0.3)
          //         : const Color(0xFF7F1D1D).withOpacity(0.3),
          //     borderRadius: BorderRadius.circular(20.r),
          //     border: Border.all(
          //       color: isConnected
          //           ? const Color(0xFF22C55E)
          //           : const Color(0xFFEF4444),
          //       width: 1,
          //     ),
          //   ),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Container(
          //         width: 7.r,
          //         height: 7.r,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: isConnected
          //               ? const Color(0xFF22C55E)
          //               : const Color(0xFFEF4444),
          //         ),
          //       ),
          //       SizedBox(width: 6.w),
          //       Text(
          //         isConnected ? 'Live' : 'Offline',
          //         style: TextStyle(
          //           fontSize: 11.sp,
          //           fontWeight: FontWeight.w600,
          //           color: isConnected
          //               ? const Color(0xFF22C55E)
          //               : const Color(0xFFEF4444),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(width: 16.w),
          // // ── Day Badge ────────────────────────────────────────
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          //   decoration: BoxDecoration(
          //     color: const Color(0xFFFFA726),
          //     borderRadius: BorderRadius.circular(24.r),
          //   ),
          //   child: Text(
          //     'Day $currentDay of $totalDays',
          //     style: TextStyle(
          //       fontSize: 15.sp,
          //       fontWeight: FontWeight.w800,
          //       color: Colors.white,
          //       letterSpacing: 0.3,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
