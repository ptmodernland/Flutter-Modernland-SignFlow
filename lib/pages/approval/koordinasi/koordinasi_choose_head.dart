import 'package:bwa_cozy/bloc/iom/approval_head_dept_cubit.dart';
import 'package:bwa_cozy/bloc/iom/approval_state.dart';
import 'package:bwa_cozy/repos/iom/approval_repository.dart';
import 'package:bwa_cozy/util/enum/action_type.dart';
import 'package:bwa_cozy/widget/approval/choose_dept_head_item.dart';
import 'package:bwa_cozy/widget/core/custom_text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
        body: ApprovalList(),
      ),
    );
  }
}

class ApprovalList extends StatefulWidget {
  const ApprovalList();

  @override
  State<ApprovalList> createState() => _ApprovalListState();
}

class _ApprovalListState extends State<ApprovalList> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ApprovalHeadDeptCubit>();
    cubit.fetchDeptHead(query: null);

    final formKey = GlobalKey<FormState>();
    final usernameController = TextEditingController();

    return Column(
      children: [
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
                            cubit.fetchDeptHead(query: usernameController.text);
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
        BlocBuilder<ApprovalHeadDeptCubit, ApprovalState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is ApprovalLoading) {
              return Center(child: CupertinoActivityIndicator());
            } else if (state is ApprovalEmpty) {
              return Center(child: Text('No approvals found.'));
            } else if (state is ApprovalDeptHeadSuccess) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.deptHeads.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = state.deptHeads[index];
                    return ChooseDeptHeadItem(
                      onClick: () {
                        showPinInputDialog(
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
    );
  }

  void showPinInputDialog({
    required ApprovalActionType type,
    String description = 'Masukkan PIN anda',
    required BuildContext mContext,
  }) {
    var pin = "";
    showDialog(
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
