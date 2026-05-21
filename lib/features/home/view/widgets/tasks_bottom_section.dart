import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/task_model.dart';
import 'task_column_widget.dart';

class TasksBottomSection extends StatelessWidget {
  final List<TaskModel> dailyTasks;
  final List<TaskModel> bonusTasks;
  final List<TaskModel> flashTasks;

  const TasksBottomSection({
    super.key,
    required this.dailyTasks,
    required this.bonusTasks,
    required this.flashTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          // ── Daily Tasks ──────────────────────────────────
          Expanded(
            child: TaskColumnWidget(
              title: 'Daily Tasks',
              icon: Icons.calendar_today_rounded,
              color: const Color(0xFF5BA3D0),
              bgColor: const Color(0xFF1E3A4F),
              tasks: dailyTasks,
            ),
          ),
          SizedBox(width: 12.w),
          // ── Bonus Tasks ───────────────────────────────────
          Expanded(
            child: TaskColumnWidget(
              title: 'Bonus Tasks',
              icon: Icons.star_rounded,
              color: const Color(0xFFFFA726),
              bgColor: const Color(0xFF3D2A0A),
              tasks: bonusTasks,
            ),
          ),
          SizedBox(width: 12.w),
          // ── Flash Challenges ──────────────────────────────
          Expanded(
            child: TaskColumnWidget(
              title: 'Flash Challenges',
              icon: Icons.bolt_rounded,
              color: const Color(0xFF6CBF56),
              bgColor: const Color(0xFF1A3312),
              tasks: flashTasks,
            ),
          ),
        ],
      ),
    );
  }
}
