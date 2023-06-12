import 'package:bwa_cozy/bloc/iom/approval_history_cubit.dart';
import 'package:bwa_cozy/bloc/iom/approval_state.dart';
import 'package:bwa_cozy/pages/approval/iom/iomdetail/iom_detail_page.dart';
import 'package:bwa_cozy/repos/iom/approval_repository.dart';
import 'package:bwa_cozy/util/core/string/html_util.dart';
import 'package:bwa_cozy/widget/approval/item_approval_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<ApprovalHistoryCubit, ApprovalState>(
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
              if (approvalItem.status != "Y" || approvalItem.status != "C") {
                isApproved = true;
              }
              return ItemApprovalWidget(
                isApproved: isApproved,
                itemCode:
                    (index + 1).toString() + approvalItem.nomor.toString(),
                date: approvalItem.tanggal,
                requiredId: approvalItem.idIom,
                personName: approvalItem.namaUser,
                departmentTitle: approvalItem.kategoriIom,
                descriptiveText: removeHtmlTags(((approvalItem.perihal ?? ""))),
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
    );
  }
}
