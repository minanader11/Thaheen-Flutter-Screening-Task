import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/styles.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/task_model.dart';

class TaskColumnWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final List<TaskModel> tasks;

  const TaskColumnWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.textPrimary,
        borderRadius: BorderRadius.circular(12.r),
      //  border: Border.all(color: const Color(0xFF334155), width: 1),
      ),
      child: Column(
        children: [
          // ── Header ────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: ColorManager.textPrimary, size: 18.r),
                SizedBox(width: 8.w),
                CustomText(
                 text:  title,
                  textStyle: TextStyles.teamNameLarge.copyWith(color: ColorManager.textPrimary)
                ),
                const Spacer(),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    '${tasks.length}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ── Task list ─────────────────────────────────────
          Expanded(
            child: tasks.isEmpty
                ? Center(
                    child: CustomText(
                     text:  'No tasks yet',
                      textStyle: TextStyles.bodyLarge.copyWith(color: ColorManager.neutral)
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(
                        vertical: 6.h, horizontal: 0),
                    itemCount: tasks.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h,),
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return _TaskRow(task: task, color: color);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  final TaskModel task;
  final Color color;

  const _TaskRow({required this.task, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          // ── Dot ─────────────────────────────────────────
          Container(
            width: 6.r,
            height: 6.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          SizedBox(width: 10.w),
          // ── Name ─────────────────────────────────────────
          Expanded(
            child: CustomText(
              text:task.name,
              textStyle: TextStyles.bodyMedium.copyWith(color: ColorManager.neutral,fontSize: 20.sp)
           //   maxLines: 1,
            //  overflow: TextOverflow.ellipsis,
            ),
          ),
          // ── Points badge ─────────────────────────────────
          if (task.points != null)
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: color.withOpacity(0.4), width: 1),
              ),
              child: CustomText(
               text:  '+${task.points} pts',
                  textStyle: TextStyles.bodyMedium.copyWith(color: color,fontSize: 20.sp,fontWeight: FontWeight.w900)
              ),
            ),
        ],
      ),
    );
  }
}
