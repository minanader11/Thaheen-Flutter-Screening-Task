import 'package:LJF_admin/core/widgets/app_drawer/app_drawer.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  final Widget? bottomNAvigationBar;
  const BaseScaffold({
    required this.body,
    this.appBar,
    this.scaffoldKey,

    this.bottomNAvigationBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      drawer:  AppDrawer(scaffoldKey: scaffoldKey,),
      body: body,
      bottomNavigationBar:bottomNAvigationBar ,
    );
  }
}
