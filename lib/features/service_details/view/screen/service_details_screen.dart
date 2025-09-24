import 'dart:developer';

import 'package:base_project/core/get_it/dependecy_injection.dart';
import 'package:base_project/core/widgets/app_sheard_widgets/custom_app_bar.dart';
import 'package:base_project/core/widgets/base_scaffold/base_scaffold.dart';
import 'package:base_project/features/service_details/view/widgets/apply_button.dart';
import 'package:base_project/features/service_details/view/widgets/request_stages_widget.dart';
import 'package:base_project/features/service_details/view/widgets/service_details_appbar.dart';
import 'package:base_project/features/service_details/view/widgets/service_expansion_container.dart';
import 'package:base_project/features/service_details/view/widgets/service_information_section.dart';
import 'package:base_project/features/service_details/view_model/cubit.dart';
import 'package:base_project/features/service_details/view_model/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/generated/l10n.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceDetailsCubit>(
      create: (context) => getIt<ServiceDetailsCubit>(),
      child: BaseScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: CustomAppBar(
            height: 240.h,
            withBackArrow: true,
            appBarTitle: S.current.serviceDetails,
            onTapDrawerMenu: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            contentWidget: const ServiceDetailsAppbarContentWidget()),
        body: SingleChildScrollView(
          child: BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
            builder: (context, state) => Container(
              padding:
                  EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 48.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ServiceInformationSection(),
                  SizedBox(height: 48.h),
                  ServiceExpansionContainer(
                    forConditions: true,
                    isExpanded: state.servicesItems[0].expanded,
                    onToggle: () {
                      log("minaaaaaaaaaaa");
                      context.read<ServiceDetailsCubit>().changeExpansion(0);
                    },
                  ),
                  SizedBox(height: 32.h),
                  ServiceExpansionContainer(
                    forConditions: false,
                    isExpanded: state.servicesItems[1].expanded,
                    onToggle: () {
                      log("minaaaaaaaaaaa");

                      context.read<ServiceDetailsCubit>().changeExpansion(1);
                    },
                  ),
                  SizedBox(height: 32.h),
                  const ApplyButton(isEligble: true),
                  SizedBox(height: 48.h),
                  const RequestStagesWidget(),
                  SizedBox(height: 48.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
