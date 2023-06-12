import 'package:bwa_cozy/bloc/all_approval/approval_main_page_bloc.dart';
import 'package:bwa_cozy/bloc/all_approval/approval_main_page_event.dart';
import 'package:bwa_cozy/bloc/all_approval/approval_main_page_state.dart';
import 'package:bwa_cozy/bloc/pbj/pbj_comment_bloc.dart';
import 'package:bwa_cozy/bloc/pbj/pbj_comment_event.dart';
import 'package:bwa_cozy/bloc/pbj/pbj_event.dart';
import 'package:bwa_cozy/bloc/pbj/pbj_main_bloc.dart';
import 'package:bwa_cozy/bloc/pbj/pbj_state.dart';
import 'package:bwa_cozy/repos/approval_main_page_repository.dart';
import 'package:bwa_cozy/repos/notif_repository.dart';
import 'package:bwa_cozy/repos/pbj_repository.dart';
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

class DetailPBJPage extends StatefulWidget {
  const DetailPBJPage(
      {Key? key, required this.noPermintaan, this.isFromHistory = false})
      : super(key: key);
  final String noPermintaan;
  final bool isFromHistory;

  @override
  State<DetailPBJPage> createState() => _DetailPBJPageState();
}

class _DetailPBJPageState extends State<DetailPBJPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final messageController = TextEditingController();

  late NotifRepository notifRepository;
  late ApprovalMainPageRepository approvalRepo;
  late ApprovalMainPageBloc approvalBloc;

  late PBJRepository pbjRepo;
  late PBJBloc pbjBloc;
  late PBJCommentBloc pbjCommentBloc;

  @override
  void initState() {
    super.initState();
    approvalRepo = ApprovalMainPageRepository();
    approvalBloc = ApprovalMainPageBloc(approvalRepo);
    pbjRepo = PBJRepository();
    pbjBloc = PBJBloc(pbjRepo);
    pbjCommentBloc = PBJCommentBloc(pbjRepo);
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
                                              "Detail PBJ " +
                                                  widget.noPermintaan,
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
                                                widget.noPermintaan,
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
                          return approvalBloc
                            ..add(RequestPBJDetailEvent(widget.noPermintaan));
                        },
                        child: BlocBuilder<ApprovalMainPageBloc,
                            ApprovalMainPageState>(
                          builder: (context, state) {
                            var status = "";
                            Widget dataList = Text("");
                            if (state is ApprovalMainPageStateLoading) {}
                            if (state is ApprovalMainPageStateFailure) {}

                            if (state is ApprovalDetailPBJSuccess) {
                              var data = state.data;

                              var isApproved = false;
                              if (data.status != "Y") {
                                isApproved = true;
                              }
                              return Container(
                                child: Column(
                                  children: [
                                    ItemApprovalWidget(
                                      requiredId: data.noPermintaan,
                                      isApproved: isApproved,
                                      itemCode: data.noPermintaan,
                                      date: data.tglPermintaan,
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
                                          SizedBox(
                                            height: 20,
                                          ),
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
                                                  title: "Nomor Permintaan",
                                                  content: data.noPermintaan,
                                                ),
                                              ),
                                              Expanded(
                                                child: DocumentDetailWidget(
                                                  title: "Tanggal",
                                                  content: data.noPermintaan,
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
                                                title: "View Detail",
                                                content: "Klik Disini",
                                                fileURL: DOC_VIEW_PBJ +
                                                    data.noPermintaan
                                                        .toString(),
                                              )),
                                              Expanded(
                                                child: DocumentDetailWidget(
                                                  title: "Download File",
                                                  content: data.attchFile,
                                                  isForDownload: true,
                                                  fileURL: ATTACH_DOWNLOAD_PBJ +
                                                      data.attchFile.toString(),
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
                                                    textEditController: messageController,
                                                    hintTextString: 'Isi Tanggapan',
                                                    inputType: InputType
                                                        .Default,
                                                    enableBorder: true,
                                                    minLines: 3,
                                                    themeColor: Theme
                                                        .of(context)
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
                                                    errorMessage: 'Username cant be empty',
                                                    labelText: 'Tanggapan/Komentar/Review',
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
                          return pbjCommentBloc
                            ..add(GetKomentarPBJ(
                                noPermintaan: widget.noPermintaan));
                        },
                        child: Column(
                          children: [
                            BlocBuilder<PBJCommentBloc, PBJState>(
                              builder: (context, state) {
                                if (state is PBJStateLoadKomentarSuccess) {
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
                                  return Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        emptyState,
                                        commentListViewBuilder,
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
                          return pbjBloc;
                        },
                        child: Column(
                          children: [
                            BlocListener<PBJBloc, PBJState>(
                              listener: (context, state) {
                                if (state is PBJStateFailure) {
                                  if (state.type ==
                                          PBJEStateActionType.APPROVE ||
                                      state.type ==
                                          PBJEStateActionType.REJECT) {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      text: state.message.toString(),
                                    );
                                  }
                                }

                                if (state is PBJStateSuccess) {
                                  if (state.type ==
                                          PBJEStateActionType.APPROVE ||
                                      state.type ==
                                          PBJEStateActionType.REJECT) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        var text = "";
                                        if (state.type ==
                                            PBJEStateActionType.APPROVE) {
                                          text = "Request Berhasil Diapprove";
                                        }
                                        if (state.type ==
                                            PBJEStateActionType.REJECT) {
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
                            BlocBuilder<PBJBloc, PBJState>(
                              builder: (context, state) {
                                var status = "";
                                if (state is PBJStateInitial) {}
                                if (state is PBJStateLoading) {
                                  bool isCorrectState = (state.type ==
                                          PBJEStateActionType.APPROVE ||
                                      state.type == PBJEStateActionType.REJECT);
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
                    pbjBloc.add(SendQPBJApprove(
                      pin: pin,
                      comment: this.messageController.text,
                      noPermintaan: widget.noPermintaan,
                    ));
                  }

                  if (type == ApprovalActionType.REJECT) {
                    pbjBloc.add(SendQPBJReject(
                      pin: pin,
                      comment: this.messageController.text,
                      noPermintaan: widget.noPermintaan,
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
