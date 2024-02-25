import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/aboutus/aboutus.dart';
import 'package:innwa_mobile_dev/screen/article/article.dart';
import 'package:innwa_mobile_dev/screen/home/home.dart';
import 'package:innwa_mobile_dev/screen/products/products.dart';
import 'package:innwa_mobile_dev/screen/promotion/promotion.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/drawer/filter_drawer.dart';
import 'package:innwa_mobile_dev/shared/search_bar/search_bar.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Innwa IT & Mobile',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Locale _locale;

  int _counter = 0;
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  static const List<Widget> _pages = <Widget>[
    Home(),
    Promotion(),
    Products(),
    Article(),
    AboutUs()
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return GestureDetector(
      onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                       
                      if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                        currentFocus.unfocus();
                      }
              },
      child: Container(
        color: backgroundColorLight,
        child: SafeArea(
          child: Scaffold(
              appBar: TopBar(needBackButton: false,needMenu: true,),
              key: _scaffoldKey,
              resizeToAvoidBottomInset: false,
              drawer: CustomDrawerWidget(
                onDrawerTap: () {},
              ),
              endDrawer: FilterDrawer(),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: backgroundColorLight,
                currentIndex: _selectedIndex,
                selectedFontSize: 10.0,
                unselectedFontSize: 10.0,
                elevation: 0.0,
                selectedItemColor: selectedItemColor,
                unselectedItemColor: unSelectedItemColor,
                selectedLabelStyle: TextStyle(color: selectedItemColor),
                unselectedLabelStyle: TextStyle(color: unSelectedItemColor),
                showUnselectedLabels: true,
                onTap: _onItemTapped,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.discount),
                    label: 'Promotion',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: 'Products',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.lightbulb_outlined),
                    label: 'Articles',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.info),
                    label: 'About',
                  ),
                ],
              ),
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Wrap(
                  
                  children: [CustomSearchBar(), _pages.elementAt(_selectedIndex)],
                ),
              )),
        ),
      ),
    );
  }
}
