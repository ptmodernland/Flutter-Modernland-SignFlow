import 'package:bwa_cozy/bloc/notif/notif_bloc.dart';
import 'package:bwa_cozy/bloc/notif/notif_event.dart';
import 'package:bwa_cozy/bloc/notif/notif_state.dart';
import 'package:bwa_cozy/repos/login_repository.dart';
import 'package:bwa_cozy/repos/notif_repository.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/widget/approval/item_approval_widget.dart';
import 'package:bwa_cozy/widget/menus/menu_item_approval_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickalert/quickalert.dart';

class ApprovalPBJMainPage extends StatefulWidget {
  const ApprovalPBJMainPage({Key? key}) : super(key: key);

  @override
  State<ApprovalPBJMainPage> createState() => _ApprovalPBJMainPageState();
}

class _ApprovalPBJMainPageState extends State<ApprovalPBJMainPage> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    LoginRepository loginRepository = LoginRepository();
  }

  @override
  Widget build(BuildContext context) {
    var username = "";

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    NotifRepository notifRepository = NotifRepository();
    NotifCoreBloc notifBloc = NotifCoreBloc(notifRepository);

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (BuildContext context) {
            return notifBloc..add(NotifEventCount());
          },
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocListener<NotifCoreBloc, NotifCoreState>(
                      listener: (context, state) {
                        if (state is NotifStateFailure) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          print("auth state is error");
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              text: state.error.toString(),
                              showCancelBtn: false,
                              title: "Error",
                              autoCloseDuration: Duration(seconds: 3));
                        }
                        if (state is NotifStateLoading) {
                          print("auth state is loading");
                        }

                        if (state is NotifStateSuccess) {
                          Fluttertoast.showToast(
                            msg: "Ada " +
                                state.totalPermohonan +
                                " approval belum diapprove",
                          );
                        }
                      },
                      child: Container(),
                    ),
                    Container(
                      height: 150,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                image: AssetImage(
                                    'asset/img/background/bg_pattern_fp.png'),
                                repeat: ImageRepeat.repeat,
                              ),
                            ),
                            width: double.infinity,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Permohonan Barang dan Jasa",
                                      style: MyTheme.myStylePrimaryTextStyle
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      width: MediaQuery.sizeOf(context).width,
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 0, right: 0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30.0)),
                            ),
                            child: Container(
                              child: Column(
                                children: [
                                  BlocBuilder<NotifCoreBloc, NotifCoreState>(
                                      builder: (context, state) {
                                    var count = "";
                                    BoxDecoration? badgeNotifDecoration = null;

                                    if (state is NotifStateLoading) {}
                                    if (state is NotifStateFailure) {}

                                    if (state is NotifStateSuccess) {
                                      count = state.totalPermohonan;
                                    }
                                    return MenuItemApprovalWidget(
                                      unreadBadgeCount: count,
                                      onLeftTapFunction: () {
                                        Fluttertoast.showToast(
                                            msg: "Left",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      },
                                      onRightTapFunction: () {
                                        Fluttertoast.showToast(
                                            msg: "Right",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      },
                                    );
                                  }),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Request Terbaru",
                                          textAlign: TextAlign.start,
                                          style: MyTheme.myStylePrimaryTextStyle
                                              .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  BlocBuilder<NotifCoreBloc, NotifCoreState>(
                                      builder: (context, state) {
                                    if (state is NotifStateLoading) {}
                                    if (state is NotifStateFailure) {}

                                    if (state is NotifStateSuccess) {}

                                    return Container();
                                  }),
                                  Column(
                                    children: [
                                      ItemApprovalWidget(),
                                      ItemApprovalWidget(),
                                      ItemApprovalWidget(),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
