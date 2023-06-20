import 'package:bwa_cozy/bloc/all_approval/approval_main_page_bloc.dart';
import 'package:bwa_cozy/bloc/common_approval_filter/common_approval_filter_bloc.dart';
import 'package:bwa_cozy/bloc/common_approval_filter/common_approval_filter_state.dart';
import 'package:bwa_cozy/bloc/notif/notif_bloc.dart';
import 'package:bwa_cozy/bloc/notif/notif_event.dart';
import 'package:bwa_cozy/bloc/pbj/pbj_main_bloc.dart';
import 'package:bwa_cozy/data/dio_client.dart';
import 'package:bwa_cozy/di/service_locator.dart';
import 'package:bwa_cozy/repos/approval_main_page_repository.dart';
import 'package:bwa_cozy/repos/notif_repository.dart';
import 'package:bwa_cozy/repos/pbj_repository.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PBJFilterTempPage extends StatefulWidget {
  const PBJFilterTempPage({Key? key}) : super(key: key);

  @override
  State<PBJFilterTempPage> createState() => _PBJFilterTempPageState();
}

class _PBJFilterTempPageState extends State<PBJFilterTempPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final messageController = TextEditingController();

  late NotifRepository notifRepository;
  late NotifCoreBloc notifBloc;
  late ApprovalMainPageRepository approvalRepo;
  late ApprovalMainPageBloc approvalBloc;

  late PBJRepository pbjRepo;
  late PBJBloc pbjBloc;

  @override
  void initState() {
    super.initState();
    notifRepository = NotifRepository(dioClient: getIt<DioClient>());
    notifBloc = NotifCoreBloc(notifRepository);
    approvalRepo = ApprovalMainPageRepository();
    approvalBloc = ApprovalMainPageBloc(approvalRepo);
    pbjRepo = PBJRepository();
    pbjBloc = PBJBloc(pbjRepo);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      color: Colors.redAccent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              Flexible(
                                child: Text(
                                  "History Approval PBJ" + "",
                                  style:
                                      MyTheme.myStylePrimaryTextStyle.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          BlocProvider(
                            create: (context) => FilterBloc(),
                            child: Column(
                              children: [
                                BlocListener<FilterBloc, FilterState>(
                                  listener: (context, state) {
                                    if (state.submitted) {
                                      print("submit gaes");
                                      print(state.selectedOption);
                                      print(state.nomorRequest);
                                      print(
                                          'Start Date: ${state.startDateTime}');
                                      print('End Date: ${state.endDateTime}');
                                    }
                                  },
                                  child: Container(),
                                ),
                                BlocBuilder<FilterBloc, FilterState>(
                                  builder: (context, state) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      elevation: 4,
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Form(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Choose Filter Option:',
                                                style: MyTheme
                                                    .myStylePrimaryTextStyle
                                                    .copyWith(),
                                              ),
                                              DropdownButtonFormField<String>(
                                                value: state.selectedOption,
                                                items: <String>[
                                                  'All',
                                                  'Tanggal Buat',
                                                  'Nomor Request'
                                                ].map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: MyTheme
                                                          .myStylePrimaryTextStyle
                                                          .copyWith(),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  context
                                                      .read<FilterBloc>()
                                                      .setSelectedOption(
                                                          newValue!);
                                                },
                                              ),
                                              if (state.selectedOption ==
                                                  'Tanggal Buat')
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    SizedBox(height: 12),
                                                    Text(
                                                      'Dari :',
                                                      style: MyTheme
                                                          .myStylePrimaryTextStyle
                                                          .copyWith(),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        final selectedDate =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate: state
                                                                  .startDateTime ??
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(1900),
                                                          lastDate:
                                                              DateTime(2100),
                                                        );

                                                        if (state
                                                                .selectedOption ==
                                                            "Tanggal Buat") {
                                                          if (selectedDate !=
                                                              null) {
                                                            context
                                                                .read<
                                                                    FilterBloc>()
                                                                .setStartDateTime(
                                                                    selectedDate);
                                                          }
                                                        } else {}
                                                      },
                                                      child: Text(
                                                        state.startDateTime !=
                                                                null
                                                            ? '${state.startDateTime!.toLocal()}'
                                                                .split(' ')[0]
                                                            : 'Select Start Date',
                                                      ),
                                                    ),
                                                    SizedBox(height: 12),
                                                    Text(
                                                      'Sampai :',
                                                      style: MyTheme
                                                          .myStylePrimaryTextStyle
                                                          .copyWith(),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        final selectedDate =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate: state
                                                                  .endDateTime ??
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(1900),
                                                          lastDate:
                                                              DateTime(2100),
                                                        );
                                                        if (selectedDate !=
                                                            null) {
                                                          context
                                                              .read<
                                                                  FilterBloc>()
                                                              .setEndDateTime(
                                                                  selectedDate);
                                                        }
                                                      },
                                                      child: Text(
                                                        state.endDateTime !=
                                                                null
                                                            ? '${state.endDateTime!.toLocal()}'
                                                                .split(' ')[0]
                                                            : 'Select Date',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (state.selectedOption ==
                                                  'Nomor Request')
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                    labelText: 'Nomor Request',
                                                    labelStyle: TextStyle(),
                                                  ),
                                                  onChanged: (value) {
                                                    print(state.nomorRequest
                                                            .toString() +
                                                        "yuhuu");
                                                    context
                                                        .read<FilterBloc>()
                                                        .setNomorRequest(value);
                                                  },
                                                ),
                                              SizedBox(height: 16.0),
                                              OutlinedButton(
                                                onPressed: () {
                                                  context
                                                      .read<FilterBloc>()
                                                      .submitForm();
                                                },
                                                child: Text('Submit'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
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
                      child: Container(
                        margin: EdgeInsets.only(top: 20, left: 0, right: 0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30.0)),
                        ),
                        child: Container(
                          child: Column(
                            children: [
                              Container(color: Colors.blue),
                              BlocProvider(
                                  create: (BuildContext context) {
                                    return notifBloc..add(NotifEventCount());
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Riwayat PBJ",
                                      textAlign: TextAlign.start,
                                      style: MyTheme.myStylePrimaryTextStyle
                                          .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
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
            ),
          ],
        ),
      ),
    );
  }
}
