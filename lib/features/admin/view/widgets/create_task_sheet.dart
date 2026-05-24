
import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/styles.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateTaskSheet extends StatefulWidget {
  final void Function({
    required String name,
    required String type,
    required String score,
  }) onConfirm;

  const CreateTaskSheet({super.key, required this.onConfirm});

  @override
  State<CreateTaskSheet> createState() => _CreateTaskSheetState();
}

class _CreateTaskSheetState extends State<CreateTaskSheet> {
  final _nameCtrl = TextEditingController();
  final _scoreCtrl = TextEditingController();
  String _selectedType = 'Daily';

  static const _types = ['Daily', 'Bonus', 'Flash'];

  static const _typeColors = {
    'Daily': ColorManager.primary,
    'Bonus': ColorManager.secondary,
    'Flash': ColorManager.tertiary,
  };

  @override
  void dispose() {
    _nameCtrl.dispose();
    _scoreCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameCtrl.text.trim();
    final score = _scoreCtrl.text.trim();
    if (name.isEmpty || score.isEmpty) return;

    widget.onConfirm(name: name, type: _selectedType, score: score);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1D2E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          CustomText(text: 'Create Task', style: TextStyles.font16WhiteBold),
          SizedBox(height: 20.h),

          // Task name
          _label('Task name'),
          SizedBox(height: 6.h),
          TextField(
            controller: _nameCtrl,
            style: TextStyles.font13WhiteMedium,
            decoration: _inputDecoration('Enter task name'),
          ),
          SizedBox(height: 14.h),

          // Score / points
          _label('Points'),
          SizedBox(height: 6.h),
          TextField(
            controller: _scoreCtrl,
            keyboardType: TextInputType.number,
            style: TextStyles.font13WhiteMedium,
            decoration: _inputDecoration('e.g. 100'),
          ),
          SizedBox(height: 14.h),

          // Type selector
          _label('Type'),
          SizedBox(height: 8.h),
          Row(
            children: _types.map((type) {
              final isSelected = _selectedType == type;
              final color = _typeColors[type]!;
              return GestureDetector(
                onTap: () => setState(() => _selectedType = type),
                child: Container(
                  margin: EdgeInsets.only(right: 10.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? color.withOpacity(0.2)
                        : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected ? color : Colors.white12,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: CustomText(
                    text: type,
                    style: TextStyles.font13WhiteMedium.copyWith(
                      color: isSelected ? color : Colors.white54,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 24.h),

          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: _typeColors[_selectedType],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: CustomText(
                text: 'Create $_selectedType Task',
                style: TextStyles.font16WhiteBold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => CustomText(
        text: text,
        style:
            TextStyles.font12WhiteMedium.copyWith(color: Colors.white60),
      );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle:
            TextStyles.font13WhiteMedium.copyWith(color: Colors.white30),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
              BorderSide(color: ColorManager.primary, width: 1.5),
        ),
      );
}
