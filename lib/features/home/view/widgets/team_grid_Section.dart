import 'package:base_project/features/home/view/widgets/team_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/team_model.dart';


class TeamsGridSection extends StatelessWidget {
  final List<TeamModel> teams;

  const TeamsGridSection({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 1.45,
        ),
        itemCount: teams.length,
        itemBuilder: (context, index) {
          final team = teams[index];
          final isFirst = index == 0;
          return TeamCardWidget(team: team, isFirstPlace: isFirst);
        },
      ),
    );
  }
}