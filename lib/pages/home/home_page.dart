import 'package:bwa_cozy/bloc/notif/notif_bloc.dart';
import 'package:bwa_cozy/bloc/stream/stream_cubit.dart';
import 'package:bwa_cozy/bloc/stream/stream_state.dart';
import 'package:bwa_cozy/pages/detail/detail_project_page.dart';
import 'package:bwa_cozy/repos/stream/stream_repository.dart';
import 'package:bwa_cozy/util/my_colors.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/util/resposiveness.dart';
import 'package:bwa_cozy/widget/recommended_space/recommended_space_ui_model.dart';
import 'package:bwa_cozy/widget/recommended_space/recommended_space_widget.dart';
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

  @override
  void initState() {
    super.initState();
    streamCubit = StreamCubit(StreamRepository());
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
                  StreamRepository().getMDLNNews();
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
                          return Center(child: CupertinoActivityIndicator());
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
              Container(
                height: 275,
                margin: EdgeInsets.only(top: 20),
                child: ListView(
                  primary: false,
                  scrollDirection: Axis.vertical,
                  children: [
                    RecommendedSpaceWidget(
                      uimodel: RecommendedSpaceUIModel(
                        name: "Cluster Yossy",
                        location: "Jakarta Garden City",
                      ),
                    ),
                    RecommendedSpaceWidget(
                      onCardTap: (id) {
                        // Handle the card tap event with the provided id
                        print('Tapped on card with ID: $id');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return DetailProjectPage(
                              projectId: id,
                            );
                          }),
                        );
                        // Perform any other actions based on the id
                      },
                      uimodel: RecommendedSpaceUIModel(
                        name: "Gajah Mada Suit",
                        location: "Novotel Gajah Mada ",
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Tips and Trick",
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
