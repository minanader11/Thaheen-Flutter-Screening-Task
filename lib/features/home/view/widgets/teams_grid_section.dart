// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../model/team_model.dart';
// import 'team_card_widget.dart';
//
// class TeamsGridSection extends StatelessWidget {
//   final List<TeamModel> teams;
//
//   const TeamsGridSection({super.key, required this.teams});
//
//   @override
//   Widget build(BuildContext context) {
//     // Sort by score desc and assign ranks
//     final sorted = List<TeamModel>.from(teams)
//       ..sort((a, b) => b.score.compareTo(a.score));
//
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//       child: GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 6,
//           crossAxisSpacing: 12.w,
//           mainAxisSpacing: 10.h,
//           childAspectRatio: 1.4,
//         ),
//         itemCount: sorted.length,
//         itemBuilder: (context, index) {
//           return TeamCardWidget(
//             team: sorted[index],
//             rank: index + 1,
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/team_model.dart';
import 'team_card_widget.dart';

class TeamsGridSection extends StatelessWidget {
  final List<TeamModel> teams;

  const TeamsGridSection({
    super.key,
    required this.teams,
  });

  @override
  Widget build(BuildContext context) {
    // Sort by score desc
    final sorted = List<TeamModel>.from(teams)
      ..sort((a, b) => b.score.compareTo(a.score));

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      child: Wrap(
        spacing: 12.w,
        runSpacing: 12.h,
        alignment: WrapAlignment.center,
        children: List.generate(
          sorted.length,
              (index) {
            return SizedBox(
              width: 270.w, // adjust width as needed
              child: TeamCardWidget(
                team: sorted[index],
                rank: index + 1,
              ),
            );
          },
        ),
      ),
    );
  }
}