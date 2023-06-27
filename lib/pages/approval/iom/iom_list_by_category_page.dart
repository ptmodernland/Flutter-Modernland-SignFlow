import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/iom/approval_by_category_cubit.dart';
import 'package:modernland_signflow/bloc/iom/approval_state.dart';
import 'package:modernland_signflow/pages/approval/iom/iomdetail/iom_detail_page.dart';
import 'package:modernland_signflow/repos/iom/approval_repository.dart';
import 'package:modernland_signflow/util/core/string/html_util.dart';
import 'package:modernland_signflow/widget/approval/item_approval_widget.dart';

class IomListByCategoryPage extends StatelessWidget {
  final String categoryId;
  final String title;

  const IomListByCategoryPage(
      {this.categoryId = "", this.title = "IOM Category"});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApprovalByCategoryCubit(ApprovalRepository())
        ..fetchApprovalByCategory(categoryId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: ApprovalList(
          categoryId: categoryId,
        ),
      ),
    );
  }
}

class ApprovalList extends StatelessWidget {
  const ApprovalList({this.categoryId = "-99", this.title = ""});

  final String categoryId;
  final String title;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ApprovalByCategoryCubit>();
    return BlocBuilder<ApprovalByCategoryCubit, ApprovalState>(
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
                    cubit.fetchApprovalByCategory(categoryId);
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
