import 'dart:math';

import 'package:bwa_cozy/bloc/login/login_response.dart';
import 'package:bwa_cozy/bloc/notif/notif_bloc.dart';
import 'package:bwa_cozy/bloc/stream/orderbook_cubit.dart';
import 'package:bwa_cozy/bloc/stream/shareholder_movement_cubit.dart';
import 'package:bwa_cozy/bloc/stream/stream_cubit.dart';
import 'package:bwa_cozy/bloc/stream/stream_state.dart';
import 'package:bwa_cozy/data/dio_client.dart';
import 'package:bwa_cozy/di/service_locator.dart';
import 'package:bwa_cozy/pages/common/webview_page.dart';
import 'package:bwa_cozy/pages/stock/mdln_news_all_page.dart';
import 'package:bwa_cozy/pages/stock/mdln_shareholder_all_page.dart';
import 'package:bwa_cozy/repos/stream/stream_repository.dart';
import 'package:bwa_cozy/util/core/string/currency_util.dart';
import 'package:bwa_cozy/util/my_colors.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/util/responsiveness/scale_size.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:bwa_cozy/widget/common/broadcast_message_widget.dart';
import 'package:bwa_cozy/widget/common/shareholder_transaction_widget.dart';
import 'package:bwa_cozy/widget/stream/stream_card.dart';
import 'package:bwa_cozy/widget/stream/stream_ui_model.dart';
import 'package:bwa_cozy/widget/tips_and_trick/tips_and_trick_ui_model.dart';
import 'package:bwa_cozy/widget/tips_and_trick/tips_and_trick_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final streamRepository = StreamRepository(dioClient: getIt<DioClient>());

    streamCubit = StreamCubit(streamRepository);
    orderbookCubit = OrderbookCubit(streamRepository);
    shareholderCubit = ShareholderMovementCubit(streamRepository);
  }

  String getGreeting() {
    DateTime now = DateTime.now();
    int currentHour = now.hour;

    if (currentHour >= 0 && currentHour < 12) {
      return "Selamat Pagi";
    } else if (currentHour >= 12 && currentHour < 18) {
      return "Selamat Siang";
    } else {
      return "Selamat Malam";
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.white, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.dark, //navigation bar icons' color
    ));

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.red,
            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Container(
            margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.05,
              backgroundImage: NetworkImage(
                'http://feylabs.my.id/fm/mdln_asset/mdln_circle_placeholder.png',
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
          title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getGreeting(),
                  style: GoogleFonts.montserrat(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500,
                    fontSize: ScaleSize.textScaleFactor(context,
                        maxTextScaleFactor: 28),
                  ),
                ),
                FutureBuilder<UserDTO?>(
                  future: SessionManager.getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // While the future is loading, show a loading indicator or placeholder
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData && snapshot.data != null) {
                      UserDTO user = snapshot.data!;
                      return Text(
                        user.nama,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: ScaleSize.textScaleFactor(context,
                              maxTextScaleFactor: 25),
                        ),
                      );
                    } else {
                      return Text('User not found');
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.03,
              backgroundImage: NetworkImage(
                'http://feylabs.my.id/fm/mdln_asset/profile.png',
              ),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(width: 10),
            // Add spacing between the profile avatar and the edge of the appbar
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 0),
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              BroadcastMessageWidget(),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kabar Modernland",
                    style: MyTheme.myStyleSecondaryTextStyle.copyWith(
                        fontSize: ScaleSize.textScaleFactor(context,
                            maxTextScaleFactor: 32),
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
                              height: 30,
                              child:
                                  Center(child: CupertinoActivityIndicator()));
                        } else if (state is StreamStateLoadSuccess) {
                          return Container(
                              height: 320,
                              child: CupertinoScrollbar(
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
                                            MaterialPageRoute(
                                                builder: (context) {
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
                                            bottomText:
                                                item.newsFeed?.label ?? "MDLN",
                                            photoUrl: photoUrl),
                                      ),
                                    );
                                    return Text(item.title ?? "");
                                  },
                                ),
                              ));
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
              Container(
                width: double.infinity,
                child: Text(
                  "Menu",
                  style: MyTheme.myStyleSecondaryTextStyle.copyWith(
                      fontSize: ScaleSize.textScaleFactor(context,
                          maxTextScaleFactor: 32),
                      color: AppColors.primaryColor2),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildMenuItem(CupertinoIcons.square_list_fill,
                            'Inter Office Memo'),
                        _buildMenuItem(CupertinoIcons.cart_fill_badge_plus,
                            'Pengadaan Barang Jasa'),
                        _buildMenuItem(
                            CupertinoIcons.checkmark_seal_fill, 'Comparison'),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildMenuItem(CupertinoIcons.money_dollar_circle_fill,
                            'Realisasi'),
                        _buildMenuItem(
                            CupertinoIcons.creditcard_fill, 'Kasbon'),
                        _buildMenuItem(CupertinoIcons.person_fill, 'Profile',
                            badgeCount: 0),
                      ],
                    ),
                  ],
                ),
              ),
              buildStockMovementCard(context, rowSpacer),
              const SizedBox(
                height: 20,
              ),
              buildShareholderTransactionWidget(context),
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

  Column buildShareholderTransactionWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Shareholder Transaction (EOD)",
              style: MyTheme.myStyleSecondaryTextStyle.copyWith(
                  fontSize: ScaleSize.textScaleFactor(context,
                      maxTextScaleFactor: 32),
                  color: AppColors.primaryColor2),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                        child: Center(child: CupertinoActivityIndicator()));
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

                          if (item.changes?.value?.contains("+") == true) {
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
                            bottomText: (item.current?.percentage ?? "") + "%",
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
      ],
    );
  }

  Widget buildStockMovementCard(BuildContext context, TableRow rowSpacer) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          child: Text(
            "Stock Movement",
            style: MyTheme.myStyleSecondaryTextStyle.copyWith(
                fontSize:
                    ScaleSize.textScaleFactor(context, maxTextScaleFactor: 30),
                color: AppColors.primaryColor2),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Card(
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
                                  radius:
                                      MediaQuery.of(context).size.width * 0.07,
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
                                      style: MyTheme.myStylePrimaryTextStyle
                                          .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScaleSize.textScaleFactor(
                                            context,
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
                                        var pointChange = state
                                                .datas.data?.change
                                                .toString() ??
                                            "";
                                        final double pointChangeValue =
                                            double.tryParse(pointChange) ?? 0;
                                        return Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                data.data?.lastprice
                                                        .toString() ??
                                                    "0",
                                                style: MyTheme
                                                    .myStylePrimaryTextStyle
                                                    .copyWith(
                                                  fontSize:
                                                      ScaleSize.textScaleFactor(
                                                          context,
                                                          maxTextScaleFactor:
                                                              33),
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
                                                          maxTextScaleFactor:
                                                              33),
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
                                } else if (state
                                    is StreamStateOrderbookSuccess) {
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
                                } else if (state
                                    is StreamStateOrderbookSuccess) {
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
                                } else if (state
                                    is StreamStateOrderbookSuccess) {
                                  return Text(
                                      state.datas.data?.high.toString() ?? "-",
                                      style: TextStyle(
                                        color:
                                            (state.datas.data?.change ?? 0) < 0
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
                                } else if (state
                                    is StreamStateOrderbookSuccess) {
                                  return Text(
                                      toAbbreviatedNumberString(
                                          state.datas.data?.value),
                                      style: TextStyle(
                                        color:
                                            (state.datas.data?.change ?? 0) < 0
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
                                } else if (state
                                    is StreamStateOrderbookSuccess) {
                                  return Text(
                                      state.datas.data?.low.toString() ?? "-",
                                      style: TextStyle(
                                        color:
                                            (state.datas.data?.change ?? 0) < 0
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
                                } else if (state
                                    is StreamStateOrderbookSuccess) {
                                  return Text(
                                      state.datas.data?.average.toString() ??
                                          "-",
                                      style: TextStyle(
                                        color:
                                            (state.datas.data?.change ?? 0) < 0
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
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String text, {int badgeCount = 8}) {
    return Expanded(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Color(0xffEFF1F3),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Icon(icon, size: 30.0),
              ),
              if (badgeCount > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      badgeCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 5.0),
          Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
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
