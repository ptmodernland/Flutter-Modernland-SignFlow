import 'package:bwa_cozy/bloc/compare/compare_action_bloc.dart';
import 'package:bwa_cozy/bloc/compare/compare_action_event.dart';
import 'package:bwa_cozy/bloc/compare/compare_bloc.dart';
import 'package:bwa_cozy/bloc/compare/compare_comment_bloc.dart';
import 'package:bwa_cozy/bloc/compare/compare_comment_event.dart';
import 'package:bwa_cozy/bloc/compare/compare_event.dart';
import 'package:bwa_cozy/bloc/compare/compare_state.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_action_bloc.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_action_event.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_bloc.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_comment_bloc.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_comment_event.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_event.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_state.dart';
import 'package:bwa_cozy/repos/compare_repository.dart';
import 'package:bwa_cozy/repos/kasbon_repository.dart';
import 'package:bwa_cozy/util/core/string/html_util.dart';
import 'package:bwa_cozy/util/core/url/base_url.dart';
import 'package:bwa_cozy/util/enum/action_type.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/widget/approval/document_detail_widget.dart';
import 'package:bwa_cozy/widget/approval/item_approval_widget.dart';
import 'package:bwa_cozy/widget/common/user_comment_widget.dart';
import 'package:bwa_cozy/widget/core/custom_text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';

class KasbonDetailPage extends StatefulWidget {
  const KasbonDetailPage(
      {Key? key,
      required this.idKasbon,
      required this.noKasbon,
      this.isFromHistory = false})
      : super(key: key);

  final String idKasbon;
  final String noKasbon;
  final bool isFromHistory;

  @override
  State<KasbonDetailPage> createState() => _KasbonDetailPageState();
}

