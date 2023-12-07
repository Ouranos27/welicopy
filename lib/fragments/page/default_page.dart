import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/image.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool scrollable;
  final bool isBack;
  final Function()? onWillPop;
  final Widget? bottomWidget;
  final Widget? action;
  final Widget? titleAction;

  const AppScaffold({
    required this.title,
    required this.body,
    this.scrollable = true,
    this.isBack = true,
    Key? key,
    this.onWillPop,
    this.bottomWidget,
    this.action,
    this.titleAction,
  }) : super(key: key);

  Future<bool> _willPopCallback() async {
    onWillPop?.call();
    return Future.value(isBack);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1792EA), Color(0xFF21C8D1)],
            ),
          ),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
              SliverAppBar(
                expandedHeight: 16.h,
                floating: false,
                pinned: false,
                backgroundColor: Colors.transparent,
                leading: isBack
                    ? IconButton(
                        icon: const Icon(Ionicons.chevron_back_outline, size: 32, color: Colors.white),
                        onPressed: Navigator.of(context).pop,
                      )
                    : null,
                actions: action != null ? [action!] : null,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: EdgeInsets.symmetric(vertical: 2.h),
                  title: ListTile(
                    leading: SvgPicture.asset(AppImage.iconWeliTransparent, width: 6.w, color: Colors.white),
                    minLeadingWidth: 0,
                    title: Row(
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        titleAction ?? const SizedBox()
                      ],
                    ),
                    dense: true,
                  ),
                ),
              ),
            ],
            body: DecoratedBox(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.white,
              ),
              child: scrollable ? SingleChildScrollView(child: body) : body,
            ),
          ),
        ),
        bottomNavigationBar: bottomWidget,
      ),
    );
  }
}
