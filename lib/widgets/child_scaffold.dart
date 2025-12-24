import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppScaffoldChild extends StatelessWidget {
  String? title;
  Widget body;
  List<Widget>? actions;
  Color? backgroundColor;
  Widget? floatingBtn;
  Function? onBackPressed;
  bool? resizeToAvoidBottomInset;
  Widget? bottom;

  AppScaffoldChild({
    this.title,
    required this.body,
    required this.actions,
    this.backgroundColor,
    this.floatingBtn,
    this.resizeToAvoidBottomInset = false,
    this.onBackPressed,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop(BuildContext context) {
      // showDialog(
      //   barrierDismissible: true,
      //   context: context,
      //   builder: (BuildContext context) {
      //     return CustomAlertDialog(
      //       title: "Alert",
      //       btnPosClick: () {
      //         SystemNavigator.pop();
      //       },
      //       isSingleButton: false,
      //       btnPositiveText: "Yes",
      //       btnNegativeText: "No",
      //       message: "Are you sure want to exit?",
      //       btnNegClick: () {
      //         Navigator.pop(context);
      //       },
      //       messageWidget: null,
      //     );
      //   },
      // );
      Get.back(result: true);
      return Future.value(false);
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        onWillPop(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(color: Color(0x21cacaca), height: 3.0),
          ),
          //centerTitle: true,
          //titleSpacing: 20,
          centerTitle: true,
          /* titleTextStyle:
              subtitle.copyWith(color: TMode.obj().textPrimaryColor),*/
          title: Text(
            title ?? "",
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Colors.black,
            ),
            // style: _getTitleTextStyle(),
          ),
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              if (onBackPressed != null) {
                onBackPressed?.call();
              } else {
                Get.back(result: true);
              }
            },
            child: Icon(
              Icons.keyboard_arrow_left,
              size: 24,
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Colors.black,
            ),
          ),
          //backgroundColor: TMode.obj().primaryBackgroundColor,
          elevation: 0,
          toolbarHeight: 50,
          // default is 56
          actions: actions,
          /*bottom: PreferredSize(
                  preferredSize: Size.fromHeight(2),
                  child: Divider(thickness: 0.5, color: TMode.obj().secondaryAccent),
                )*/
        ),
        floatingActionButton: floatingBtn ?? null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SafeArea(child: body),
        bottomNavigationBar: bottom,
      ),
    );
  }
}
