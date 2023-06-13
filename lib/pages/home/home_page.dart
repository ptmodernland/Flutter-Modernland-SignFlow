import 'package:bwa_cozy/bloc/notif/notif_bloc.dart';
import 'package:bwa_cozy/bloc/stream/orderbook_cubit.dart';
import 'package:bwa_cozy/bloc/stream/stream_cubit.dart';
import 'package:bwa_cozy/bloc/stream/stream_state.dart';
import 'package:bwa_cozy/repos/stream/stream_repository.dart';
import 'package:bwa_cozy/util/my_colors.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/util/resposiveness.dart';
import 'package:bwa_cozy/widget/stream/stream_card.dart';
import 'package:bwa_cozy/widget/stream/stream_ui_model.dart';
import 'package:bwa_cozy/widget/tips_and_trick/tips_and_trick_ui_model.dart';
import 'package:bwa_cozy/widget/tips_and_trick/tips_and_trick_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage(NotifCoreBloc notifBloc, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamCubit streamCubit;
  late OrderbookCubit orderbookCubit;

  @override
  void initState() {
    super.initState();
    streamCubit = StreamCubit(StreamRepository());
    orderbookCubit = OrderbookCubit(StreamRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 0),
          child: ListView(
            children: [
              SizedBox(
                height: 35,
              ),
              InkWell(
                onDoubleTap: () {
                  orderbookCubit.fetchPrice();
                },
                child: Image.asset(
                  "asset/img/icons/logo_modernland.png",
                  width: ScreenUtil.getScreenWidth(context) * 0.1,
                  height: 50,
                ),
              ),
              Text(
                "Modernland Approval",
                style: MyTheme.myStylePrimaryTextStyle
                    .copyWith(fontSize: 20, fontWeight: MyTheme.bold),
              ),
              Text(
                "Modernland Approval revolutionizes the approval process, empowering efficient decision-making and expediting critical assessments.",
                style: MyTheme.myStyleSecondaryTextStyle.copyWith(fontSize: 15),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Modernland Market Snips",
                style: MyTheme.myStyleSecondaryTextStyle
                    .copyWith(fontSize: 20, color: AppColors.primaryColor2),
              ),
              BlocProvider(
                create: (_) => streamCubit,
                child: Column(
                  children: [
                    BlocBuilder<StreamCubit, StreamState>(
                      bloc: streamCubit..fetchStream(),
                      builder: (context, state) {
                        if (state is StreamStateLoading) {
                          return Container(
                              height: 300,
                              child:
                                  Center(child: CupertinoActivityIndicator()));
                        } else if (state is StreamStateLoadSuccess) {
                          print("success nieee" + state.datas.toString());
                          return Container(
                            height: 300,
                            child: ListView.builder(
                              itemCount: state.datas.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final item = state.datas[index];
                                var photoUrl = "";
                                if (item.images?.isNotEmpty == true) {
                                  photoUrl = item.images?.first ?? "";
                                }
                                return StreamCard(
                                    streamUiModel: StreamUIModel(
                                        description: item.contentOriginal ?? "",
                                        name: item.title ?? "",
                                        photoUrl: photoUrl));
                                return Text(item.title ?? "");
                              },
                            ),
                          );
                        } else {
                          return Text("Halo Gais");
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Stock Movement",
                style: MyTheme.myStyleSecondaryTextStyle
                    .copyWith(fontSize: 20, color: AppColors.primaryColor2),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocProvider(
                create: (_) => orderbookCubit,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 4.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const CircleAvatar(
                                radius: 45.0,
                                backgroundImage: NetworkImage(
                                  'http://feylabs.my.id/fm/mdln_asset/mdln_circle_placeholder.png',
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Modernland Realty (IDX:MDLN)",
                                    style: MyTheme.myStylePrimaryTextStyle
                                        .copyWith(
                                      fontSize: 18,
                                    ),
                                  ),
                                  RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Harga Saham MDLN hari ini '),
                                        TextSpan(
                                          text: 'naik 25%',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              BlocBuilder<OrderbookCubit, StreamState>(
                                bloc: orderbookCubit..fetchPrice(),
                                builder: (context, state) {
                                  if (state is StreamStateLoading) {
                                    return Container(
                                        height: 100,
                                        child: Center(
                                            child:
                                                CupertinoActivityIndicator()));
                                  } else if (state
                                      is StreamStateOrderbookSuccess) {
                                    var data = state.datas;
                                    return Column(
                                      children: [
                                        Text(
                                          data.data?.lastprice.toString() ??
                                              "0",
                                          style: MyTheme.myStylePrimaryTextStyle
                                              .copyWith(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "(+23)",
                                          style: MyTheme
                                              .myStyleSecondaryTextStyle
                                              .copyWith(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    );
                                  } else {
                                    return Text("Loading");
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Shareholder Transaction (EOD)",
                style: MyTheme.myStyleSecondaryTextStyle
                    .copyWith(fontSize: 20, color: AppColors.primaryColor2),
              ),
              Container(
                height: 275,
                margin: EdgeInsets.only(top: 20),
                child: ListView(
                  primary: false,
                  scrollDirection: Axis.vertical,
                  children: [
                    TipsAndTrickWidget(
                      uimodel: TipsAndTrickUIModel(
                          name: "Pedoman Aplikasi",
                          description: "Terakhir diupdate : 12 Mei 2022",
                          photoAsset: "asset/img/dummy/guideline_1.png"),
                    ),
                    TipsAndTrickWidget(
                      uimodel: TipsAndTrickUIModel(
                          name: "Pedoman Penggunaan",
                          description: "Terakhir diupdate : 12 Januari 2022",
                          photoAsset: "asset/img/dummy/guideline_2.png"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