class _KasbonDetailPageState extends State<KasbonDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final messageController = TextEditingController();

  late KasbonRepository kasbonRepository;
  late KasbonBloc kasbonBloc;
  late KasbonCommentBloc kasbonCommentBloc;
  late KasbonActionBloc kasbonActionBloc;

  @override
  void initState() {
    super.initState();
    kasbonRepository = KasbonRepository();
    kasbonBloc = KasbonBloc(kasbonRepository);
    kasbonCommentBloc = KasbonCommentBloc(kasbonRepository);
    kasbonActionBloc = KasbonActionBloc(kasbonRepository);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
                                              "Detail Kasbon " +
                                                  widget.noKasbon,
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
                              margin:
                                  EdgeInsets.only(top: 20, left: 0, right: 0),
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
                                                widget.noKasbon,
                                            textAlign: TextAlign.start,
                                            style: MyTheme
                                                .myStylePrimaryTextStyle
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
                          return kasbonBloc
                            ..add(GetKasbonDetailEvent(
                                idCompare: widget.noKasbon.toString()));
                        },
                        child: BlocBuilder<KasbonBloc, KasbonState>(
                          builder: (context, state) {
                            var status = "";
                            Widget dataList = Text("");
                            if (state is KasbonStateLoading) {}
                            if (state is KasbonStateFailure) {
                              if (state.type ==
                                  CompareEActionType.LOAD_DETAIL) {
                                return Text("Error " + state.message);
                              }
                            }
                            if (state is KasbonDetailSuccess) {
                              var data = state.data;

                              var isApproved = false;
                              if (data.status != "Y") {
                                isApproved = true;
                              }
                              return Container(
                                child: Column(
                                  children: [
                                    ItemApprovalWidget(
                                      isApproved: isApproved,
                                      itemCode: data.noKasbon,
                                      date: data.tglKasbon,
                                      personName: data.namaUser,
                                      descriptiveText:
                                          removeHtmlTags(data.keterangan ?? ""),
                                      departmentTitle: data.departemen,
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
                                            style: MyTheme
                                                .myStylePrimaryTextStyle
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
                                                  title: "Nomor Kasbon",
                                                  content: data.noKasbon ?? "",
                                                ),
                                              ),
                                              Expanded(
                                                child: DocumentDetailWidget(
                                                  title: "Tanggal",
                                                  content:
                                                      data.tglKasbon ?? "-",
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
                                                content: data.namaUser ??
                                                    "MDLN Staff",
                                              )),
                                              Expanded(
                                                child: DocumentDetailWidget(
                                                  title: "Department",
                                                  content: data.departemen ??
                                                      "Modernland",
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
                                                  title: "Jumlah Kasbon",
                                                  content:
                                                      data.jumlah.toString(),
                                                ),
                                              ),
                                              Expanded(
                                                child: DocumentDetailWidget(
                                                  title: "Keterangan",
                                                  content: data.keterangan
                                                      .toString(),
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
                                                fileURL: DOC_VIEW_KASBON +
                                                    (widget.idKasbon ?? ""),
                                              )),
                                              Expanded(
                                                child: DocumentDetailWidget(
                                                  title: "Download File",
                                                  content: data.attchFile ?? "",
                                                  isForDownload: true,
                                                  fileURL:
                                                      ATTACH_DOWNLOAD_KASBON +
                                                          data.attchFile
                                                              .toString(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          if (widget.isFromHistory == false)
                                            Text(
                                              "Komentar",
                                              textAlign: TextAlign.start,
                                              style: MyTheme
                                                  .myStylePrimaryTextStyle
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
                                                    inputType:
                                                        InputType.Default,
                                                    enableBorder: true,
                                                    minLines: 3,
                                                    themeColor:
                                                        Theme.of(context)
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
                      //Load Comment Bloc Provider
                      BlocProvider(
                        create: (BuildContext context) {
                          return kasbonCommentBloc
                            ..add(GetKomentarKasbon(noKasbon: widget.noKasbon));
                        },
                        child: Column(
                          children: [
                            BlocListener<KasbonCommentBloc, KasbonState>(
                              listener: (context, state) {
                                if (state is KasbonStateFailure) {
                                  if (state.type ==
                                      KasbonEActionType.SHOW_KOMENTAR) {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      text: state.message.toString(),
                                    );
                                  }
                                }
                              },
                              child: Container(),
                            ),
                            BlocBuilder<KasbonCommentBloc, KasbonState>(
                              builder: (context, state) {
                                if (state is KasbonStateLoadCommentSuccess) {
                                  var commentList = state.datas;
                                  var commentListViewBuilder = ListView.builder(
                                    itemCount: commentList.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final pbjItem = commentList[index];
                                      var isApproved = false;
                                      if (pbjItem.status != "Y") {
                                        isApproved = true;
                                      }
                                      return UserCommentWidget(
                                        comment: pbjItem.komen ?? "",
                                        userName: pbjItem.approve ?? "",
                                        postingDate: pbjItem.tgl ?? "",
                                        bottomText: "Status : " +
                                            (pbjItem.statusApprove ?? ""),
                                      );
                                    },
                                  );
                                  var emptyState = Container();
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
                          return kasbonBloc;
                        },
                        child: Column(
                          children: [
                            BlocBuilder<KasbonBloc, KasbonState>(
                              builder: (context, state) {
                                var status = "";
                                if (state is KasbonStateInitial) {}
                                if (state is KasbonStateLoading) {
                                  bool isCorrectState = (state.type ==
                                          KasbonEActionType.APPROVE ||
                                      state.type == KasbonEActionType.REJECT);
                                  if (isCorrectState) {
                                    return Center(
                                      child: CupertinoActivityIndicator(),
                                    );
                                  }
                                }
                                //the button only shown if this page opened not from history
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
                                                type: KasbonEActionType.APPROVE,
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
                                                type: KasbonEActionType.REJECT,
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

                                return Container();
                              },
                            ),
                          ],
                        ),
                      ),
                      BlocProvider(
                        create: (BuildContext context) {
                          return kasbonActionBloc;
                        },
                        child: Column(
                          children: [
                            BlocListener<KasbonActionBloc, KasbonState>(
                              listener: (context, state) {
                                if (state is KasbonStateFailure) {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    text: state.message.toString(),
                                  );
                                }

                                if (state is KasbonStateSuccess) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      var text = "";
                                      if (state.type ==
                                          KasbonEActionType.APPROVE) {
                                        text = "Request Berhasil Diapprove";
                                      }
                                      if (state.type ==
                                          KasbonEActionType.REJECT) {
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
      ),
    );
  }

  void showPinInputDialog(
      {required KasbonEActionType type,
      String description = 'Masukkan PIN anda'}) {
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

                  if (type == KasbonEActionType.APPROVE) {
                    kasbonActionBloc.add(SendApprove(
                      pin: pin,
                      comment: this.messageController.text,
                      noKasbon: widget.noKasbon,
                    ));
                    print("no request approve is : " + widget.noKasbon);
                  }

                  if (type == KasbonEActionType.REJECT) {
                    kasbonActionBloc.add(SendReject(
                      pin: pin,
                      comment: this.messageController.text,
                      noKasbon: widget.noKasbon,
                    ));

                    print("no request reject is : " + widget.noKasbon);
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
