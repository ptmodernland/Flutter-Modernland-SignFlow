import 'package:modernland_signflow/bloc/all_approval/approval_main_page_bloc.dart';
import 'package:modernland_signflow/bloc/realisasi/realisasi_action_bloc.dart';
import 'package:modernland_signflow/bloc/realisasi/realisasi_action_event.dart';
import 'package:modernland_signflow/bloc/realisasi/realisasi_comment_bloc.dart';
import 'package:modernland_signflow/bloc/realisasi/realisasi_comment_event.dart';
import 'package:modernland_signflow/bloc/realisasi/realisasi_detail_bloc.dart';
import 'package:modernland_signflow/bloc/realisasi/realisasi_event.dart';
import 'package:modernland_signflow/bloc/realisasi/realisasi_state.dart';
import 'package:modernland_signflow/data/dio_client.dart';
import 'package:modernland_signflow/di/service_locator.dart';
import 'package:modernland_signflow/repos/approval_main_page_repository.dart';
import 'package:modernland_signflow/repos/notif_repository.dart';
import 'package:modernland_signflow/repos/realisasi_repository.dart';
import 'package:modernland_signflow/util/core/url/base_url.dart';
import 'package:modernland_signflow/util/enum/action_type.dart';
import 'package:modernland_signflow/util/my_theme.dart';
import 'package:modernland_signflow/widget/approval/document_detail_widget.dart';
import 'package:modernland_signflow/widget/approval/item_approval_widget.dart';
import 'package:modernland_signflow/widget/common/user_comment_widget.dart';
import 'package:modernland_signflow/widget/core/blurred_dialog.dart';
import 'package:modernland_signflow/widget/core/custom_text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';

class RealisasiDetailPage extends StatefulWidget {
  const RealisasiDetailPage(
      {Key? key, required this.noRealisasi, this.isFromHistory = false})
      : super(key: key);
  final String noRealisasi;
  final bool isFromHistory;

  @override
  State<RealisasiDetailPage> createState() => _RealisasiDetailPageState();
}

