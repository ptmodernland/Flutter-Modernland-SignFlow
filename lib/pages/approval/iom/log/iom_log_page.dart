import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/iom/approval_log_cubit.dart';
import 'package:modernland_signflow/bloc/iom/approval_state.dart';
import 'package:modernland_signflow/repos/iom/approval_repository.dart';
import 'package:modernland_signflow/widget/approval/log_list_item_widget.dart';

class IomLogPage extends StatelessWidget {
  final String title;
  final String noIom;

  const IomLogPage({this.title = "Log", this.noIom = "-99"});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApprovalLogCubit(ApprovalRepository())..fetchLog(noIom),
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: LogIomlList(),
      ),
    );
  }
}

class LogIomlList extends StatelessWidget {
  const LogIomlList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApprovalLogCubit, ApprovalState>(
      builder: (context, state) {
        if (state is ApprovalLoading) {
          return Center(child: CupertinoActivityIndicator());
        } else if (state is ApprovalEmpty) {
          return Center(child: Text('No approvals found.'));
        } else if (state is ApprovalLogSuccess) {
          return ListView.builder(
            itemCount: state.logs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final approvalItem = state.logs[index];
              return LogListItemWidget(
                postingDate: approvalItem.tglLog,
                userName: approvalItem.namaUser,
                comment: approvalItem.statusLogIom,
                bottomText: approvalItem.departemen,
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
