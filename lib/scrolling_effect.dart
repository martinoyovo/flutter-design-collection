/*import 'package:flutter/material.dart';


class ScrollingEffect extends StatefulWidget {
  const ScrollingEffect({super.key});

  @override
  State<ScrollingEffect> createState() => _ScrollingEffectState();
}

class _ScrollingEffectState extends State<ScrollingEffect> {
  final bool _pinned = true;
  final bool _snap = false;
  final bool _floating = true;

// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              expandedHeight: 160.0,
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_transit)),
                ],
              ),
              flexibleSpace: const FlexibleSpaceBar(
                title: Text('SliverAppBar'),
                background: FlutterLogo(),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
                child: Center(
                  child: Text('Scroll to see the SliverAppBar in effect.'),
                ),
              ),
            ),
            Sliver(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 600),
                      child: Column(
                        children: [
                          // RoundedPicture(),
                          Icon(
                            Icons.favorite,
                            color: Colors.pink,
                            size: 150.0,
                            semanticLabel:
                            'Text to announce in accessibility modes',
                          ),
                          FittedBox(
                            child: Text("Hello World",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 40)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20),
                                    text: 'Info1:  ',
                                    children: [
                                      TextSpan(
                                        text: "123",
                                        style: TextStyle(),
                                      ),
                                    ]),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20),
                                    text: 'Info2:  ',
                                    children: [
                                      TextSpan(
                                        text: "abcd",
                                        style: TextStyle(),
                                      ),
                                    ]),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20),
                                    text: 'Info3:  ',
                                    children: [
                                      TextSpan(
                                        text: "xyz",
                                        style: TextStyle(),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 600),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 600),
                            child: Center(
                              child: Text("TITLE2"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    color: index.isOdd ? Colors.white : Colors.black12,
                    height: 100.0,
                    child: Center(
                      child: Text('$index', textScaleFactor: 5),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  double getHeight() {
    return 800;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder: (context, value) {
                  return [
                    SliverAppBar(
                      expandedHeight: 200.0,
                      flexibleSpace: FlexibleSpaceBar(),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        minHeight: 90,
                        maxHeight: 90,
                        child: Container(
                          height: getHeight() * (1 / 11),
                          width: double.infinity,
                          color: Colors.green[200],
                          child: Center(
                            child: Text(
                              "TEXT",
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        minHeight: 90,
                        maxHeight: 90,
                        child: Container(
                          color: Colors.green[200],
                          child: TabBar(
                            controller: _tabController,
                            tabs: [
                              Tab(
                                child: Text(
                                  'TITLE1',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'TITLE2',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'TITLE3',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 600),
                        child: Column(
                          children: [
                            // RoundedPicture(),
                            Icon(
                              Icons.favorite,
                              color: Colors.pink,
                              size: 150.0,
                              semanticLabel:
                              'Text to announce in accessibility modes',
                            ),
                            FittedBox(
                              child: Text("Hello World",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 40)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20),
                                      text: 'Info1:  ',
                                      children: [
                                        TextSpan(
                                          text: "123",
                                          style: TextStyle(),
                                        ),
                                      ]),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20),
                                      text: 'Info2:  ',
                                      children: [
                                        TextSpan(
                                          text: "abcd",
                                          style: TextStyle(),
                                        ),
                                      ]),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20),
                                      text: 'Info3:  ',
                                      children: [
                                        TextSpan(
                                          text: "xyz",
                                          style: TextStyle(),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 600),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 600),
                              child: Center(
                                child: Text("TITLE2"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 600),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 600),
                              child: Center(
                                child: Text("TITLE3"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 90,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                onTap: () {},
                child: Icon(Icons.arrow_back),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}*/