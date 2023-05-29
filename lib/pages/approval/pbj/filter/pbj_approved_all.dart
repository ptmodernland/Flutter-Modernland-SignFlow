import 'package:bwa_cozy/bloc/pbj/pbj_event.dart';
import 'package:bwa_cozy/bloc/pbj/pbj_main_bloc.dart';
import 'package:bwa_cozy/bloc/pbj/pbj_state.dart';
import 'package:bwa_cozy/pages/approval/pbj/detail_pbj_page.dart';
import 'package:bwa_cozy/repos/pbj_repository.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/widget/approval/item_approval_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PBJAllApprovedPage extends StatefulWidget {
  const PBJAllApprovedPage({Key? key}) : super(key: key);

  @override
  State<PBJAllApprovedPage> createState() => _PBJAllApprovedPageState();
}

class _PBJAllApprovedPageState extends State<PBJAllApprovedPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    PBJRepository pbjRepository = PBJRepository();
    PBJBloc pbjBloc = PBJBloc(pbjRepository);

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
                                    Text(
                                      "History Approved PBJ",
                                      style: MyTheme.myStylePrimaryTextStyle
                                          .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
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
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "History Approved PBJ",
                                            textAlign: TextAlign.start,
                                            style: MyTheme
                                                .myStylePrimaryTextStyle
                                                .copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            "Halaman ini menampilkan list PBJ yang telah diapprove",
                                            textAlign: TextAlign.start,
                                            style: MyTheme
                                                .myStylePrimaryTextStyle
                                                .copyWith(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 11,
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
                          return pbjBloc..add(GetHistoryPBJ());
                        },
                        child: BlocBuilder<PBJBloc, PBJState>(
                          builder: (context, state) {
                            var status = "";
                            Widget dataList = Text("");
                            if (state is PBJStateFailure) {}
                            if (state is PBJStateLoading) {}
                            if (state is PBJStateLoadHistorySuccess) {
                              var pbjList = state.datas;
                              if (pbjList.isEmpty) {
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
                                    requiredId: pbjItem.noPermintaan,
                                    isApproved: isApproved,
                                    itemCode: pbjItem.noPermintaan,
                                    date: pbjItem.tglPermintaan,
                                    departmentTitle: pbjItem.department,
                                    personName: pbjItem.namaUser,
                                    personImage: "",
                                    onPressed: (String requiredId) {
                                      Fluttertoast.showToast(
                                          msg: requiredId.toString());

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailPBJPage(
                                              isFromHistory: true,
                                              noPermintaan: requiredId),
                                        ),
                                      ).then((value) {
                                        pbjBloc..add(GetHistoryPBJ());
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
