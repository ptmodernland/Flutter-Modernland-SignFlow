import 'package:modernland_signflow/bloc/rekomendasi/rekomendasi_cubit.dart';
import 'package:modernland_signflow/bloc/rekomendasi/rekomendasi_state.dart';
import 'package:modernland_signflow/pages/approval/iom/iomdetail/iom_detail_page.dart';
import 'package:modernland_signflow/repos/rekomendasi/rekomendasi_repository.dart';
import 'package:modernland_signflow/util/core/string/html_util.dart';
import 'package:modernland_signflow/widget/approval/item_approval_widget.dart';
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
        if (state is RekomendasiStateLoading) {
          return Center(child: CupertinoActivityIndicator());
        } else if (state is RekomendasiStateEmpty) {
          return Center(child: Text('No approvals found.'));
        } else if (state is RekomendasiLoadWaitingSuccess) {
          return ListView.builder(
            itemCount: state.approvals.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var approvalItem = state.approvals[index];
              return ItemApprovalWidget(
                isApproved: true,
                itemCode: approvalItem.nomor.toString(),
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
                        isFromHistory: true,
                        isFromRekomendasi: true,
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
        } else if (state is RekomendasiStateError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Container();
        }
      },
    );
  }
}
