import 'package:LJF_admin/core/styles/colors.dart';
import 'package:LJF_admin/core/styles/styles.dart';
import 'package:LJF_admin/core/widgets/other/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateBankCertificateSheet extends StatefulWidget {
  final void Function({required int durationMinutes, required double percentageGain}) onConfirm;

  const CreateBankCertificateSheet({super.key, required this.onConfirm});

  @override
  State<CreateBankCertificateSheet> createState() => _CreateBankCertificateSheetState();
}

class _CreateBankCertificateSheetState extends State<CreateBankCertificateSheet> {
  final _durationController = TextEditingController();
  final _percentageController = TextEditingController();

  @override
  void dispose() {
    _durationController.dispose();
    _percentageController.dispose();
    super.dispose();
  }

  void _submit() {
    final duration = int.tryParse(_durationController.text);
    final percentage = double.tryParse(_percentageController.text);
    if (duration == null || duration <= 0 || percentage == null || percentage < 0) return;
    widget.onConfirm(durationMinutes: duration, percentageGain: percentage);
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
          CustomText(text: 'New Certificate', style: TextStyles.font16WhiteBold),
          SizedBox(height: 20.h),
          TextField(
            controller: _durationController,
            keyboardType: TextInputType.number,
            style: TextStyles.font14WhiteBold,
            decoration: InputDecoration(
              hintText: 'Duration (minutes)',
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: Colors.white.withOpacity(0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: _percentageController,
            keyboardType: TextInputType.number,
            style: TextStyles.font14WhiteBold,
            decoration: InputDecoration(
              hintText: 'Percentage gain (e.g. 5)',
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: Colors.white.withOpacity(0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              onPressed: _submit,
              child: CustomText(
                text: 'Create',
                style: TextStyles.font13WhiteMedium.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}