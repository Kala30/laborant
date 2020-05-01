import 'package:laborant/agents_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'news_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laborant',
      theme: ThemeData(
        fontFamily: 'DINNext',
        primaryColor: Colors.white,
        primaryColorDark: Colors.white70,
        accentColor: Color(0xffff4655),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        fontFamily: 'DINNext',
        brightness: Brightness.dark,
        accentColor: Color(0xffff4655),
      ),
      home: HomePage(),
    );
  }

}


class HomePage extends StatefulWidget {

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  BuildContext _appContext;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _appContext = context;
    _setSystemTheme();

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          NewsPage(),
          AgentsPage(),
          AgentsPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('HOME'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_circle),
            title: new Text('STATS'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(CupertinoIcons.group_solid),
            title: new Text('AGENTS'),
          )
        ],
        selectedItemColor: Theme.of(context).accentColor,
        //backgroundColor: Theme.of(context).cardColor,

      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _setSystemTheme();
    }
  }

  void _setSystemTheme() {
    if (MediaQuery.of(_appContext).platformBrightness == Brightness.dark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Color(0),
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Color(0),
          systemNavigationBarColor: Colors.grey[200],
          systemNavigationBarIconBrightness: Brightness.dark
      ));
    }
  }

}
