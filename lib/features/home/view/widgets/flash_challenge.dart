import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/styles.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/task_model.dart';

class FlashChallengesSection extends StatelessWidget {
  final List<TaskModel> tasks;

  const FlashChallengesSection({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return _buildTaskColumn(
      title: "Flash Challenges",
      icon: Icons.flash_on,
      color: ColorManager.flashTask,
      tasks: tasks,
    );
  }
}

Widget _buildTaskColumn({
  required String title,
  required IconData icon,
  required Color color,
  required List<TaskModel> tasks,
}) {
  return Container(
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 24.sp),
              SizedBox(width: 8.w),
              CustomText(
                text: title,
                textStyle: TextStyles.titleLarge.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(12.w),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: task.name,
                        textStyle: TextStyles.bodyLarge,
                      ),
                    ),
                    if (task.points != null)
                      CustomText(
                        text: "+${task.points} pts",
                        textStyle: TextStyles.labelLarge.copyWith(color: color),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}