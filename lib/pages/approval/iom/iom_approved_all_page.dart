import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/iom/approval_history_cubit.dart';
import 'package:modernland_signflow/bloc/iom/approval_state.dart';
import 'package:modernland_signflow/bloc/login/login_response.dart';
import 'package:modernland_signflow/pages/approval/iom/iomdetail/iom_detail_page.dart';
import 'package:modernland_signflow/repos/iom/approval_repository.dart';
import 'package:modernland_signflow/research/research_filter_page.dart';
import 'package:modernland_signflow/util/core/string/html_util.dart';
import 'package:modernland_signflow/util/my_theme.dart';
import 'package:modernland_signflow/util/responsiveness/scale_size.dart';
import 'package:modernland_signflow/util/storage/sessionmanager/session_manager.dart';
import 'package:modernland_signflow/widget/approval/item_approval_widget.dart';

class IomApprovedAllPage extends StatelessWidget {
  final String title;

  const IomApprovedAllPage({this.title = "History IOM"});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ApprovalHistoryCubit(ApprovalRepository())..fetchApprovaHistory(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: ApprovalList(),
      ),
    );
  }
}

class ApprovalList extends StatelessWidget {
  const ApprovalList();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ApprovalHistoryCubit>();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          // Optional padding adjustments
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder<UserDTO?>(
                future: SessionManager.getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While the future is loading, show a loading indicator or placeholder
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              // proceedLogoutLocally(context);
                            },
                            child: Text(
                              snapshot.data?.nama ?? "",
                              textAlign: TextAlign.center,
                              style: MyTheme.myStylePrimaryTextStyle.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          )
                        ],
                      ),
                    );
                  } else {
                    return Text('User not found');
                  }
                },
              ),
              Wrap(
                spacing: 8,
                children: [
                  InputChip(
                    label: Text(
                      'Test',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue,
                    deleteIcon: Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
              CupertinoButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    constraints: BoxConstraints.loose(Size(
                        MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height * 0.75)),
                    // <= this is set to 3/4 of screen size.
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Filter',
                                    style: MyTheme.myStylePrimaryTextStyle
                                        .copyWith(
                                      fontSize: ScaleSize.textScaleFactor(
                                          context,
                                          maxTextScaleFactor: 45),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: FilterPage(),
                            ),
                          ],
                        ),
                      );
                    },
                  ).then((value) => {});
                },
                child:
                    Icon(CupertinoIcons.line_horizontal_3_decrease, size: 28),
                padding: EdgeInsets.all(0), // Optional padding adjustments
                borderRadius: BorderRadius.circular(
                    20), // Optional border radius adjustments
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<ApprovalHistoryCubit, ApprovalState>(
            builder: (context, state) {
              if (state is ApprovalLoading) {
                return Center(child: CupertinoActivityIndicator());
              } else if (state is ApprovalEmpty) {
                return Center(child: Text('No approvals found.'));
              } else if (state is ApprovalSuccess) {
                return ListView.builder(
                  itemCount: state.approvals.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final approvalItem = state.approvals[index];
                    var isApproved = false;
                    if (approvalItem.status != "Y" ||
                        approvalItem.status != "C") {
                      isApproved = true;
                    }
                    return ItemApprovalWidget(
                      isApproved: isApproved,
                      itemCode: (index + 1).toString() +
                          approvalItem.nomor.toString(),
                      date: approvalItem.tanggal,
                      requiredId: approvalItem.idIom,
                      personName: approvalItem.namaUser,
                      departmentTitle: approvalItem.kategoriIom,
                      descriptiveText:
                          removeHtmlTags(((approvalItem.perihal ?? ""))),
                      onPressed: (String noCompare) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IomDetailPage(
                              isFromHistory: true,
                              idIom: approvalItem.idIom ?? "",
                              noIom: approvalItem.nomor ?? "",
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              } else if (state is ApprovalError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}
