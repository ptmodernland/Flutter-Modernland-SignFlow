import 'package:bwa_cozy/bloc/notif/notif_bloc.dart';
import 'package:bwa_cozy/bloc/notif/notif_event.dart';
import 'package:bwa_cozy/bloc/notif/notif_state.dart';
import 'package:bwa_cozy/pages/approval/pbj/pbj_page.dart';
import 'package:bwa_cozy/pages/home/home_page.dart';
import 'package:bwa_cozy/pages/profile/profile_page.dart';
import 'package:bwa_cozy/repos/notif_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContainerHomePage extends StatefulWidget {
  const ContainerHomePage({Key? key}) : super(key: key);

  @override
  _ContainerHomePageState createState() => _ContainerHomePageState();
}

class _ContainerHomePageState extends State<ContainerHomePage>
    with WidgetsBindingObserver {
  int _selectedTab = 0;

  late NotifRepository notifRepository;
  late NotifCoreBloc notifBloc;

  List<Widget> _pages = [];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("resumed");
      setState(() {
        notifBloc.add(NotifEventCount());
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    notifRepository = NotifRepository();
    notifBloc = NotifCoreBloc(notifRepository);
    _pages = [
      Center(
        child: HomePage(notifBloc),
      ),
      Center(
        child: Text("IOM"),
      ),
      Center(
        child: ApprovalPBJMainPage(),
      ),
      Center(
        child: Text("Compare"),
      ),
      Center(
        child: Text("Kasbon"),
      ),
      Center(
        child: Text("Realisasi"),
      ),
      Center(
        child: ProfilePage(notifBloc: notifBloc,),
      ),
    ];
  }

  void _changeTab(int index) {
    setState(() {
      notifBloc..add(NotifEventCount());
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    @override
    void initState() {
      super.initState();
      notifBloc.add(NotifEventCount());
    }

    return BlocProvider(
      create: (BuildContext context) {
        return notifBloc..add(NotifEventCount());
      },
      child: Scaffold(
        // appBar: AppBar(),
        body: _pages[_selectedTab],
        bottomNavigationBar: buildBottomNavigationBar(notifBloc),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(NotifCoreBloc notifBloc) {
    NotifRepository notifRepository = NotifRepository();
    final notifBloc = NotifCoreBloc(notifRepository);

    return BottomNavigationBar(
      currentIndex: _selectedTab,
      onTap: _changeTab,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: BottomIconWithBadge(
            menuType: BottomMenuType.HOME,
            mNotifBloc: notifBloc,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: BottomIconWithBadge(
            menuType: BottomMenuType.IOM,
            mNotifBloc: notifBloc,
          ),
          label: 'IOM',
        ),
        BottomNavigationBarItem(
          icon: BottomIconWithBadge(
            menuType: BottomMenuType.PBJ,
            mNotifBloc: notifBloc,
          ),
          label: 'PBJ',
        ),
        BottomNavigationBarItem(
          icon: BottomIconWithBadge(
            menuType: BottomMenuType.COMPARE,
            mNotifBloc: notifBloc,
          ),
          label: 'Compare',
        ),
        BottomNavigationBarItem(
          icon: BottomIconWithBadge(
            menuType: BottomMenuType.KASBON,
            mNotifBloc: notifBloc,
          ),
          label: 'Kasbon',
        ),
        BottomNavigationBarItem(
          icon: BottomIconWithBadge(
            menuType: BottomMenuType.REALISASI,
            mNotifBloc: notifBloc,
          ),
          label: 'Realisasi',
        ),
        BottomNavigationBarItem(
          icon: BottomIconWithBadge(
            menuType: BottomMenuType.SETTINGS,
            mNotifBloc: notifBloc,
          ),
          label: 'Settings',
        ),
      ],
    );
  }
}

enum BottomMenuType {
  HOME,
  IOM,
  PBJ,
  REALISASI,
  KASBON,
  COMPARE,
  SETTINGS,
}

class BottomIconWithBadge extends StatefulWidget {
  final NotifCoreBloc mNotifBloc;
  final BottomMenuType menuType;

  const BottomIconWithBadge(
      {Key? key, required this.mNotifBloc, required this.menuType});

  @override
  State<BottomIconWithBadge> createState() => _BottomIconWithBadgeState();
}

class _BottomIconWithBadgeState extends State<BottomIconWithBadge> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotifCoreBloc, NotifCoreState>(
      builder: (context, state) {
        var count = "";
        var title = "Home";
        Widget textOnMenu = Container();
        BoxDecoration? badgeNotifDecoration = null;

        Widget icon = Icon(CupertinoIcons.alarm);
        if (widget.menuType == BottomMenuType.HOME) {
          title = "Comparison";
          icon = Icon(CupertinoIcons.home);
        }
        if (widget.menuType == BottomMenuType.IOM) {
          title = "IOM"; // Inter Office Message;
          icon = Icon(CupertinoIcons.doc_on_doc_fill);
        }
        if (widget.menuType == BottomMenuType.PBJ) {
          title = "Permohonan Barang Jasa";
          icon = Icon(CupertinoIcons.list_bullet);
        }
        if (widget.menuType == BottomMenuType.COMPARE) {
          title = "Comparison";
          icon = Icon(CupertinoIcons.shuffle_thick);
        }
        if (widget.menuType == BottomMenuType.KASBON) {
          title = "Kasbon";
          icon = Icon(CupertinoIcons.money_dollar_circle_fill);
        }
        if (widget.menuType == BottomMenuType.REALISASI) {
          title = "Realisasi";
          icon = Icon(CupertinoIcons.checkmark_circle_fill);
        }
        if (widget.menuType == BottomMenuType.SETTINGS) {
          title = "Settings";
          icon = Icon(CupertinoIcons.settings);
        }
        print(BottomMenuType.values.toString() + " " + count.toString());

        if (state is NotifStateInitial) {
          print("UI Notif Counter Initial");
        }

        if (state is NotifStateLoading) {
          print("UI Notif Counter Loading");
        }

        if (state is NotifStateFailure) {
          print("UI Notif Counter error " + state.error.toString());
        }

        if (state is NotifStateSuccess) {
          if (widget.menuType == BottomMenuType.HOME) {
            title = "Comparison";
            icon = Icon(CupertinoIcons.home);
          }
          if (widget.menuType == BottomMenuType.IOM) {
            count = state.totalIom;
          }
          if (widget.menuType == BottomMenuType.COMPARE) {
            count = state.totalCompare;
          }
          if (widget.menuType == BottomMenuType.PBJ) {
            count = state.totalPermohonan;
          }
          if (widget.menuType == BottomMenuType.KASBON) {
            count = state.totalKasbon;
          }
          if (widget.menuType == BottomMenuType.REALISASI) {
            count = state.totalRealisasi;
          }
          if (widget.menuType == BottomMenuType.SETTINGS) {
            title = "Settings";
            icon = Icon(CupertinoIcons.settings);
          }
          if (count == "" || count == "0") {
            badgeNotifDecoration = null;
          } else {
            badgeNotifDecoration = BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            );
            textOnMenu = Text(
              count,
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            );
          }
        }

        return Center(
          child: Stack(
            children: <Widget>[
              icon,
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: badgeNotifDecoration,
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: textOnMenu,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
