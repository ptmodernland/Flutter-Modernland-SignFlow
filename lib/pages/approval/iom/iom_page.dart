import 'package:bwa_cozy/bloc/all_approval/approval_main_page_bloc.dart';
import 'package:bwa_cozy/bloc/all_approval/approval_main_page_event.dart';
import 'package:bwa_cozy/bloc/all_approval/approval_main_page_state.dart';
import 'package:bwa_cozy/bloc/iomcategorycounter/badge_counter_cubit.dart';
import 'package:bwa_cozy/bloc/iomcategorycounter/badge_counter_state.dart';
import 'package:bwa_cozy/bloc/notif/notif_bloc.dart';
import 'package:bwa_cozy/bloc/notif/notif_event.dart';
import 'package:bwa_cozy/bloc/notif/notif_state.dart';
import 'package:bwa_cozy/pages/approval/compare/compare_approved_all_page.dart';
import 'package:bwa_cozy/pages/approval/compare/compare_waiting_approval_page.dart';
import 'package:bwa_cozy/pages/approval/compare/detail_compare_page.dart';
import 'package:bwa_cozy/repos/approval_main_page_repository.dart';
import 'package:bwa_cozy/repos/badge_counter_repository.dart';
import 'package:bwa_cozy/repos/notif_repository.dart';
import 'package:bwa_cozy/util/core/string/html_util.dart';
import 'package:bwa_cozy/util/enum/menu_type.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/widget/approval/iom_menu_icon_widget.dart';
import 'package:bwa_cozy/widget/approval/item_approval_widget.dart';
import 'package:bwa_cozy/widget/menus/menu_item_approval_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovalIomMainPage extends StatefulWidget {
  const ApprovalIomMainPage({Key? key}) : super(key: key);

  @override
  State<ApprovalIomMainPage> createState() => _ApprovalIomMainPageState();
}