class _RealisasiDetailPageState extends State<RealisasiDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final messageController = TextEditingController();

  late NotifRepository notifRepository;
  late ApprovalMainPageRepository approvalRepo;
  late ApprovalMainPageBloc approvalBloc;

  late RealisasiRepository realisasiRepo;
  late RealisasiActionBloc realisasActionBloc;
  late RealisasiCommentBloc realisasiCommentBloc;
  late RealisasiDetailBloc realisasiDetailBloc;

  @override
  void initState() {
    super.initState();
    approvalRepo = ApprovalMainPageRepository(dioClient: getIt<DioClient>());
    approvalBloc = ApprovalMainPageBloc(approvalRepo);
    realisasiRepo = RealisasiRepository(dioClient: getIt<DioClient>());
    realisasActionBloc = RealisasiActionBloc(realisasiRepo);
    realisasiDetailBloc = RealisasiDetailBloc(realisasiRepo);
    realisasiCommentBloc = RealisasiCommentBloc(realisasiRepo);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          buildScaffold(context),
          BlocProvider<RealisasiActionBloc>(
            create: (context) => realisasActionBloc,
            // Replace with your actual cubit instantiation
            child: BlocBuilder<RealisasiActionBloc, RealisasiState>(
              bloc: realisasActionBloc,
              builder: (context, state) {
                if (state is RealisasiStateLoading) {
                  return const BlurredDialog(loadingText: "Please Wait");
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
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
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 30, right: 30, top: 0),
                                    child: Row(
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
                                            "Detail Realisasi " +
                                                widget.noRealisasi,
                                            style: MyTheme
                                                .myStylePrimaryTextStyle
                                                .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
                            margin: EdgeInsets.only(top: 20, left: 0, right: 0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30.0)),
                            ),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Detail Request #" +
                                              widget.noRealisasi,
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
                        ],
                      ),
                    ),
                    BlocProvider(
                      create: (BuildContext context) {
                        return realisasiDetailBloc
                          ..add(GetRealisasiDetailEvent(
                              idRealisasi: widget.noRealisasi));
                      },
                      child: BlocBuilder<RealisasiDetailBloc, RealisasiState>(
                        builder: (context, state) {
                          var status = "";
                          Widget dataList = Text("");
                          if (state is RealisasiStateLoading) {}
                          if (state is RealisasiStateFailure) {}

                          if (state is RealisasiDetailSuccess) {
                            var data = state.data;
                            var isApproved = false;
                            if (data.status != "Y") {
                              isApproved = true;
                            }

                            if (widget.isFromHistory) {
                              isApproved = true;
                            } else {
                              isApproved = false;
                            }

                            return Container(
                              child: Column(
                                children: [
                                  ItemApprovalWidget(
                                    requiredId: data.noRealisasi,
                                    isApproved: isApproved,
                                    itemCode: data.noRealisasi,
                                    date: data.tglRealisasi,
                                    departmentTitle: data.departemen,
                                    personName: data.namaUser,
                                    personImage: "",
                                    onPressed: (String requiredId) {},
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    width: MediaQuery.sizeOf(context).width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "Detail Dokumen",
                                          textAlign: TextAlign.start,
                                          style: MyTheme.myStylePrimaryTextStyle
                                              .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: DocumentDetailWidget(
                                                title: "Nomor Realisasi",
                                                content: data.noRealisasi ?? "",
                                              ),
                                            ),
                                            Expanded(
                                              child: DocumentDetailWidget(
                                                title: "Tanggal",
                                                content:
                                                    data.tglRealisasi ?? "",
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: DocumentDetailWidget(
                                              title: "Nama Karyawan",
                                              content: data.namaUser ?? "",
                                            )),
                                            Expanded(
                                              child: DocumentDetailWidget(
                                                title: "Department",
                                                content: data.departemen ?? "",
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: DocumentDetailWidget(
                                              title: "View Detail",
                                              content: "Klik Disini",
                                              fileURL: DOC_VIEW_REALISASI +
                                                  data.idRealisasi.toString(),
                                              // fileURL: DOC_VIEW_REALISASI +
                                              //     (extractRealisasiId(data.noRealisasi??"")),
                                            )),
                                            Expanded(
                                              child: DocumentDetailWidget(
                                                title:
                                                    "Lihat/Download Attachment",
                                                content: data.attchFile ?? "",
                                                isForDownload: true,
                                                fileURL:
                                                    ATTACH_DOWNLOAD_REALISASI +
                                                        data.attchFile
                                                            .toString(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Komentar",
                                          textAlign: TextAlign.start,
                                          style: MyTheme.myStylePrimaryTextStyle
                                              .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        if (!widget.isFromHistory)
                                          Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CustomTextInput(
                                                  textEditController:
                                                      messageController,
                                                  hintTextString:
                                                      'Isi Tanggapan',
                                                  inputType: InputType.Default,
                                                  enableBorder: true,
                                                  minLines: 3,
                                                  themeColor: Theme.of(context)
                                                      .primaryColor,
                                                  cornerRadius: 18.0,
                                                  textValidator: (value) {
                                                    if (value?.isEmpty ??
                                                        true) {
                                                      return 'Isi field ini terlebih dahulu';
                                                    }
                                                    return null;
                                                  },
                                                  textColor: Colors.black,
                                                  errorMessage:
                                                      'Username cant be empty',
                                                  labelText:
                                                      'Tanggapan/Komentar/Review',
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (BuildContext context) {
                        return realisasiCommentBloc
                          ..add(GetKomentarRealisasi(
                              noRealisasi: widget.noRealisasi));
                      },
                      child: Column(
                        children: [
                          BlocBuilder<RealisasiCommentBloc, RealisasiState>(
                            builder: (context, state) {
                              if (state is RealisasiStateLoadCommentSuccess) {
                                var commentList = state.datas;
                                var commentListViewBuilder = ListView.builder(
                                  itemCount: commentList.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final pbjItem = commentList[index];
                                    var isApproved = false;
                                    if (pbjItem.status != "Y") {
                                      isApproved = true;
                                    }
                                    return UserCommentWidget(
                                      comment: pbjItem.komentar,
                                      userName: pbjItem.approve,
                                      postingDate: pbjItem.tglPermintaan,
                                      bottomText:
                                          "Status : " + pbjItem.statusApprove,
                                    );
                                  },
                                );
                                var emptyState = Container();
                                if (state.datas.isEmpty) {
                                  emptyState = Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          'http://feylabs.my.id/fm/mdln_asset/mdln_empty_image.png',
                                          // Adjust the image properties as per your requirement
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Belum Ada Komentar',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      height: 1,
                                      color: Colors.grey[300],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    emptyState,
                                    commentListViewBuilder,
                                  ],
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    ),
                    BlocProvider(
                      create: (BuildContext context) {
                        return realisasiDetailBloc;
                      },
                      child: Column(
                        children: [
                          BlocListener<RealisasiDetailBloc, RealisasiState>(
                            listener: (context, state) {
                              if (state is RealisasiStateFailure) {
                                if (state.type ==
                                        RealisasiEActionType.APPROVE ||
                                    state.type == RealisasiEActionType.REJECT) {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    text: state.message.toString(),
                                  );
                                }
                              }

                              if (state is RealisasiStateSuccess) {
                                if (state.type ==
                                        RealisasiEActionType.APPROVE ||
                                    state.type == RealisasiEActionType.REJECT) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      var text = "";
                                      if (state.type ==
                                          RealisasiEActionType.APPROVE) {
                                        text = "Request Berhasil Diapprove";
                                      }
                                      if (state.type ==
                                          RealisasiEActionType.REJECT) {
                                        text = "Request Berhasil Direject";
                                      }
                                      return WillPopScope(
                                        onWillPop: () async {
                                          Navigator.of(context)
                                              .pop(); // Handle back button press
                                          return false; // Prevent dialog from being dismissed by back button
                                        },
                                        child: CupertinoAlertDialog(
                                          title: Text(
                                            'Success',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: Text(text),
                                          actions: <Widget>[
                                            CupertinoDialogAction(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                                Navigator.of(context)
                                                    .pop(); // Go back to the previous page
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            child: Container(),
                          ),
                          BlocBuilder<RealisasiDetailBloc, RealisasiState>(
                            builder: (context, state) {
                              var status = "";
                              if (state is RealisasiStateInitial) {}
                              //the button only shown if this page opened not from history

                              if (state is RealisasiDetailSuccess) {
                                if (widget.isFromHistory != true) {
                                  return Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            showPinInputDialog(
                                                noKasbon:
                                                    state.data.noKasbon ?? "",
                                                idRealisasi:
                                                    state.data.idRealisasi ??
                                                        "",
                                                noRealisasi:
                                                    state.data.noRealisasi ??
                                                        "",
                                                type:
                                                    ApprovalActionType.APPROVE,
                                                description:
                                                    "Anda Yakin Ingin Mengapprove Approval ini ?");
                                          },
                                          child: Text(
                                            'Approve',
                                            style:
                                                MyTheme.myStyleButtonTextStyle,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xff33DC9F),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20.0), // Adjust the radius as needed
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            showPinInputDialog(
                                                type: ApprovalActionType.REJECT,
                                                noKasbon:
                                                    state.data.noKasbon ?? "",
                                                idRealisasi:
                                                    state.data.idRealisasi ??
                                                        "",
                                                noRealisasi:
                                                    state.data.noRealisasi ??
                                                        "",
                                                description:
                                                    "Anda Yakin Ingin Menolak Approval ini ?");
                                          },
                                          child: Text(
                                            'Reject',
                                            style:
                                                MyTheme.myStyleButtonTextStyle,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xffFF5B5B),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20.0), // Adjust the radius as needed
                                            ),
                                          ),
                                        ),
                                        // ElevatedButton(
                                        //   onPressed: () {},
                                        //   child: Text(
                                        //     'Recommend',
                                        //     style: MyTheme.myStyleButtonTextStyle,
                                        //   ),
                                        //   style: ElevatedButton.styleFrom(
                                        //     backgroundColor: Color(0xffC4C4C4),
                                        //     shape: RoundedRectangleBorder(
                                        //       borderRadius: BorderRadius.circular(
                                        //           20.0), // Adjust the radius as needed
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  );
                                }
                              }

                              return Container();
                            },
                          ),
                        ],
                      ),
                    ),
                    BlocProvider(
                      create: (BuildContext context) {
                        return realisasActionBloc;
                      },
                      child: Column(
                        children: [
                          BlocListener<RealisasiActionBloc, RealisasiState>(
                            listener: (context, state) {
                              if (state is RealisasiStateFailure) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  text: state.message.toString(),
                                );
                              }

                              if (state is RealisasiStateSuccess) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    var text = "";
                                    if (state.type ==
                                        RealisasiEActionType.APPROVE) {
                                      text = "Request Berhasil Diapprove";
                                    }
                                    if (state.type ==
                                        RealisasiEActionType.REJECT) {
                                      text = "Request Berhasil Direject";
                                    }
                                    return WillPopScope(
                                      onWillPop: () async {
                                        // Navigator.of(context)
                                        //     .pop(); // Handle back button press
                                        return false; // Prevent dialog from being dismissed by back button
                                      },
                                      child: CupertinoAlertDialog(
                                        title: Text(
                                          'Success',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(text),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                              Navigator.of(context)
                                                  .pop(); // Go back to the previous page
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(),
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
    );
  }

  void showPinInputDialog({
    required ApprovalActionType type,
    String idRealisasi = "-99",
    String noKasbon = "-99",
    String noRealisasi = "-99",
    String description = 'Masukkan PIN anda',
  }) {
    var pin = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            'Enter PIN',
            style: GoogleFonts.lato(),
          ),
          content: Column(
            children: [
              Text(description), // Added description here
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: CupertinoTextField(
                  key: _formKey2,
                  onChanged: (value) {
                    pin = value;
                  },
                  textAlign: TextAlign.start,
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  placeholder: 'PIN',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                if (_formKey2.currentState?.validate() ?? true) {
                  Navigator.of(context).pop();
                  var comment = this.messageController.text;
                  print("send with comment " + comment);

                  if (type == ApprovalActionType.APPROVE) {
                    realisasActionBloc.add(SendQRealisasiApprove(
                      pin: pin,
                      idRealisasi: idRealisasi,
                      noKasbon: noKasbon,
                      comment: this.messageController.text,
                      noRealisasi: widget.noRealisasi,
                    ));
                  }

                  if (type == ApprovalActionType.REJECT) {
                    realisasActionBloc.add(SendQRealisasiReject(
                      pin: pin,
                      idRealisasi: idRealisasi,
                      noKasbon: noKasbon,
                      comment: this.messageController.text,
                      noRealisasi: widget.noRealisasi,
                    ));
                  }

                  // Perform any desired operations with the entered PIN
                  // Here, we're just printing it for demonstration purposes
                  print('Entered PIN: $pin with navigator' +
                      this.messageController.text.toString());
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
