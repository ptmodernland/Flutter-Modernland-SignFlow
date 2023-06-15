import 'package:bwa_cozy/bloc/stream/orderbook_cubit.dart';
import 'package:bwa_cozy/bloc/stream/shareholder_movement_cubit.dart';
import 'package:bwa_cozy/bloc/stream/stream_cubit.dart';
import 'package:bwa_cozy/bloc/stream/stream_state.dart';
import 'package:bwa_cozy/pages/common/webview_page.dart';
import 'package:bwa_cozy/repos/stream/stream_repository.dart';
import 'package:bwa_cozy/widget/stream/stream_horizontal_card.dart';
import 'package:bwa_cozy/widget/stream/stream_ui_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MDLNNewsAllPage extends StatefulWidget {
  final String title;

  const MDLNNewsAllPage({this.title = "History IOM"});

  @override
  State<MDLNNewsAllPage> createState() => _MDLNNewsAllPageState();
}

class _MDLNNewsAllPageState extends State<MDLNNewsAllPage> {
  late StreamCubit streamCubit;
  late OrderbookCubit orderbookCubit;
  late ShareholderMovementCubit shareholderCubit;

  @override
  void initState() {
    super.initState();
    streamCubit = StreamCubit(StreamRepository());
    orderbookCubit = OrderbookCubit(StreamRepository());
    shareholderCubit = ShareholderMovementCubit(StreamRepository());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => streamCubit..fetchStream(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.widget.title),
        ),
        body: ContentWidget(),
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget();

  @override
  Widget build(BuildContext context) {
    final streamCubit = context.read<StreamCubit>();
    return BlocBuilder<StreamCubit, StreamState>(
      bloc: streamCubit..fetchStream(),
      builder: (context, state) {
        if (state is StreamStateLoading) {
          return Container(
              height: MediaQuery.sizeOf(context).height,
              child: Center(child: CupertinoActivityIndicator()));
        } else if (state is StreamStateLoadSuccess) {
          return Container(
            child: ListView.builder(
              itemCount: state.datas.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final item = state.datas[index];
                var photoUrl = "";
                if (item.images?.isNotEmpty == true) {
                  photoUrl = item.images?.first ?? "";
                }
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CommonWebviewPage(
                        url: item.titleUrl ?? "",
                      );
                    }));
                  },
                  child: StreamHorizontalCard(
                      streamUiModel: StreamUIModel(
                          description: item.contentOriginal ?? "",
                          name: item.title ?? "",
                          bottomText: (item.createdDisplay ?? "") +
                              " - " +
                              (item.newsFeed?.label ?? ""),
                          photoUrl: photoUrl)),
                );
                return Text(item.title ?? "");
              },
            ),
          );
        } else {
          return Text("-");
        }
      },
    );
  }
}
