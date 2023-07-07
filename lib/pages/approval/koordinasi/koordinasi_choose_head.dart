import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modernland_signflow/bloc/iom/approval_head_dept_cubit.dart';
import 'package:modernland_signflow/bloc/iom/approval_state.dart';
import 'package:modernland_signflow/bloc/iom/give_koordinasi_cubit.dart';
import 'package:modernland_signflow/repos/iom/approval_repository.dart';
import 'package:modernland_signflow/repos/rekomendasi/rekomendasi_repository.dart';
import 'package:modernland_signflow/util/enum/action_type.dart';
import 'package:modernland_signflow/widget/approval/choose_dept_head_item.dart';
import 'package:modernland_signflow/widget/core/blurred_dialog.dart';
import 'package:modernland_signflow/widget/core/custom_text_input.dart';
import 'package:quickalert/quickalert.dart';

class KoordinasiChooseHeadPage extends StatelessWidget {
  final String idIom;
  final String nomorIom;
  final String title;

  const KoordinasiChooseHeadPage(
      {required this.idIom, required this.nomorIom, this.title = ""});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApprovalHeadDeptCubit(ApprovalRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pilih Tujuan Rekomendasi"),
        ),
        body: ApprovalList(
          nomorIom: nomorIom,
          idIom: idIom,
        ),
      ),
    );
  }
}

class ApprovalList extends StatefulWidget {
  const ApprovalList({this.idIom = "", this.nomorIom = ""});

  final String idIom;
  final String nomorIom;

  @override
  State<ApprovalList> createState() => _ApprovalListState();
}

class _ApprovalListState extends State<ApprovalList> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final messageController = TextEditingController();
  late GiveKoordinasiCubit koordinasiActionCubit;
  late ApprovalHeadDeptCubit approvalHeadListCubit;

  @override
  void initState() {
    super.initState();
    koordinasiActionCubit = GiveKoordinasiCubit(RekomendasiRepository());
    approvalHeadListCubit = ApprovalHeadDeptCubit(ApprovalRepository());
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final usernameController = TextEditingController();

    return Stack(
      children: [
        Column(
          children: [
            BlocProvider<GiveKoordinasiCubit>(
              create: (context) => koordinasiActionCubit,
              // Replace with your actual cubit instantiation
              child: BlocListener<GiveKoordinasiCubit, ApprovalState>(
                listener: (context, state) {
                  // Navigate to next screen
                  if (state is ApprovalStateApproveSuccess) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      // Disable dismissing dialog by tapping outside
                      builder: (BuildContext context) {
                        var text = state.message;
                        return WillPopScope(
                          onWillPop: () async {
                            // Handback button press
                            return false; // Prevent dialog from being dismissed by back button
                          },
                          child: CupertinoAlertDialog(
                            title: Text(
                              'Success',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: Text(text),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                  Navigator.of(context)
                                      .pop(); // Go back to the previous page
                                  Navigator.of(context).pop(); //
                                },
                                child: Text('OK',
                                    style: TextStyle(color: Colors.blue)),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  if (state is ApprovalLoading) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }

                  if (state is ApprovalStateApproveError) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      text: state.message.toString(),
                    );
                  }
                },
                child: Container(),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextInput(
                          textEditController: usernameController,
                          hintTextString: 'Cari Nama',
                          inputType: InputType.Default,
                          enableBorder: true,
                          themeColor: Theme.of(context).primaryColor,
                          cornerRadius: 18.0,
                          textValidator: (value) {
                            return null;
                          },
                          maxLength: 900,
                          prefixIcon: Icon(Icons.search,
                              color: Theme.of(context).primaryColor),
                          textColor: Colors.black,
                          errorMessage: '',
                          labelText: 'Cari Berdasarkan Nama',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                approvalHeadListCubit.fetchDeptHead(
                                    query: usernameController.text);
                              }
                            },
                            child: Text("Cari")),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            // BlocProvider(
            //   create: (_) => streamCubit,
            //   child: Column(
            //     children: [
            //       BlocBuilder<StreamCubit, StreamState>(
            //         bloc: streamCubit..fetchStream(),
            //         builder: (context, state) {
            //           if (state is StreamStateLoading) {
            //             return Center(child: CupertinoActivityIndicator());
            //           } else if (state is StreamStateLoadSuccess) {
            //             print("success nieee" + state.datas.toString());
            //             return Container(
            //               height: 100,
            //               child: ListView.builder(
            //                 itemCount: state.datas.length,
            //                 scrollDirection: Axis.horizontal,
            //                 itemBuilder: (context, index) {
            //                   final item = state.datas[index];
            //                   return Text(item.title??"");
            //                 },
            //               ),
            //             );
            //           } else {
            //             return Text("Halo Gais");
            //           }
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            BlocBuilder<ApprovalHeadDeptCubit, ApprovalState>(
              bloc: approvalHeadListCubit..fetchDeptHead(),
              builder: (context, state) {
                if (state is ApprovalLoading) {
                  return Center(child: CupertinoActivityIndicator());
                } else if (state is ApprovalEmpty) {
                  return Center(child: Text('No approvals found.'));
                } else if (state is ApprovalDeptHeadSuccess) {
                  if (koordinasiActionCubit.state is ApprovalLoading) {
                    return Center(child: CupertinoActivityIndicator());
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.deptHeads.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = state.deptHeads[index];
                        return ChooseDeptHeadItem(
                          onClick: () {
                            showPinInputDialog(
                                username: item.username ?? "",
                                type: ApprovalActionType.RECOMMENDATION,
                                mContext: context,
                                description: "Anda yakin ingin"
                                        " mengajukan rekomendasi dengan tujuan ke :\n\nBapak/Ibu " +
                                    (item.namaUser ?? "") +
                                    "\n" +
                                    (item.email ?? ""));
                          },
                          userName: item.namaUser ?? "",
                          userDepartment: item.departemen ?? "",
                          userEmail: item.email ?? "",
                        );
                      },
                    ),
                  );
                } else if (state is ApprovalError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
        BlocBuilder<GiveKoordinasiCubit, ApprovalState>(
          bloc: koordinasiActionCubit,
          builder: (context, state) {
            if (state is ApprovalLoading) {
              return BlurredDialog(loadingText: "Mengirim Koordinasi");
            }
            return Container();
          },
        ),
      ],
    );
  }

  void showPinInputDialog(
      {required ApprovalActionType type,
      String description = 'Masukkan PIN anda',
      required BuildContext mContext,
      required String username}) {
    var pin = "";
    showDialog(
      barrierDismissible: false, // Disable dismissing dialog by tapping outside
      context: mContext,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            "Koordinasi Approval",
            style: GoogleFonts.poppins().copyWith(),
          ),
          content: Column(
            children: [
              Text(description), // Added description here
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            CupertinoDialogAction(
              onPressed: () {
                if (_formKey2.currentState?.validate() ?? true) {
                  Navigator.of(context).pop();
                  koordinasiActionCubit.giveRekomendasi(
                      noIom: widget.nomorIom,
                      idIom: widget.idIom,
                      headUsername: username,
                      pin: pin);
                }
              },
              child: Text('OK', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }
}
