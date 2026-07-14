import 'package:LJF_admin/core/styles/colors.dart';
import 'package:LJF_admin/core/styles/styles.dart';
import 'package:LJF_admin/core/widgets/other/custom_text.dart';
import 'package:LJF_admin/features/admin/model/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateBankBalanceSheet extends StatefulWidget {
  final TeamModel team;
  final void Function({double? newBalance, double? delta}) onConfirm;

  const UpdateBankBalanceSheet({
    super.key,
    required this.team,
    required this.onConfirm,
  });

  @override
  State<UpdateBankBalanceSheet> createState() => _UpdateBankBalanceSheetState();
}

class _UpdateBankBalanceSheetState extends State<UpdateBankBalanceSheet> {
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submitDelta(bool isAdd) {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) return;
    widget.onConfirm(delta: isAdd ? amount : -amount);
    Navigator.pop(context);
  }

  void _submitAbsolute() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount < 0) return;
    widget.onConfirm(newBalance: amount);
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
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          CustomText(text: 'Bank Balance', style: TextStyles.font16WhiteBold),
          SizedBox(height: 4.h),
          CustomText(
            text: '${widget.team.name} · Current: ${widget.team.bankBalance.toStringAsFixed(0)}',
            style: TextStyles.font13WhiteMedium.copyWith(color: Colors.white54),
          ),
          SizedBox(height: 20.h),

          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            style: TextStyles.font14WhiteBold,
            decoration: InputDecoration(
              hintText: 'Amount',
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: Colors.white.withOpacity(0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: _QuickButton(
                  label: '+ Add',
                  color: ColorManager.success,
                  onTap: () => _submitDelta(true),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _QuickButton(
                  label: '- Subtract',
                  color: ColorManager.error,
                  onTap: () => _submitDelta(false),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          _QuickButton(
            label: 'Set Exact Balance',
            color: ColorManager.primary,
            onTap: _submitAbsolute,
          ),
        ],
      ),
    );
  }
}

class _QuickButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickButton({required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        alignment: Alignment.center,
        child: CustomText(
          text: label,
          style: TextStyles.font13WhiteMedium.copyWith(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}