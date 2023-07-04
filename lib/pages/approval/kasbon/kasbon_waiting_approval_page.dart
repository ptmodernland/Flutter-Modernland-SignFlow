import 'package:modernland_signflow/bloc/all_approval/approval_main_page_bloc.dart';
import 'package:modernland_signflow/bloc/all_approval/approval_main_page_event.dart';
import 'package:modernland_signflow/bloc/all_approval/approval_main_page_state.dart';
import 'package:modernland_signflow/data/dio_client.dart';
import 'package:modernland_signflow/di/service_locator.dart';
import 'package:modernland_signflow/pages/approval/compare/detail_compare_page.dart';
import 'package:modernland_signflow/repos/approval_main_page_repository.dart';
import 'package:modernland_signflow/util/enum/menu_type.dart';
import 'package:modernland_signflow/util/my_theme.dart';
import 'package:modernland_signflow/widget/approval/item_approval_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KasbonWaitingApprovalPage extends StatefulWidget {
  const KasbonWaitingApprovalPage({Key? key}) : super(key: key);

  @override
  State<KasbonWaitingApprovalPage> createState() =>
      _KasbonWaitingApprovalPageState();
}

class _KasbonWaitingApprovalPageState extends State<KasbonWaitingApprovalPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    ApprovalMainPageRepository approvalRepo =
        ApprovalMainPageRepository(dioClient: getIt<DioClient>());
    ApprovalMainPageBloc approvalBloc = ApprovalMainPageBloc(approvalRepo);

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
                                margin: EdgeInsets.only(
                                    left: 30, right: 30, top: 10),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.arrow_back),
                                      color: Colors.white,
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // Implement your back button functionality here
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        "Kasbon Waiting Approval",
                                        style: MyTheme.myStylePrimaryTextStyle
                                            .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
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
                                            style: MyTheme
                                                .myStylePrimaryTextStyle
                                                .copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
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
                            Widget dataList = Text("");
                            if (state is ApprovalMainPageStateLoading) {
                              return CupertinoActivityIndicator();
                            }
                            if (state is ApprovalMainPageStateFailure) {}
                            if (state
                                is ApprovalMainPageStateSuccessListKasbon) {
                              var kasbonList = state.datas;
                              if (kasbonList.isEmpty) {
                                return Container(
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
                                        'No data available',
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
                                itemCount: kasbonList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final kasbonItem = kasbonList[index];
                                  var isApproved = false;
                                  if (kasbonItem.status != "Y") {
                                    isApproved = true;
                                  }
                                  return ItemApprovalWidget(
                                    requiredId: kasbonItem.idKasbon,
                                    isApproved: isApproved,
                                    itemCode: kasbonItem.noKasbon,
                                    date: kasbonItem.tglBuat,
                                    departmentTitle: kasbonItem.departemen,
                                    personName: kasbonItem.namaUser,
                                    personImage: "",
                                    descriptiveText: kasbonItem.keperluan,
                                    onPressed: (String requiredId) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailComparePage(
                                                  noCompare:
                                                      kasbonItem.noKasbon ?? "",
                                                  idCompare:
                                                      kasbonItem.idKasbon ??
                                                          ""),
                                        ),
                                      ).then((value) {
                                        approvalBloc
                                          ..add(RequestDataEvent(
                                              ApprovalListType.COMPARE));
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
