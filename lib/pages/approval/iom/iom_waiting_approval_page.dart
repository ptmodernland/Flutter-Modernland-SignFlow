import 'package:bwa_cozy/bloc/iom/approval_cubit.dart';
import 'package:bwa_cozy/bloc/iom/approval_state.dart';
import 'package:bwa_cozy/repos/iom/approval_repository.dart';
import 'package:bwa_cozy/util/core/string/html_util.dart';
import 'package:bwa_cozy/widget/approval/item_approval_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum IomPageListType {
  SHOW_WAITING,
  SHOW_HISTORY,
  SHOW_ALL,
  SHOW_BY_CATEGORY,
  SEARCH_OR_FILTER,
}

class ApprovalPage extends StatelessWidget {
  final String title;
  final IomPageListType type;

  const ApprovalPage(
      {this.title = "IOM", this.type = IomPageListType.SHOW_ALL});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApprovalCubit(ApprovalRepository())..fetchApprovals(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: ApprovalList(
          type: this.type,
        ),
      ),
    );
  }
}

class ApprovalList extends StatelessWidget {
  final String title;
  final IomPageListType type;

  const ApprovalList(
      {this.title = "IOM", this.type = IomPageListType.SHOW_ALL});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ApprovalCubit>();
    return BlocBuilder<ApprovalCubit, ApprovalState>(
      builder: (context, state) {
        if (state is ApprovalLoading) {
          return Center(child: CupertinoActivityIndicator());
        } else if (state is ApprovalEmpty) {
          return Center(child: Text('No approvals found.'));
        } else if (state is ApprovalSuccess) {
          final approvals = state.approvals;

          return ListView.builder(
            itemCount: state.approvals.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final approvalItem = state.approvals[index];
              var isApproved = false;
              if (approvalItem.status != "Y") {
                isApproved = true;
              }
              return ItemApprovalWidget(
                isApproved: isApproved,
                itemCode:
                    (index + 1).toString() + approvalItem.nomor.toString(),
                date: approvalItem.tanggal,
                requiredId: approvalItem.idIom,
                personName: approvalItem.namaUser,
                departmentTitle: approvalItem.departemen,
                descriptiveText: removeHtmlTags(((approvalItem.perihal ?? ""))),
                onPressed: (String noCompare) {},
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
