import 'package:bwa_cozy/bloc/notif/notif_bloc.dart';
import 'package:bwa_cozy/bloc/notif/notif_event.dart';
import 'package:bwa_cozy/bloc/notif/notif_state.dart';
import 'package:bwa_cozy/data/dio_client.dart';
import 'package:bwa_cozy/di/service_locator.dart';
import 'package:bwa_cozy/pages/home/home_page.dart';
import 'package:bwa_cozy/pages/profile/profile_page.dart';
import 'package:bwa_cozy/repos/notif_repository.dart';
import 'package:bwa_cozy/util/enum/menu_type.dart';
import 'package:bwa_cozy/widget/common/my_speed_dial_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContainerHomePage extends StatefulWidget {
  const ContainerHomePage({Key? key, this.isFromLogin = false})
      : super(key: key);

  final bool isFromLogin;

  @override
  _ContainerHomePageState createState() => _ContainerHomePageState();
}

class _ContainerHomePageState extends State<ContainerHomePage>
    with WidgetsBindingObserver {
  int _selectedTab = 0;
  var isDialogShown = false;

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
    notifRepository = NotifRepository(dioClient: getIt<DioClient>());
    notifBloc = NotifCoreBloc(notifRepository);

    _pages = [
      Center(
        child: HomePage(),
      ),
      Center(
        child: ProfilePage(
          notifBloc: notifBloc,
        ),
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
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(),
          body: _pages[_selectedTab],
          // bottomNavigationBar: buildBottomNavigationBar(notifBloc),
          floatingActionButton: _selectedTab ==
                  99 // Replace 2 with the index where you want to hide the FAB
              ? null
              : mySpeedDialWidget(),
        ),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(NotifCoreBloc notifBloc) {
    var notifRepository = NotifRepository(dioClient: getIt<DioClient>());
    final notifBloc = NotifCoreBloc(notifRepository);

    return BottomNavigationBar(
      currentIndex: _selectedTab,
      onTap: _changeTab,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: false,
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
            menuType: BottomMenuType.SETTINGS,
            mNotifBloc: notifBloc,
          ),
          label: 'Settings',
        ),
      ],
    );
  }
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
  int savedIconCounter = 0; // Variable to store the saved icon counter

  @override
  void initState() {
    super.initState();
    loadSavedIconCounter(); // Load the saved icon counter when the widget is initialized
  }

  // Function to save the icon counter to shared preferences
  Future<void> saveIconCounter(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(widget.menuType.toString(), count);
  }

  // Function to load the saved icon counter from shared preferences
  Future<void> loadSavedIconCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedIconCounter = prefs.getInt(widget.menuType.toString()) ?? 0;
    });
  }

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

        if (state is NotifStateInitial) {
          print("UI Notif Counter Initial");
        }

        if (state is NotifStateLoading) {
          print("UI Notif Counter Loading");
          // Display the saved icon counter
          count = savedIconCounter.toString();
        }

        if (state is NotifStateFailure) {
          print("UI Notif Counter error " + state.error.toString());

          // Display the saved icon counter
          count = savedIconCounter.toString();
        }

        if (state is NotifStateSuccess) {
          FlutterAppBadger.removeBadge();
          FlutterAppBadger.updateBadgeCount(999);

          if (widget.menuType == BottomMenuType.HOME) {
            title = "Comparison";
            icon = Icon(CupertinoIcons.home);
          }
          if (widget.menuType == BottomMenuType.IOM) {
            count = state.totalKoordinasiAndIom;
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
          // Save the icon counter to shared preferences
          saveIconCounter(int.tryParse(count) ?? 0);
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
