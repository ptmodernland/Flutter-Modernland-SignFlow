import 'dart:math';

import 'package:bwa_cozy/bloc/notif/notif_bloc.dart';
import 'package:bwa_cozy/bloc/stream/orderbook_cubit.dart';
import 'package:bwa_cozy/bloc/stream/shareholder_movement_cubit.dart';
import 'package:bwa_cozy/bloc/stream/stream_cubit.dart';
import 'package:bwa_cozy/bloc/stream/stream_state.dart';
import 'package:bwa_cozy/pages/common/webview_page.dart';
import 'package:bwa_cozy/pages/stock/mdln_news_all_page.dart';
import 'package:bwa_cozy/pages/stock/mdln_shareholder_all_page.dart';
import 'package:bwa_cozy/repos/stream/stream_repository.dart';
import 'package:bwa_cozy/util/core/string/currency_util.dart';
import 'package:bwa_cozy/util/my_colors.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/util/responsiveness/scale_size.dart';
import 'package:bwa_cozy/util/resposiveness.dart';
import 'package:bwa_cozy/widget/common/broadcast_message_widget.dart';
import 'package:bwa_cozy/widget/common/shareholder_transaction_widget.dart';
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
    const rowHeight = 5.0;
    final rowSpacer = TableRow(children: [
      SizedBox(
        height: rowHeight,
      ),
      SizedBox(
        height: rowHeight,
      ),
      SizedBox(
        height: rowHeight,
      ),
      SizedBox(
        height: rowHeight,
      ),
    ]);

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
              SizedBox(
                height: 25,
              ),
              BroadcastMessageWidget(),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Modernland Market Snips",
                    style: MyTheme.myStyleSecondaryTextStyle.copyWith(
                        fontSize: ScaleSize.textScaleFactor(context,
                            maxTextScaleFactor: 33),
                        color: AppColors.primaryColor2),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MDLNNewsAllPage(
                          title: "MDLN Snips",
                        );
                      }));
                    },
                    child: Text(
                      "Lihat Semua",
                      style: MyTheme.myStyleSecondaryTextStyle.copyWith(
                          fontSize: ScaleSize.textScaleFactor(context,
                              maxTextScaleFactor: 28),
                          color: AppColors.primaryColor2),
                    ),
                  ),
                ],
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
                              height: 330,
                              child:
                                  Center(child: CupertinoActivityIndicator()));
                        } else if (state is StreamStateLoadSuccess) {
                          return Container(
                            height: 330,
                            child: ListView.builder(
                              itemCount: state.datas.length,
                              scrollDirection: Axis.horizontal,
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
                                  child: StreamCard(
                                      streamUiModel: StreamUIModel(
                                          description:
                                              item.contentOriginal ?? "",
                                          name: item.title ?? "",
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Stock Movement",
                style: MyTheme.myStyleSecondaryTextStyle.copyWith(
                    fontSize: ScaleSize.textScaleFactor(context,
                        maxTextScaleFactor: 33),
                    color: AppColors.primaryColor2),
              ),
              const SizedBox(
                height: 20,
              ),
              buildStockMovementCard(context, rowSpacer),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shareholder Transaction (EOD)",
                    style: MyTheme.myStyleSecondaryTextStyle.copyWith(
                        fontSize: ScaleSize.textScaleFactor(context,
                            maxTextScaleFactor: 33),
                        color: AppColors.primaryColor2),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const MDLNShareholderAllPage(
                          title: "Shareholder Transaction",
                        );
                      }));
                    },
                    child: Text(
                      "Lihat Semua",
                      style: MyTheme.myStyleSecondaryTextStyle.copyWith(
                          fontSize: ScaleSize.textScaleFactor(context,
                              maxTextScaleFactor: 28),
                          color: AppColors.primaryColor2),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              BlocProvider(
                create: (_) => shareholderCubit..fetchShareholder(),
                child: Column(
                  children: [
                    BlocBuilder<ShareholderMovementCubit, StreamState>(
                      bloc: shareholderCubit..fetchShareholder(),
                      builder: (context, state) {
                        if (state is StreamStateLoading) {
                          return Container(
                              height: 100,
                              child:
                                  Center(child: CupertinoActivityIndicator()));
                        } else if (state is StreamStateLoadShareholder) {
                          return Container(
                            height: 180,
                            child: ListView.builder(
                              itemCount: min(state.datas.length, 5),
                              // Limit the count to a maximum of 5
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final item = state.datas[index];
                                var photoUrl = "";
                                var isBuying = false;
                                var shareHolderName = item.name ?? "Investor ";
                                var buyingValue = item.changes?.value ?? "0";

                                if (item.changes?.value?.contains("+") ==
                                    true) {
                                  isBuying = true;
                                }

                                var description = shareHolderName;

                                if (isBuying) {
                                  description += "\n" + buyingValue + " shares";
                                } else {
                                  description += "\n" + buyingValue + " shares";
                                }
                                return ShareholderTransactionWidget(
                                  userName: item.name ?? "",
                                  comment: description,
                                  postingDate: item.date ?? "",
                                  bottomText:
                                      (item.current?.percentage ?? "") + "%",
                                );
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
                          description: "Terakhir diupdate : 12 Mei 2023",
                          photoAsset: "asset/img/dummy/guideline_1.png"),
                    ),
                    TipsAndTrickWidget(
                      uimodel: TipsAndTrickUIModel(
                          name: "Pedoman Penggunaan",
                          description: "Terakhir diupdate : 12 Mei 2023",
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

  Widget buildStockMovementCard(BuildContext context, TableRow rowSpacer) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8,
      child: BlocProvider(
        create: (_) => orderbookCubit,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 20, top: 20),
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
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.07,
                              backgroundImage: NetworkImage(
                                'http://feylabs.my.id/fm/mdln_asset/mdln_circle_placeholder.png',
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "MDLN",
                                  style:
                                      MyTheme.myStylePrimaryTextStyle.copyWith(
                                        fontWeight: FontWeight.w600,
                                    fontSize: ScaleSize.textScaleFactor(context,
                                        maxTextScaleFactor: 33),
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ScaleSize.textScaleFactor(
                                          context,
                                          maxTextScaleFactor: 29),
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "PT Modernland Realty Tbk",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              BlocBuilder<OrderbookCubit, StreamState>(
                                bloc: orderbookCubit..fetchPrice(),
                                builder: (context, state) {
                                  if (state is StreamStateLoading) {
                                    return CupertinoActivityIndicator();
                                  } else if (state
                                      is StreamStateOrderbookSuccess) {
                                    var data = state.datas;
                                    var percentageString = state
                                            .datas.data?.percentageChange
                                            .toString() ??
                                        "";
                                    var pointChange =
                                        state.datas.data?.change.toString() ??
                                            "";
                                    final double pointChangeValue =
                                        double.tryParse(pointChange) ?? 0;
                                    return Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            data.data?.lastprice.toString() ??
                                                "0",
                                            style: MyTheme
                                                .myStylePrimaryTextStyle
                                                .copyWith(
                                              fontSize:
                                                  ScaleSize.textScaleFactor(
                                                      context,
                                                      maxTextScaleFactor: 33),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '$percentageString% (${pointChangeValue >= 0 ? '+' : ''}$pointChange)',
                                            style: MyTheme
                                                .myStyleSecondaryTextStyle
                                                .copyWith(
                                              fontSize:
                                                  ScaleSize.textScaleFactor(
                                                      context,
                                                      maxTextScaleFactor: 33),
                                              color: pointChangeValue < 0
                                                  ? Colors.red
                                                  : Colors.green,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Text("...");
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Table(
                border: TableBorder.symmetric(
                    inside: BorderSide.none,
                    // outside: BorderSide(width: 1, color: Colors.grey),
                    outside: BorderSide.none),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      TableCell(child: Text('Open')),
                      TableCell(
                        child: BlocBuilder<OrderbookCubit, StreamState>(
                          bloc: orderbookCubit,
                          builder: (context, state) {
                            if (state is StreamStateLoading) {
                              return buildLoadingIndicator();
                            } else if (state is StreamStateOrderbookSuccess) {
                              return Text(
                                state.datas.data?.open.toString() ?? "-",
                                style: TextStyle(
                                  color: (state.datas.data?.change ?? 0) < 0
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              );
                            } else {
                              return Text("-");
                            }
                          },
                        ),
                      ),
                      TableCell(child: Text('Lot')),
                      TableCell(
                        child: BlocBuilder<OrderbookCubit, StreamState>(
                          bloc: orderbookCubit,
                          builder: (context, state) {
                            if (state is StreamStateLoading) {
                              return buildLoadingIndicator();
                            } else if (state is StreamStateOrderbookSuccess) {
                              return Text(
                                toAbbreviatedNumberString(
                                    (state.datas.data?.volume ?? 0) / 100),
                                style: TextStyle(
                                  color: (state.datas.data?.change ?? 0) < 0
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              );
                            } else {
                              return Text("-");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  rowSpacer,
                  TableRow(
                    children: [
                      TableCell(child: Text('High')),
                      TableCell(
                        child: BlocBuilder<OrderbookCubit, StreamState>(
                          bloc: orderbookCubit,
                          builder: (context, state) {
                            if (state is StreamStateLoading) {
                              return buildLoadingIndicator();
                            } else if (state is StreamStateOrderbookSuccess) {
                              return Text(
                                  state.datas.data?.high.toString() ?? "-",
                                  style: TextStyle(
                                    color: (state.datas.data?.change ?? 0) < 0
                                        ? Colors.red
                                        : Colors.green,
                                  ));
                            } else {
                              return Text("-");
                            }
                          },
                        ),
                      ),
                      TableCell(child: Text('Val')),
                      TableCell(
                        child: BlocBuilder<OrderbookCubit, StreamState>(
                          bloc: orderbookCubit,
                          builder: (context, state) {
                            if (state is StreamStateLoading) {
                              return buildLoadingIndicator();
                            } else if (state is StreamStateOrderbookSuccess) {
                              return Text(
                                  toAbbreviatedNumberString(
                                      state.datas.data?.value),
                                  style: TextStyle(
                                    color: (state.datas.data?.change ?? 0) < 0
                                        ? Colors.red
                                        : Colors.green,
                                  ));
                            } else {
                              return Text("-");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  rowSpacer,
                  TableRow(
                    children: [
                      TableCell(child: Text('Low')),
                      TableCell(
                        child: BlocBuilder<OrderbookCubit, StreamState>(
                          bloc: orderbookCubit,
                          builder: (context, state) {
                            if (state is StreamStateLoading) {
                              return buildLoadingIndicator();
                            } else if (state is StreamStateOrderbookSuccess) {
                              return Text(
                                  state.datas.data?.low.toString() ?? "-",
                                  style: TextStyle(
                                    color: (state.datas.data?.change ?? 0) < 0
                                        ? Colors.red
                                        : Colors.green,
                                  ));
                            } else {
                              return Text("-");
                            }
                          },
                        ),
                      ),
                      TableCell(child: Text('Average')),
                      TableCell(
                        child: BlocBuilder<OrderbookCubit, StreamState>(
                          bloc: orderbookCubit,
                          builder: (context, state) {
                            if (state is StreamStateLoading) {
                              return buildLoadingIndicator();
                            } else if (state is StreamStateOrderbookSuccess) {
                              return Text(
                                  state.datas.data?.average.toString() ?? "-",
                                  style: TextStyle(
                                    color: (state.datas.data?.change ?? 0) < 0
                                        ? Colors.red
                                        : Colors.green,
                                  ));
                            } else {
                              return Text("-");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildLoadingIndicator() {
    return Container(
      child: Align(
        alignment: Alignment.centerLeft,
        child: CupertinoActivityIndicator(radius: 4),
      ),
    );
  }
}
