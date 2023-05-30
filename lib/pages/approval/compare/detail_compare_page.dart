import 'package:bwa_cozy/bloc/compare/compare_action_bloc.dart';
import 'package:bwa_cozy/bloc/compare/compare_action_event.dart';
import 'package:bwa_cozy/bloc/compare/compare_bloc.dart';
import 'package:bwa_cozy/bloc/compare/compare_comment_bloc.dart';
import 'package:bwa_cozy/bloc/compare/compare_comment_event.dart';
import 'package:bwa_cozy/bloc/compare/compare_event.dart';
import 'package:bwa_cozy/bloc/compare/compare_state.dart';
import 'package:bwa_cozy/repos/compare_repository.dart';
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

class DetailComparePage extends StatefulWidget {
  const DetailComparePage(
      {Key? key,
      required this.idCompare,
      required this.noCompare,
      this.isFromHistory = false})
      : super(key: key);

  final String idCompare;
  final String noCompare;
  final bool isFromHistory;

  @override
  State<DetailComparePage> createState() => _DetailComparePageState();
}

class _DetailComparePageState extends State<DetailComparePage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final messageController = TextEditingController();

  late CompareRepository compareRepo;
  late CompareBloc compareBloc;
  late CompareCommentBloc compareCommentBloc;
  late CompareActionBloc compareActionBloc;

  @override
  void initState() {
    super.initState();
    compareRepo = CompareRepository();
    compareBloc = CompareBloc(compareRepo);
    compareCommentBloc = CompareCommentBloc(compareRepo);
    compareActionBloc = CompareActionBloc(compareRepo);
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
                                              "Detail Compare " +
                                                  widget.idCompare,
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
                                                widget.idCompare,
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
                          return compareBloc
                            ..add(GetCompareDetailEvent(
                                idCompare: widget.idCompare.toString()));
                        },
                        child: BlocBuilder<CompareBloc, CompareState>(
                          builder: (context, state) {
                            var status = "";
                            Widget dataList = Text("");
                            if (state is CompareStateLoading) {}
                            if (state is CompareStateFailure) {
                              if (state.type ==
                                  CompareEActionType.LOAD_DETAIL) {
                                return Text("Error " + state.message);
                              }
                            }

                            if (state is CompareDetailSuccess) {
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
                                      itemCode: data.noCompare,
                                      date: data.compare_date,
                                      personName: data.namaUser,
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
                                                  title: "Nomor Compare",
                                                  content: data.noCompare,
                                                ),
                                              ),
                                              Expanded(
                                                child: DocumentDetailWidget(
                                                  title: "Tanggal",
                                                  content: data.compare_date,
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
                                                content: data.namaUser,
                                              )),
                                              Expanded(
                                                child: DocumentDetailWidget(
                                                  title: "Department",
                                                  content: data.departemen,
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
                                                  title: "Advance Payment",
                                                  content: data.advancePayment
                                                          .isNotEmpty
                                                      ? data.advancePayment
                                                      : "-",
                                                ),
                                              ),
                                              Expanded(
                                                child: DocumentDetailWidget(
                                                  title: "Progress Payment",
                                                  content: data.progressPayment
                                                          .isNotEmpty
                                                      ? data.progressPayment
                                                      : "-",
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
                                                fileURL: DOC_VIEW_COMPARE +
                                                    data.idCompare,
                                              )),
                                              Expanded(
                                                child: DocumentDetailWidget(
                                                  title: "Download File",
                                                  content: data.attchFile,
                                                  isForDownload: true,
                                                  fileURL:
                                                      ATTACH_DOWNLOAD_COMPARE +
                                                          data.attchFile
                                                              .toString(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (data.noRef != null)
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: DocumentDetailWidget(
                                                    title: "Nomor Ref",
                                                    content: data.noRef ?? "-",
                                                    isForDownload: false,
                                                    fileURL:
                                                        DOC_VIEW_COMPARE_GABUNGAN +
                                                            data.noRef
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
                                                  title: "Deskripsi : ",
                                                  content: data.desc_compare
                                                          .isNotEmpty
                                                      ? data.desc_compare
                                                      : "-",
                                                  isForDownload: false,
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
                          return compareCommentBloc
                            ..add(GetKomentarCompare(
                                noCompare: widget.noCompare));
                        },
                        child: Column(
                          children: [
                            BlocListener<CompareCommentBloc, CompareState>(
                              listener: (context, state) {
                                if (state is CompareStateFailure) {
                                  if (state.type ==
                                      CompareEActionType.SHOW_KOMENTAR) {
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
                            BlocBuilder<CompareCommentBloc, CompareState>(
                              builder: (context, state) {
                                if (state is CompareStateLoadCommentSuccess) {
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
                                        comment: pbjItem.komentar,
                                        userName: pbjItem.approve,
                                        postingDate: pbjItem.tglPermintaan,
                                        bottomText:
                                            "Status : " + pbjItem.statusApprove,
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
                          return compareBloc;
                        },
                        child: Column(
                          children: [
                            BlocBuilder<CompareBloc, CompareState>(
                              builder: (context, state) {
                                var status = "";
                                if (state is CompareStateInitial) {}
                                if (state is CompareStateLoading) {
                                  bool isCorrectState = (state.type ==
                                          CompareEActionType.APPROVE ||
                                      state.type == CompareEActionType.REJECT);
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
                          return compareActionBloc;
                        },
                        child: Column(
                          children: [
                            BlocListener<CompareActionBloc, CompareState>(
                              listener: (context, state) {
                                if (state is CompareStateFailure) {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    text: state.message.toString(),
                                  );
                                }

                                if (state is CompareStateSuccess) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      var text = "";
                                      if (state.type ==
                                          CompareEActionType.APPROVE) {
                                        text = "Request Berhasil Diapprove";
                                      }
                                      if (state.type ==
                                          CompareEActionType.REJECT) {
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
      {required ApprovalActionType type,
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

                  if (type == ApprovalActionType.APPROVE) {
                    compareActionBloc.add(SendQCompareApprove(
                      pin: pin,
                      comment: this.messageController.text,
                      noPermintaan: widget.noCompare,
                    ));
                    print("no request approve is : " + widget.noCompare);
                  }

                  if (type == ApprovalActionType.REJECT) {
                    compareActionBloc.add(SendQCompareReject(
                      pin: pin,
                      comment: this.messageController.text,
                      nomorCompare: widget.noCompare,
                    ));

                    print("no request reject is : " + widget.noCompare);
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
