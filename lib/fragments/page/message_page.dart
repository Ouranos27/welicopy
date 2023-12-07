import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/image.dart';

class AppMessageScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool isBack;
  final Function()? onWillPop;
  final Widget? bottomWidget;
  final Widget? action;
  final Widget? titleAction;

  const AppMessageScaffold({
    required this.title,
    required this.body,
    this.isBack = true,
    Key? key,
    this.onWillPop,
    this.bottomWidget,
    this.action,
    this.titleAction,
  }) : super(key: key);

  Future<bool> _willPopCallback() async {
    onWillPop?.call();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom + MediaQuery.of(context).padding.top;
    final scale = 1.5;
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  height: 16.h + MediaQuery.of(context).padding.top,
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: isBack
                            ? IconButton(
                                icon: const Icon(Ionicons.chevron_back_outline, size: 32, color: Colors.white),
                                onPressed: Navigator.of(context).pop,
                              )
                            : null,
                        trailing: action,
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
                        leading: SvgPicture.asset(AppImage.iconWeliTransparent, width: 6.w * scale, color: Colors.white),
                        minLeadingWidth: 0,
                        trailing: titleAction ?? const SizedBox(),
                        title: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.white,
                                fontSize: 20.0 * scale,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        dense: true,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 84.h,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.only(bottom: bottomPadding),
                  child: body,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomWidget,
      ),
    );
  }
}
