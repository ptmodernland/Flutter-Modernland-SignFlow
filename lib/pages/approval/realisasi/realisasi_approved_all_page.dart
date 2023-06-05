import 'package:bwa_cozy/bloc/realisasi/realisasi_bloc.dart';
import 'package:bwa_cozy/bloc/realisasi/realisasi_event.dart';
import 'package:bwa_cozy/bloc/realisasi/realisasi_state.dart';
import 'package:bwa_cozy/pages/approval/realisasi/realisasi_detail_page.dart';
import 'package:bwa_cozy/repos/realisasi_repository.dart';
import 'package:bwa_cozy/util/core/string/html_util.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/widget/approval/item_approval_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RealisasiAllApprovedPage extends StatefulWidget {
  const RealisasiAllApprovedPage({Key? key}) : super(key: key);

  @override
  State<RealisasiAllApprovedPage> createState() =>
      _RealisasiAllApprovedPageState();
}

class _RealisasiAllApprovedPageState extends State<RealisasiAllApprovedPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    RealisasiRepository compareRepository = RealisasiRepository();
    RealisasiBloc compareBloc = RealisasiBloc(compareRepository);

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
                                        "History Approved Realisasi",
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
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            "History Approved Compare",
                                            textAlign: TextAlign.start,
                                            style: MyTheme
                                                .myStylePrimaryTextStyle
                                                .copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            "Halaman ini menampilkan list Compare yang telah diapprove",
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
                          return compareBloc..add(GetHistoryRealisasi());
                        },
                        child: BlocBuilder<RealisasiBloc, RealisasiState>(
                          builder: (context, state) {
                            var status = "";
                            Widget dataList = Text("");
                            if (state is RealisasiStateFailure) {}
                            if (state is RealisasiStateLoading) {
                              return Center(
                                child: CupertinoActivityIndicator(),
                              );
                            }
                            if (state is RealisasiStateLoadHistorySuccess) {
                              var approvalList = state.datas;
                              if (approvalList.isEmpty) {
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
                                itemCount: approvalList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final pbjItem = approvalList[index];
                                  var isApproved = false;
                                  if (pbjItem.status != "Y") {
                                    isApproved = true;
                                  }
                                  return ItemApprovalWidget(
                                    requiredId: pbjItem.idRealisasi,
                                    isApproved: isApproved,
                                    itemCode: pbjItem.noRealisasi,
                                    date: pbjItem.tglBuat,
                                    departmentTitle: pbjItem.departemen,
                                    personName: pbjItem.namaUser,
                                    descriptiveText: removeHtmlTags(
                                        "No Kasbon :" +
                                            (pbjItem.noKasbon ?? "")),
                                    personImage: "",
                                    onPressed: (String requiredId) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RealisasiDetailPage(
                                            noRealisasi:
                                                pbjItem.noRealisasi ?? "",
                                            isFromHistory: true,
                                          ),
                                        ),
                                      );
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
