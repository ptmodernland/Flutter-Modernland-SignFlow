import 'package:bwa_cozy/bloc/rekomendasi/rekomendasi_cubit.dart';
import 'package:bwa_cozy/bloc/rekomendasi/rekomendasi_state.dart';
import 'package:bwa_cozy/pages/approval/iom/iomdetail/iom_detail_page.dart';
import 'package:bwa_cozy/repos/rekomendasi/rekomendasi_repository.dart';
import 'package:bwa_cozy/util/core/string/html_util.dart';
import 'package:bwa_cozy/widget/approval/item_approval_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KoordinasiHistoryPage extends StatelessWidget {
  final String title;

  const KoordinasiHistoryPage({this.title = "History Koordinasi"});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RekomendasiCubit(RekomendasiRepository())..fetchHistory(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: RekomendasiList(),
      ),
    );
  }
}

class RekomendasiList extends StatefulWidget {
  final String title;

  const RekomendasiList({this.title = "IOM"});

  @override
  State<RekomendasiList> createState() => _RekomendasiListState();
}

class _RekomendasiListState extends State<RekomendasiList> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RekomendasiCubit>();
    return BlocBuilder<RekomendasiCubit, RekomendasiState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is RekomendasiLoading) {
          return Center(child: CupertinoActivityIndicator());
        } else if (state is RekomendasiEmpty) {
          return Center(child: Text('No approvals found.'));
        } else if (state is RekomendasiLoadWaitingSuccess) {
          return ListView.builder(
            itemCount: state.approvals.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var approvalItem = state.approvals[index];
              return ItemApprovalWidget(
                isApproved: false,
                itemCode:
                    (index + 1).toString() + approvalItem.nomor.toString(),
                date: approvalItem.tanggal,
                requiredId: approvalItem.idIom,
                personName: approvalItem.namaUser,
                departmentTitle: approvalItem.departemen,
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
                    // cubit.fetchHistory();
                  });
                },
              );
            },
          );
        } else if (state is RekomendasiError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Container();
        }
      },
    );
  }
}
