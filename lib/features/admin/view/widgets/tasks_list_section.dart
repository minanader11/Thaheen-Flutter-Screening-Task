import 'package:LJF_admin/core/styles/colors.dart';
import 'package:LJF_admin/core/styles/styles.dart';
import 'package:LJF_admin/core/widgets/other/custom_text.dart';
import 'package:LJF_admin/features/admin/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TasksListSection extends StatelessWidget {
  final List<TaskModel> dailyTasks;
  final List<TaskModel> bonusTasks;
  final List<TaskModel> flashTasks;
  final void Function(int id) onDeleteTask;

  const TasksListSection({
    super.key,
    required this.dailyTasks,
    required this.bonusTasks,
    required this.flashTasks,
    required this.onDeleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TaskGroup(
          title: 'Daily Tasks',
          color: ColorManager.primary,
          icon: Icons.calendar_today_outlined,
          tasks: dailyTasks,
          onDelete: onDeleteTask,
        ),
        SizedBox(height: 20.h),
        _TaskGroup(
          title: 'Bonus Tasks',
          color: ColorManager.secondary,
          icon: Icons.star_outline,
          tasks: bonusTasks,
          onDelete: onDeleteTask,
        ),
        SizedBox(height: 20.h),
        _TaskGroup(
          title: 'Flash Challenges',
          color: ColorManager.tertiary,
          icon: Icons.flash_on_outlined,
          tasks: flashTasks,
          onDelete: onDeleteTask,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────
// Task group — header + list of tiles
// ─────────────────────────────────────────────────────────

class _TaskGroup extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final List<TaskModel> tasks;
  final void Function(int id) onDelete;

  const _TaskGroup({
    required this.title,
    required this.color,
    required this.icon,
    required this.tasks,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section header ───────────────────────────────
        Row(
          children: [
            Icon(icon, color: color, size: 16.r),
            SizedBox(width: 6.w),
            CustomText(
              text: title,
              style: TextStyles.font14WhiteBold.copyWith(color: color),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: CustomText(
                text: '${tasks.length}',
                style: TextStyles.font11WhiteBold.copyWith(
                  color: color,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),

        // ── Task tiles ───────────────────────────────────
        if (tasks.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: CustomText(
              text: 'No tasks yet',
              style: TextStyles.font12WhiteMedium.copyWith(
                color: Colors.white30,
              ),
            ),
          )
        else
          ...tasks.map(
            (task) => _TaskTile(
              task: task,
              color: color,
              onDelete: () => onDelete(task.id),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────
// Single task tile
// ─────────────────────────────────────────────────────────

class _TaskTile extends StatelessWidget {
  final TaskModel task;
  final Color color;
  final VoidCallback onDelete;

  const _TaskTile({
    required this.task,
    required this.color,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              text: task.name,
              style: TextStyles.font13WhiteMedium,
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 8.w),
          CustomText(
            text: task.score,
            style: TextStyles.font12WhiteBold.copyWith(color: color),
          ),
          SizedBox(width: 14.w),
          GestureDetector(
            onTap: () => _confirmDelete(context),
            child: Icon(
              Icons.delete_outline,
              color: Colors.redAccent.withOpacity(0.7),
              size: 18.r,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF0F1D2E),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: CustomText(
          text: 'Delete task?',
          style: TextStyles.font16WhiteBold,
        ),
        content: CustomText(
          text: '"${task.name}" will be permanently removed.',
          style: TextStyles.font13WhiteMedium.copyWith(color: Colors.white60),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: CustomText(
              text: 'Cancel',
              style:
                  TextStyles.font13WhiteMedium.copyWith(color: Colors.white54),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: CustomText(
              text: 'Delete',
              style: TextStyles.font13WhiteMedium
                  .copyWith(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}
