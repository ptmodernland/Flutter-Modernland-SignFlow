import 'package:bwa_cozy/bloc/compare/compare_action_bloc.dart';
import 'package:bwa_cozy/bloc/compare/compare_action_event.dart';
import 'package:bwa_cozy/bloc/compare/compare_bloc.dart';
import 'package:bwa_cozy/bloc/compare/compare_comment_bloc.dart';
import 'package:bwa_cozy/bloc/compare/compare_comment_event.dart';
import 'package:bwa_cozy/bloc/compare/compare_event.dart';
import 'package:bwa_cozy/bloc/compare/compare_state.dart';
import 'package:bwa_cozy/bloc/iom/approval_detail_cubit.dart';
import 'package:bwa_cozy/bloc/iom/approval_state.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_action_bloc.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_action_event.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_bloc.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_comment_bloc.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_comment_event.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_event.dart';
import 'package:bwa_cozy/bloc/kasbon/kasbon_state.dart';
import 'package:bwa_cozy/repos/compare_repository.dart';
import 'package:bwa_cozy/repos/iom/approval_repository.dart';
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

class IomDetailPage extends StatefulWidget {
  const IomDetailPage(
      {Key? key,
      required this.idIom,
      required this.noIom,
      this.isFromHistory = false})
      : super(key: key);

  final String idIom;
  final String noIom;
  final bool isFromHistory;

  @override
  State<IomDetailPage> createState() => _IomDetailPageState();
}

class _IomDetailPageState extends State<IomDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final messageController = TextEditingController();

  late KasbonBloc kasbonBloc;
  late KasbonCommentBloc kasbonCommentBloc;
  late KasbonActionBloc kasbonActionBloc;
  late ApprovalDetailCubit iomDetailCubit;

  @override
  void initState() {
    super.initState();
    var kasbonRepository = KasbonRepository();
    kasbonBloc = KasbonBloc(kasbonRepository);
    kasbonCommentBloc = KasbonCommentBloc(kasbonRepository);
    kasbonActionBloc = KasbonActionBloc(kasbonRepository);

    iomDetailCubit = ApprovalDetailCubit(ApprovalRepository());
    iomDetailCubit.fetchApprovals(widget.idIom);
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
                                              widget.noIom,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: MyTheme
                                                  .myStylePrimaryTextStyle
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
                                  children: [],
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
                                idCompare: widget.noIom.toString()));
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
                                                fileURL: DOC_VIEW_IOM +
                                                    (widget.idIom ?? ""),
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
                      BlocBuilder<ApprovalDetailCubit, ApprovalState>(
                        bloc: iomDetailCubit..fetchApprovals(widget.idIom),
                        builder: (context, state) {
                          if (state is ApprovalDetailLoading) {
                            return Text("Loading");
                          }
                          if (state is ApprovalDetailError) {
                            return Text("Success : " + state.message);
                          }
                          if (state is ApprovalDetailSuccess) {
                            var data = state.detailData;

                            var isApproved = false;
                            if (data.status != "Y" && data.status != "T") {
                              isApproved = true;
                            }
                            return Container(
                              child: Column(
                                children: [
                                  ItemApprovalWidget(
                                    isApproved: isApproved,
                                    itemCode: data.nomor,
                                    date: data.tanggal,
                                    personName: data.dari,
                                    descriptiveText:
                                        removeHtmlTags(data.perihal ?? ""),
                                    departmentTitle: data.jenis,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0, top: 20.0),
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
                                                title: "Nomor IOM",
                                                content: data.nomor ?? "",
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: DocumentDetailWidget(
                                                title: "Nomor IOM",
                                                content: data.nomor ?? "",
                                              ),
                                            ),
                                            Expanded(
                                              child: DocumentDetailWidget(
                                                title: "Tanggal",
                                                content: data.tanggal ?? "-",
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
                                              content:
                                                  data.namaUser ?? "MDLN Staff",
                                            )),
                                            Expanded(
                                              child: DocumentDetailWidget(
                                                title: "Department",
                                                content: data.tanggal ??
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
                                                content: data.dari.toString(),
                                              ),
                                            ),
                                            Expanded(
                                              child: DocumentDetailWidget(
                                                title: "Keterangan",
                                                content: data.cc.toString(),
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
                                              fileURL: DOC_VIEW_IOM +
                                                  (widget.idIom ?? ""),
                                            )),
                                            Expanded(
                                              child: DocumentDetailWidget(
                                                title: "Download File",
                                                content:
                                                    data.attchLampiran ?? "",
                                                isForDownload: true,
                                                fileURL:
                                                    ATTACH_DOWNLOAD_KASBON +
                                                        data.attchLampiran
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
                          return Text("Kenapa Ini");
                        },
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
                      noKasbon: widget.noIom,
                    ));
                    print("no request approve is : " + widget.noIom);
                  }

                  if (type == KasbonEActionType.REJECT) {
                    kasbonActionBloc.add(SendReject(
                      pin: pin,
                      comment: this.messageController.text,
                      noKasbon: widget.noIom,
                    ));

                    print("no request reject is : " + widget.noIom);
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
