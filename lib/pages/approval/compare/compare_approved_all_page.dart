import 'package:bwa_cozy/bloc/compare/compare_bloc.dart';
import 'package:bwa_cozy/bloc/compare/compare_event.dart';
import 'package:bwa_cozy/bloc/compare/compare_state.dart';
import 'package:bwa_cozy/bloc/compare/filter/filter_compare_cubit.dart';
import 'package:bwa_cozy/pages/approval/compare/detail_compare_page.dart';
import 'package:bwa_cozy/pages/approval/compare/filter_compare_util.dart';
import 'package:bwa_cozy/repos/compare_repository.dart';
import 'package:bwa_cozy/util/core/string/date_formatter.dart';
import 'package:bwa_cozy/util/core/string/html_util.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/widget/approval/item_approval_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CompareAllApprovedPage extends StatefulWidget {
  const CompareAllApprovedPage({Key? key}) : super(key: key);

  @override
  State<CompareAllApprovedPage> createState() => _CompareAllApprovedPageState();
}

class _CompareAllApprovedPageState extends State<CompareAllApprovedPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    CompareRepository compareRepository = CompareRepository();
    CompareBloc compareBloc = CompareBloc(compareRepository);
    FilterCompareCubit filterCompareCubit = FilterCompareCubit();
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'asset/img/background/bg_pattern_fp.png'),
                                  repeat: ImageRepeat.repeat,
                                ),
                              ),
                              width: double.infinity,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 30, right: 30, top: 10),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.arrow_back),
                                      color: Colors.white,
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // Implement your back button functionality here
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        "History Approved Comparison ",
                                        style: MyTheme.myStylePrimaryTextStyle
                                            .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        width: MediaQuery.sizeOf(context).width,
                        child: Stack(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: 0, right: 0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30.0)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "History Approved Compare",
                                          textAlign: TextAlign.start,
                                          style: MyTheme.myStylePrimaryTextStyle
                                              .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          "Halaman ini menampilkan list Compare yang telah diapprove",
                                          textAlign: TextAlign.start,
                                          style: MyTheme.myStylePrimaryTextStyle
                                              .copyWith(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  BlocProvider(
                                      create: (context) => filterCompareCubit,
                                      // Provide an instance of the CounterBloc
                                      child: Container()),
                                  buildFilterSection(
                                      compareBloc: compareBloc,
                                      filterCompareCubit: filterCompareCubit,
                                      context: context),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocProvider(
                        create: (BuildContext context) {
                          return compareBloc..add(GetHistoryCompare());
                        },
                        child: BlocBuilder<CompareBloc, CompareState>(
                          builder: (context, state) {
                            var status = "";
                            Widget dataList = Text("");
                            if (state is CompareStateFailure) {}
                            if (state is CompareStateLoading) {
                              return Center(
                                child: CupertinoActivityIndicator(),
                              );
                            }
                            if (state is CompareStateLoadHistorySuccess) {
                              var approvalList = state.datas;
                              if (approvalList.isEmpty) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        'http://feylabs.my.id/fm/mdln_asset/mdln_empty_image.png',
                                        // Adjust the image properties as per your requirement
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'No data available',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              dataList = ListView.builder(
                                itemCount: approvalList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final pbjItem = approvalList[index];
                                  var isApproved = false;
                                  if (pbjItem.status != "Y") {
                                    isApproved = true;
                                  }
                                  return ItemApprovalWidget(
                                    requiredId: pbjItem.idCompare,
                                    isApproved: isApproved,
                                    itemCode: pbjItem.noCompare,
                                    date: pbjItem.tglPermintaan,
                                    departmentTitle: pbjItem.department,
                                    personName: pbjItem.namaUser,
                                    descriptiveText: removeHtmlTags(
                                        pbjItem.descCompare ?? ""),
                                    personImage: "",
                                    onPressed: (String requiredId) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailComparePage(
                                                  noCompare:
                                                      pbjItem.noCompare ?? "",
                                                  isFromHistory: true,
                                                  idCompare:
                                                      pbjItem.idCompare ?? ""),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                            return Container(
                              child: dataList,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterSection(
      {required FilterCompareCubit filterCompareCubit,
      required CompareBloc compareBloc,
      required BuildContext context}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: BlocProvider(
                        create: (BuildContext context) {
                          return filterCompareCubit;
                        },
                        child: Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Filter Options",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    const Text(
                                      "Start Date:",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime(2020),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2030),
                                        );
                                        if (pickedDate != null) {
                                          await FilterCompareUtil
                                              .saveTemporaryFilterKeys(
                                                  pickedDate, null, null);
                                          setState(() {});
                                          Fluttertoast.showToast(
                                              msg: pickedDate.day.toString() ??
                                                  "");
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          FutureBuilder<DateTime?>(
                                            future: FilterCompareUtil
                                                .getTemporaryStartDate(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                // While the future is loading, show a loading indicator or placeholder
                                                return CircularProgressIndicator();
                                              } else if (snapshot.hasData &&
                                                  snapshot.data != null) {
                                                return Text(snapshot.data
                                                        ?.toIso8601String() ??
                                                    "");
                                              } else {
                                                return Text('Pick Start Date');
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    const Text(
                                      "End Date:",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime(2020),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2030),
                                        );
                                        if (pickedDate != null) {
                                          filterCompareCubit
                                              .setEndDate(pickedDate);
                                          Fluttertoast.showToast(
                                              msg:
                                                  pickedDate.toIso8601String());
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          // BlocBuilder<FilterCompareCubit,
                                          //     FilterCompareOptions>(
                                          //   builder: (context, state) {
                                          //     return Text(state.endDate !=
                                          //             null
                                          //         ? (mdlnFormatDate(
                                          //                 state.endDate ??
                                          //                     DateTime.now(),
                                          //                 DateFormatType
                                          //                     .dayMonthYearIndonesian) ??
                                          //             "")
                                          //         : "Select End Date");
                                          //   },
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                TextField(
                                  decoration: const InputDecoration(
                                    labelText:
                                        "Search by Keyword (Number, Sender Name, etc.)",
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (String value) {
                                    filterCompareCubit.setFilterKeyword(value);
                                  },
                                ),
                                SizedBox(height: 16),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          color: Colors
                                              .red), // Set the border color to red
                                    ),
                                    icon: const Icon(
                                      Icons.clear, // Cross icon
                                      color: Colors
                                          .red, // Set the icon color to red
                                    ),
                                    label: const Text(
                                      "Clear Filters",
                                      style: TextStyle(
                                          color: Colors
                                              .red), // Set the text color to red
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          color: Colors
                                              .black), // Set the border color to red
                                    ),
                                    icon: const Icon(
                                      Icons.check, // Cross icon
                                      color: Colors
                                          .black, // Set the icon color to red
                                    ),
                                    label: const Text(
                                      "Apply",
                                      style: TextStyle(
                                          color: Colors
                                              .black), // Set the text color to red
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).whenComplete(() {
                compareBloc.add(GetHistoryCompare(
                    noPermintaan: filterCompareCubit.state.filterKeyword,
                    startDate:
                        filterCompareCubit.state.startDate?.toIso8601String() ??
                            "",
                    endDate:
                        filterCompareCubit.state.endDate?.toIso8601String() ??
                            ""));
              });
            },
            child: const Row(children: [
              Icon(Icons.filter_list),
              SizedBox(width: 8),
              Text('Filter')
            ]),
          ),
        ),
        BlocProvider<FilterCompareCubit>(
            create: (context) => filterCompareCubit,
            // Provide a builder function that returns an instance of the CounterBloc
            child: BlocBuilder<FilterCompareCubit, FilterCompareOptions>(
              builder: (context, state) {
                return Container(
                  width: MediaQuery.sizeOf(context).width,
                  margin: EdgeInsets.all(10),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (state.filterKeyword.isNotEmpty)
                        InputChip(
                          label: Text(state.filterKeyword),
                          onSelected: (value) {},
                          deleteIcon: Icon(Icons.close),
                          onDeleted: () {
                            filterCompareCubit.setFilterKeyword('');
                          },
                        ),
                      if (state.startDate != null && state.endDate != null)
                        InputChip(
                          label: Text(mdlnFormatDate(
                                  state.startDate ?? DateTime.now(),
                                  DateFormatType.dayMonthYear) +
                              "-" +
                              mdlnFormatDate(state.endDate ?? DateTime.now(),
                                  DateFormatType.dayMonthYear)),
                          onSelected: (value) {},
                          deleteIcon: Icon(Icons.close),
                          onDeleted: () {
                            filterCompareCubit.setFilterKeyword('');
                          },
                        ),
                    ],
                  ),
                );
              },
            )),
      ],
    );
  }
}
