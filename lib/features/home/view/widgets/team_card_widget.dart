import 'dart:convert';
import 'dart:developer';
import 'package:base_project/core/config/end_points.dart';
import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/styles.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:base_project/core/widgets/other/image_helper.dart';
import 'package:base_project/features/home/view/widgets/team_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/team_model.dart';

class TeamCardWidget extends StatelessWidget {
  final TeamModel team;
  final int rank;

  const TeamCardWidget({
    super.key,
    required this.team,
    required this.rank,
  });

  bool get isFirst => rank == 1;

  Color get _rankBorderColor {
    switch (rank) {
      case 1:
        return const Color(0xFFFFA726);
      case 2:
        return const Color(0xFFB0BEC5);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return const Color(0xFF334155);
    }
  }

  Color _teamColor(TeamModel team) {
    // if (rank == 1) return const Color(0xFFFFA726);
    return _parseColor(team.colorCode, const Color(0xFF5BA3D0));
  }

  Color _parseColor(String? hex, Color fallback) {
    if (hex == null || hex.isEmpty) return fallback;
    try {
      final clean = hex.replaceAll('#', '');
      return Color(int.parse('FF$clean', radix: 16));
    } catch (_) {
      return fallback;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _teamColor(team);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: ColorManager.textPrimary,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.r),
            topLeft: Radius.circular(12.r),
            bottomLeft: Radius.circular(12.r),
            bottomRight: Radius.circular(12.r)),
        border: Border(top: BorderSide(color: color, width: 5)),
        //  border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.4), blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── Top row: crown | avatar | rank ──────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Crown (only for #1, keeps space otherwise)
                SizedBox(
                  width: 18.r,
                  height: 18.r,
                  child: isFirst
                      ? Icon(Icons.workspace_premium_rounded,
                          color: _teamColor(team), size: 40.r)
                      : null,
                ),
                // Avatar

                // Rank badge
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: _teamColor(team),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: CustomText(
                      text: '$rank',
                      textStyle: TextStyles.bodyLarge
                          .copyWith(color: ColorManager.white)),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            _TeamAvatar(image: team.image, isFirst: isFirst, color: color),
            // ── Team name ────────────────────────────────────
            CustomText(
              text: team.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              textStyle: TextStyles.teamNameLarge
                  .copyWith(color: color, fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 4.h),
            // ── Score ─────────────────────────────────────────
            // AnimatedDefaultTextStyle(
            //   duration: const Duration(milliseconds: 300),
            //   style: TextStyle(
            //     fontSize: 22.sp,
            //     fontWeight: FontWeight.w900,
            //     color: color,
            //     //  letterSpacing: -1,
            //   ),
            //   child: CustomText(
            //     text: team.score.toString(),
            //     textStyle: TextStyles.scoreLarge.copyWith(
            //         color: _teamColor(team), fontWeight: FontWeight.w900),
            //   ),
            // ),
            CustomText(
              text: team.score.toString(),
              textStyle: TextStyles.scoreLarge.copyWith(
                  color: _teamColor(team), fontWeight: FontWeight.w900),
            ),

            if (team.teamSuperPowers.isNotEmpty)
              // CustomText(
              //   text: team.teamSuperPowers?.length.toString()??"noooo",
              //   textStyle: TextStyles.scoreLarge.copyWith(
              //       color: _teamColor(team), fontWeight: FontWeight.w900),
              // ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.w,
                runSpacing: 8.h,
                children: team.teamSuperPowers.map(_buildSuperPower).toList(),
              ),
              // Wrap(
              //   alignment: WrapAlignment.center,
              //   spacing: 8.w,
              //   children: team.teamSuperPowers.map((power) {
              //     return Container(
              //       width: 70.w,
              //       height: 70.h,
              //       padding: EdgeInsets.all(6.r),
              //       decoration: BoxDecoration(
              //         color: Colors.white.withOpacity(0.08),
              //         shape: BoxShape.circle,
              //         border: Border.all(
              //           color: Colors.white24,
              //         ),
              //       ),
              //       child: ImageHelper(image: getSuperPowerImage(power.type), imageType: ImageType.memory,imageShape: ImageShape.circle,)
              //     );
              //   }).toList(),
              // ),
          ],
        ),
      ),
    );
  }
}

class _TeamAvatar extends StatelessWidget {
  final String? image;
  final bool isFirst;
  final Color color;

  const _TeamAvatar({
    this.image,
    required this.isFirst,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = image != null && image!.isNotEmpty;
    log("teamImage ${EndPoints.imageBaseURl}${image}");

    return
      // Container(
      // width: 80.r,
      // height: 80.r,
      // decoration: BoxDecoration(
      //   shape: BoxShape.circle,
      //   // color: color,
      //   // border: Border.all(color: color, width: 2),
      // ),
      // clipBehavior: Clip.antiAlias,
      // child:
      hasImage
          ?
      Container(
        width: 70.w,
        height: 70.w,
       // padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          shape: BoxShape.circle,
          border: Border.all(
            color: color,
          ),
        ),
        child: ImageHelper(
          image: "${EndPoints.imageBaseURl}${image}",
          imageType: ImageType.network,
          imageShape: ImageShape.circle,
          boxFit: BoxFit.fill,
        ),
      )
          : Icon(Icons.groups_rounded, color: color, size: 24.r);

  }

  Widget _buildBase64Image(String base64String) {
    try {
      final bytes = base64Decode(base64String);
      return ImageHelper(
        image: base64String,
        imageType: ImageType.memory,
        boxFit: BoxFit.fill,
        width: 80.r,
        height: 80.r,
        imageShape: ImageShape.circle,
      );
    } catch (_) {
      return Icon(Icons.groups_rounded, color: color, size: 24.r);
    }
  }
}
Widget _buildSuperPower(TeamSuperPower power) {
  final isUsed = power.status == "Deactivated";
  final isActive = power.status == "Activated";
  final isAvailable = power.status == "NotUsedYet";

  // ───────────────── ACTIVE ─────────────────
  if (isActive) {
    return Container(
      width: 72.w,
      height: 72.w,
      padding: EdgeInsets.all(5.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.orange.withOpacity(0.9),
            Colors.red.withOpacity(0.9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.6),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImageHelper(
            image: "${EndPoints.imageBaseURl}${power.imageBase64}",
            imageType: ImageType.network,
            imageShape: ImageShape.circle,
          ),

          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 6.w,
                vertical: 2.h,
              ),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                "ACTIVE",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────── USED ─────────────────
  if (isUsed) {
    return Opacity(
      opacity: 0.35,
      child: Container(
        width: 64.w,
        height: 64.w,
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ImageHelper(
              image: "${EndPoints.imageBaseURl}${power.imageBase64}",
              imageType: ImageType.network,
              imageShape: ImageShape.circle,
            ),

            Icon(
              Icons.close_rounded,
              color: Colors.redAccent,
              size: 28.r,
            ),
          ],
        ),
      ),
    );
  }
 log("imageeeeeee ${EndPoints.imageBaseURl}${power.imageBase64}");
  // ───────────────── AVAILABLE ─────────────────
  return Container(
    width: 64.w,
    height: 64.w,
    padding: EdgeInsets.all(8.r),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.08),
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.white24,
      ),
    ),
    child: ImageHelper(
      image: "${EndPoints.imageBaseURl}${power.imageBase64}",
      imageType: ImageType.network,
      imageShape: ImageShape.circle,
    ),
  );
}