class _ApprovalIomMainPageState extends State<ApprovalIomMainPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    NotifRepository notifRepository = NotifRepository();
    NotifCoreBloc notifBloc = NotifCoreBloc(notifRepository);

    ApprovalMainPageRepository approvalRepo = ApprovalMainPageRepository();
    ApprovalMainPageBloc approvalBloc = ApprovalMainPageBloc(approvalRepo);

    final badgeCounterRepository = BadgeCounterRepository();
    final badgeCounterCubit = BadgeCounterCubit(badgeCounterRepository);
    badgeCounterCubit.fetchBadgeCounter();

    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
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
                                margin: EdgeInsets.only(
                                    left: 30, right: 30, top: 10),
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Inter Office Memo",
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
                        transform: Matrix4.translationValues(0.0, -20.0, 0.0),
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
                              margin:
                                  EdgeInsets.only(top: 20, left: 0, right: 0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30.0)),
                              ),
                              child: Container(
                                child: Column(
                                  children: [
                                    BlocProvider(
                                        create: (BuildContext context) {
                                          return notifBloc
                                            ..add(NotifEventCount());
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              BlocBuilder<NotifCoreBloc,
                                                      NotifCoreState>(
                                                  builder: (context, state) {
                                                var count = "";
                                                if (state
                                                    is NotifStateLoading) {}
                                                if (state
                                                    is NotifStateFailure) {}
                                                if (state
                                                    is NotifStateSuccess) {
                                                  count = state.totalIom;
                                                }
                                                return MenuItemApprovalWidget(
                                                  unreadBadgeCount: count,
                                                  onLeftTapFunction: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            CompareWaitingApprovalPage(),
                                                      ),
                                                    ).then((value) {
                                                      notifBloc
                                                        ..add(
                                                            NotifEventCount());
                                                      approvalBloc
                                                        ..add(RequestDataEvent(
                                                            ApprovalListType
                                                                .COMPARE));
                                                      print("kocak " +
                                                          value.toString());
                                                    });
                                                  },
                                                  onRightTapFunction: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            CompareAllApprovedPage(),
                                                      ),
                                                    ).then((value) {
                                                      notifBloc
                                                        ..add(
                                                            NotifEventCount());
                                                      approvalBloc
                                                        ..add(RequestDataEvent(
                                                            ApprovalListType
                                                                .COMPARE));
                                                    });
                                                  },
                                                );
                                              }),
                                            ],
                                          ),
                                        )),
                                    SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            margin: EdgeInsets.only(
                                                left: 25, right: 25, top: 50),
                                            child: BlocBuilder<
                                                BadgeCounterCubit,
                                                BadgeCounterState>(
                                              bloc: badgeCounterCubit
                                                ..fetchBadgeCounter(),
                                              builder: (context, state) {
                                                return Wrap(
                                                  alignment:
                                                      WrapAlignment.spaceAround,
                                                  spacing: 38,
                                                  runSpacing: 23,
                                                  children: [
                                                    IomMenuIconWidget(
                                                      iconData: CupertinoIcons
                                                          .money_dollar_circle,
                                                      label: "Billionaire Club",
                                                      badgeCount: state
                                                          .totalMarketingClub, //done
                                                    ),
                                                    IomMenuIconWidget(
                                                      iconData: CupertinoIcons
                                                          .doc_chart,
                                                      label:
                                                          "Finance Accounting",
                                                      badgeCount: state
                                                          .totalFinance, //done
                                                    ),
                                                    IomMenuIconWidget(
                                                      iconData: CupertinoIcons
                                                          .square_stack_3d_up_fill,
                                                      label:
                                                          "Quantity Surveyor",
                                                      badgeCount:
                                                          state.totalQS, //done
                                                    ),
                                                    IomMenuIconWidget(
                                                      iconData: CupertinoIcons
                                                          .building_2_fill,
                                                      label: "Town Management",
                                                      badgeCount:
                                                          state.totalTown,
                                                    ),
                                                    IomMenuIconWidget(
                                                      iconData:
                                                          CupertinoIcons.hammer,
                                                      label: "Technical",
                                                      badgeCount:
                                                          state.totalProject,
                                                    ),
                                                    IomMenuIconWidget(
                                                      iconData: CupertinoIcons
                                                          .person_3_fill,
                                                      label: "Human Resource",
                                                      badgeCount:
                                                          state.totalHRD,
                                                    ),
                                                    IomMenuIconWidget(
                                                      iconData:
                                                          CupertinoIcons.folder,
                                                      label: "Legal Operation",
                                                      badgeCount:
                                                          state.totalLegal,
                                                    ),
                                                    IomMenuIconWidget(
                                                      iconData: CupertinoIcons
                                                          .shopping_cart,
                                                      label: "Purchasing",
                                                      badgeCount:
                                                          state.totalPurchasing,
                                                    ),
                                                    IomMenuIconWidget(
                                                      iconData: CupertinoIcons
                                                          .chart_bar_alt_fill,
                                                      label:
                                                          "Business Development",
                                                      badgeCount:
                                                          state.totalBDD,
                                                    ),
                                                    IomMenuIconWidget(
                                                      iconData:
                                                          CupertinoIcons.home,
                                                      label: "Landed Project",
                                                      badgeCount:
                                                          state.totalLanded,
                                                    ),
                                                    IomMenuIconWidget(
                                                      iconData: CupertinoIcons
                                                          .chart_bar,
                                                      label: "Marketing",
                                                      badgeCount:
                                                          state.totalMarketing,
                                                    ),
                                                    IomMenuIconWidget(
                                                      iconData: CupertinoIcons
                                                          .check_mark_circled,
                                                      label:
                                                          "Permit Certification",
                                                      badgeCount:
                                                          state.totalPermit,
                                                    ),
                                                    IomMenuIconWidget(
                                                      iconData:
                                                          CupertinoIcons.gift,
                                                      label: "Promosi",
                                                      badgeCount:
                                                          state.totalPromosi,
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 50),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: double.infinity,
                        child: Text(
                          "Request Terbaru",
                          textAlign: TextAlign.start,
                          style: MyTheme.myStylePrimaryTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      BlocProvider(
                        create: (BuildContext context) {
                          return approvalBloc
                            ..add(RequestDataEvent(ApprovalListType.IOM));
                        },
                        child: BlocBuilder<ApprovalMainPageBloc,
                            ApprovalMainPageState>(
                          builder: (context, state) {
                            var status = "";
                            Widget dataList = Text("");
                            if (state is ApprovalMainPageStateLoading) {}
                            if (state is ApprovalMainPageStateFailure) {}
                            if (state
                                is ApprovalMainPageStateSuccessListCompare) {
                              var pbjList = state.datas;

                              if (pbjList.isEmpty) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: 50, left: 20, right: 20),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        'http://feylabs.my.id/fm/mdln_asset/mdln_empty_image.png',
                                        // Adjust the image properties as per your requirement
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Belum Ada Request Baru',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              dataList = ListView.builder(
                                itemCount: pbjList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final pbjItem = pbjList[index];
                                  var isApproved = false;
                                  if (pbjItem.status != "Y") {
                                    isApproved = true;
                                  }
                                  return ItemApprovalWidget(
                                    isApproved: isApproved,
                                    itemCode: (index + 1).toString() +
                                        pbjItem.noCompare.toString() +
                                        pbjList.length.toString(),
                                    date: pbjItem.tglPermintaan,
                                    requiredId: pbjItem.idCompare,
                                    personName: pbjItem.namaUser,
                                    departmentTitle: pbjItem.department,
                                    descriptiveText: removeHtmlTags(
                                        pbjItem.descCompare ?? ""),
                                    onPressed: (String noCompare) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailComparePage(
                                                  noCompare:
                                                      pbjItem.noCompare ?? "",
                                                  idCompare:
                                                      pbjItem.idCompare ?? ""),
                                        ),
                                      ).then((value) {
                                        notifBloc..add(NotifEventCount());
                                        approvalBloc
                                          ..add(RequestDataEvent(
                                              ApprovalListType.IOM));
                                      });
                                    },
                                  );
                                },
                              );
                            }
                            return Container(
                              child: dataList,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
