import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/all_approval/approval_main_page_bloc.dart';
import 'package:modernland_signflow/bloc/all_approval/approval_main_page_event.dart';
import 'package:modernland_signflow/bloc/all_approval/approval_main_page_state.dart';
import 'package:modernland_signflow/bloc/notif/notif_bloc.dart';
import 'package:modernland_signflow/bloc/notif/notif_event.dart';
import 'package:modernland_signflow/bloc/notif/notif_state.dart';
import 'package:modernland_signflow/data/dio_client.dart';
import 'package:modernland_signflow/di/service_locator.dart';
import 'package:modernland_signflow/pages/approval/kasbon/kasbon_approved_all_page.dart';
import 'package:modernland_signflow/pages/approval/kasbon/kasbon_detail_page.dart';
import 'package:modernland_signflow/pages/approval/kasbon/kasbon_waiting_approval_page.dart';
import 'package:modernland_signflow/repos/approval_main_page_repository.dart';
import 'package:modernland_signflow/repos/notif_repository.dart';
import 'package:modernland_signflow/util/core/string/html_util.dart';
import 'package:modernland_signflow/util/enum/menu_type.dart';
import 'package:modernland_signflow/util/my_theme.dart';
import 'package:modernland_signflow/widget/approval/item_approval_widget.dart';
import 'package:modernland_signflow/widget/menus/menu_item_approval_widget.dart';

class ApprovalKasbonMainPage extends StatefulWidget {
  const ApprovalKasbonMainPage({Key? key}) : super(key: key);

  @override
  State<ApprovalKasbonMainPage> createState() => _ApprovalKasbonMainPageState();
}

class _ApprovalKasbonMainPageState extends State<ApprovalKasbonMainPage> {
  late NotifRepository notifRepository;
  late NotifCoreBloc notifBloc;
  late ApprovalMainPageRepository approvalRepo;
  late ApprovalMainPageBloc approvalBloc;

  @override
  void initState() {
    super.initState();
    notifRepository = NotifRepository(dioClient: getIt<DioClient>());
    notifBloc = NotifCoreBloc(notifRepository);
    approvalRepo = ApprovalMainPageRepository(dioClient: getIt<DioClient>());
    approvalBloc = ApprovalMainPageBloc(approvalRepo);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
                        height: 150,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
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
                                margin: const EdgeInsets.only(
                                    left: 30, right: 30, top: 10),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      color: Colors.white,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Kasbon",
                                        style: MyTheme.myStylePrimaryTextStyle
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    const Spacer(),
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
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 20, left: 0, right: 0),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30.0)),
                              ),
                              child: Container(
                                child: Column(
                                  children: [
                                    BlocProvider.value(
                                        value: notifBloc
                                          ..add(NotifEventCount()),
                                        child: Container(
                                          child: Column(
                                            children: [
                                              BlocBuilder<NotifCoreBloc,
                                                      NotifCoreState>(
                                                  builder: (context, state) {
                                                var count = "";
                                                if (state
                                                    is NotifStateLoading) {
                                                  return Container();
                                                }
                                                if (state
                                                    is NotifStateFailure) {}
                                                if (state
                                                    is NotifStateSuccess) {
                                                  count = state.totalKasbon;
                                                }
                                                return MenuItemApprovalWidget(
                                                  unreadBadgeCount: count,
                                                  onLeftTapFunction: () async {
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const KasbonWaitingApprovalPage(),
                                                      ),
                                                    );
                                                    initData();
                                                  },
                                                  onRightTapFunction: () async {
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const KasbonAllApprovedPage(),
                                                      ),
                                                    );
                                                    initData();
                                                  },
                                                );
                                              }),
                                            ],
                                          ),
                                        )),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              initData();
                                            },
                                            child: Text(
                                              "Request Terbaru",
                                              textAlign: TextAlign.start,
                                              style: MyTheme
                                                  .myStylePrimaryTextStyle
                                                  .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
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
                      BlocProvider(
                        create: (BuildContext context) {
                          return approvalBloc
                            ..add(RequestDataEvent(ApprovalListType.KASBON));
                        },
                        child: BlocBuilder<ApprovalMainPageBloc,
                            ApprovalMainPageState>(
                          builder: (context, state) {
                            var status = "";
                            Widget dataList = const Text("");
                            if (state is ApprovalMainPageStateLoading) {
                              return const CupertinoActivityIndicator();
                            }
                            if (state is ApprovalMainPageStateFailure) {}
                            if (state
                                is ApprovalMainPageStateSuccessListKasbon) {
                              var pbjList = state.datas;

                              if (pbjList.isEmpty) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                      top: 50, left: 20, right: 20),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        'http://feylabs.my.id/fm/mdln_asset/mdln_empty_image.png',
                                        // Adjust the image properties as per your requirement
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
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
                                    itemCode: pbjItem.noKasbon.toString(),
                                    date: pbjItem.tglBuat,
                                    requiredId: pbjItem.idKasbon,
                                    personName: pbjItem.namaUser,
                                    departmentTitle: pbjItem.departemen,
                                    descriptiveText:
                                        removeHtmlTags(pbjItem.keperluan ?? ""),
                                    onPressed: (String noCompare) async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              KasbonDetailPage(
                                            idKasbon: pbjItem.idKasbon ?? "",
                                            noKasbon: pbjItem.noKasbon ?? "",
                                          ),
                                        ),
                                      );
                                      initData();
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

  void initData() {
    notifBloc.add(NotifEventCount());
    approvalBloc.add(RequestDataEvent(ApprovalListType.KASBON));
  }
}
