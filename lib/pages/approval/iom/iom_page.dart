import 'package:bwa_cozy/bloc/all_approval/approval_main_page_bloc.dart';
import 'package:bwa_cozy/bloc/all_approval/approval_main_page_event.dart';
import 'package:bwa_cozy/bloc/iomcategorycounter/badge_counter_cubit.dart';
import 'package:bwa_cozy/bloc/iomcategorycounter/badge_counter_state.dart';
import 'package:bwa_cozy/bloc/notif/notif_bloc.dart';
import 'package:bwa_cozy/bloc/notif/notif_event.dart';
import 'package:bwa_cozy/bloc/notif/notif_state.dart';
import 'package:bwa_cozy/pages/approval/iom/iom_approved_all_page.dart';
import 'package:bwa_cozy/pages/approval/iom/iom_list_by_category_page.dart';
import 'package:bwa_cozy/pages/approval/iom/iom_waiting_approval_page.dart';
import 'package:bwa_cozy/pages/approval/koordinasi/koordinasi_history_page.dart';
import 'package:bwa_cozy/pages/approval/koordinasi/koordinasi_waiting_all_page.dart';
import 'package:bwa_cozy/repos/approval_main_page_repository.dart';
import 'package:bwa_cozy/repos/badge_counter_repository.dart';
import 'package:bwa_cozy/repos/notif_repository.dart';
import 'package:bwa_cozy/util/enum/menu_type.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/widget/approval/iom_menu_icon_widget.dart';
import 'package:bwa_cozy/widget/menus/menu_item_approval_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bwa_cozy/data/dio_client.dart';
import 'package:bwa_cozy/di/service_locator.dart';

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

    var notifRepository = NotifRepository(dioClient: getIt<DioClient>());
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
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Internal Office Memo",
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
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      width: MediaQuery.sizeOf(context).width,
                      child: buildHeader(
                        notifBloc,
                        badgeCounterCubit,
                        approvalBloc,
                        context,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildHeader(
      NotifCoreBloc notifBloc,
      BadgeCounterCubit badgeCounterCubit,
      ApprovalMainPageBloc approvalBloc,
      BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 0, right: 0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      child: Container(
        child: Column(
          children: [
            BlocProvider(
                create: (BuildContext context) {
                  return notifBloc..add(NotifEventCount());
                },
                child: Container(
                  child: Column(
                    children: [
                      BlocBuilder<NotifCoreBloc, NotifCoreState>(
                          builder: (context, state) {
                        var count = "";
                        if (state is NotifStateLoading) {}
                        if (state is NotifStateFailure) {}
                        if (state is NotifStateSuccess) {
                          count = state.totalIom;
                        }
                        return MenuItemApprovalWidget(
                          unreadBadgeCount: count,
                          onLeftTapFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ApprovalPage(
                                  type: IomPageListType.SHOW_WAITING,
                                  title: "Menunggu Approval",
                                ),
                              ),
                            ).then((value) {
                              badgeCounterCubit..fetchBadgeCounter();
                              notifBloc..add(NotifEventCount());
                              approvalBloc
                                ..add(RequestDataEvent(ApprovalListType.IOM));
                            });
                          },
                          onRightTapFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IomApprovedAllPage(),
                              ),
                            ).then((value) {
                              notifBloc..add(NotifEventCount());
                            });
                          },
                        );
                      }),
                    ],
                  ),
                )),
            BlocProvider(
                create: (BuildContext context) {
                  return notifBloc..add(NotifEventCount());
                },
                child: Container(
                  child: Column(
                    children: [
                      BlocBuilder<NotifCoreBloc, NotifCoreState>(
                          builder: (context, state) {
                        var count = "";
                        if (state is NotifStateLoading) {}
                        if (state is NotifStateFailure) {}
                        if (state is NotifStateSuccess) {
                          count = state.totalKoordinasi;
                        }
                        return MenuItemApprovalWidget(
                          unreadBadgeCount: count,
                          titleLeft: "Permintaan\nKoordinasi",
                          titleRight: "History\nKoordinasi",
                          onLeftTapFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    KoordinasiWaitingAllPage(),
                              ),
                            ).then((value) {
                              badgeCounterCubit.fetchBadgeCounter();
                              notifBloc.add(NotifEventCount());
                              approvalBloc
                                  .add(RequestDataEvent(ApprovalListType.IOM));
                            });
                          },
                          onRightTapFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KoordinasiHistoryPage(),
                              ),
                            ).then((value) {
                              notifBloc..add(NotifEventCount());
                            });
                          },
                        );
                      }),
                    ],
                  ),
                )),
            IomPageContent(context, badgeCounterCubit, notifBloc, approvalBloc),
          ],
        ),
      ),
    );
  }

  Widget IomPageContent(
      BuildContext context,
      BadgeCounterCubit badgeCounterCubit,
      NotifCoreBloc notifBloc,
      ApprovalMainPageBloc approvalBloc) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            width: double.infinity,
            child: Text(
              "Berdasarkan Kategori",
              textAlign: TextAlign.start,
              style: MyTheme.myStylePrimaryTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            margin: EdgeInsets.only(left: 25, right: 25, top: 20),
            child: BlocBuilder<BadgeCounterCubit, BadgeCounterState>(
              bloc: badgeCounterCubit..fetchBadgeCounter(),
              builder: (context, state) {
                return Wrap(
                  alignment: WrapAlignment.spaceAround,
                  spacing: 38,
                  runSpacing: 23,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const IomListByCategoryPage(
                              title: "Billionare Club",
                              categoryId: "1",
                            ),
                          ),
                        ).then((value) {
                          notifBloc..add(NotifEventCount());
                        });
                      },
                      child: IomMenuIconWidget(
                        iconData: CupertinoIcons.money_dollar_circle,
                        label: "Billionaire\nClub",
                        badgeCount: state.totalMarketingClub, //done
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IomListByCategoryPage(
                              title: "Finance and Accounting",
                              categoryId: "2",
                            ),
                          ),
                        ).then((value) {
                          notifBloc..add(NotifEventCount());
                          approvalBloc
                            ..add(RequestDataEvent(ApprovalListType.COMPARE));
                        });
                      },
                      child: IomMenuIconWidget(
                        iconData: CupertinoIcons.doc_chart,
                        label: "Finance\nAccounting",
                        badgeCount: state.totalFinance, //done
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IomListByCategoryPage(
                              title: "Quantity Surveyor",
                              categoryId: "3",
                            ),
                          ),
                        ).then((value) {
                          notifBloc..add(NotifEventCount());
                        });
                      },
                      child: IomMenuIconWidget(
                        iconData: CupertinoIcons.square_stack_3d_up_fill,
                        label: "Quantity\nSurveyor",
                        badgeCount: state.totalQS, //done
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IomListByCategoryPage(
                              title: "Town Management",
                              categoryId: "11",
                            ),
                          ),
                        ).then((value) {
                          notifBloc..add(NotifEventCount());
                        });
                      },
                      child: IomMenuIconWidget(
                        iconData: CupertinoIcons.building_2_fill,
                        label: "Town\nManagement",
                        badgeCount: state.totalTown,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IomListByCategoryPage(
                              title: "Technical",
                              categoryId: "7",
                            ),
                          ),
                        ).then((value) {
                          notifBloc..add(NotifEventCount());
                        });
                      },
                      child: IomMenuIconWidget(
                        iconData: CupertinoIcons.hammer,
                        label: "Technical",
                        badgeCount: state.totalProject,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IomListByCategoryPage(
                              title: "Human Resource",
                              categoryId: "10",
                            ),
                          ),
                        ).then((value) {
                          notifBloc..add(NotifEventCount());
                        });
                      },
                      child: IomMenuIconWidget(
                        iconData: CupertinoIcons.person_3_fill,
                        label: "Human\nResource",
                        badgeCount: state.totalHRD,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IomListByCategoryPage(
                              title: "Legal and Operation",
                              categoryId: "4",
                            ),
                          ),
                        ).then((value) {
                          notifBloc..add(NotifEventCount());
                        });
                      },
                      child: IomMenuIconWidget(
                        iconData: CupertinoIcons.folder,
                        label: "Legal\nOperation",
                        badgeCount: state.totalLegal,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IomListByCategoryPage(
                              title: "Purchasing",
                              categoryId: "5",
                            ),
                          ),
                        ).then((value) {
                          notifBloc..add(NotifEventCount());
                        });
                      },
                      child: IomMenuIconWidget(
                        iconData: CupertinoIcons.shopping_cart,
                        label: "Purchasing",
                        badgeCount: state.totalPurchasing,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IomListByCategoryPage(
                              title: "Business Development",
                              categoryId: "6",
                            ),
                          ),
                        ).then((value) {
                          notifBloc..add(NotifEventCount());
                        });
                      },
                      child: IomMenuIconWidget(
                        iconData: CupertinoIcons.chart_bar_alt_fill,
                        label: "Business\nDevelopment",
                        badgeCount: state.totalBDD,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IomListByCategoryPage(
                              title: "Landed Project",
                              categoryId: "12",
                            ),
                          ),
                        ).then((value) {
                          notifBloc..add(NotifEventCount());
                        });
                      },
                      child: IomMenuIconWidget(
                        iconData: CupertinoIcons.home,
                        label: "Landed\nProject",
                        badgeCount: state.totalLanded,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IomListByCategoryPage(
                              title: "Marketing",
                              categoryId: "9",
                            ),
                          ),
                        ).then((value) {
                          notifBloc..add(NotifEventCount());
                        });
                      },
                      child: IomMenuIconWidget(
                        iconData: CupertinoIcons.chart_bar,
                        label: "Marketing",
                        badgeCount: state.totalMarketing,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IomListByCategoryPage(
                              title: "Permit & Certification",
                              categoryId: "13",
                            ),
                          ),
                        ).then((value) {
                          notifBloc..add(NotifEventCount());
                        });
                      },
                      child: IomMenuIconWidget(
                        iconData: CupertinoIcons.check_mark_circled,
                        label: "Permit\nCertification",
                        badgeCount: state.totalPermit,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IomListByCategoryPage(
                              title: "Promosi",
                              categoryId: "8",
                            ),
                          ),
                        ).then((value) {
                          notifBloc..add(NotifEventCount());
                        });
                      },
                      child: IomMenuIconWidget(
                        iconData: CupertinoIcons.gift,
                        label: "Promosi",
                        badgeCount: state.totalPromosi,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
