import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/iom/approval_cubit.dart';
import 'package:modernland_signflow/bloc/iom/approval_state.dart';
import 'package:modernland_signflow/pages/approval/iom/iomdetail/iom_detail_page.dart';
import 'package:modernland_signflow/repos/iom/approval_repository.dart';
import 'package:modernland_signflow/util/core/string/html_util.dart';
import 'package:modernland_signflow/widget/approval/item_approval_widget.dart';

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

class ApprovalList extends StatefulWidget {
  final String title;
  final IomPageListType type;

  const ApprovalList(
      {this.title = "IOM", this.type = IomPageListType.SHOW_ALL});

  @override
  State<ApprovalList> createState() => _ApprovalListState();
}

class _ApprovalListState extends State<ApprovalList> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ApprovalCubit>();
    return BlocBuilder<ApprovalCubit, ApprovalState>(
      bloc: cubit,
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
                departmentTitle: approvalItem.kategoriIom,
                descriptiveText: removeHtmlTags(((approvalItem.perihal ?? ""))),
                onPressed: (String noCompare) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IomDetailPage(
                        isFromHistory: false,
                        idIom: approvalItem.idIom ?? "",
                        noIom: approvalItem.nomor ?? "",
                      ),
                    ),
                  ).then((value) {
                    cubit.fetchApprovals();
                  });
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
