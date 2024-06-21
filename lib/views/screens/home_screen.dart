import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        //! Columnni ichida CustomScrollView ni ishlatish uchun uni Extended() bn o'rash kk!!!
        slivers: <Widget>[
          const SliverAppBar(
            title: Text("Sliver App Bar"),
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Dynamic Toolbar"),
            ),
            expandedHeight: 200,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListTile(
                title: Text("List Item $index"),
              );
            },
            childCount: 40,
          )),
          SliverPersistentHeader(
              pinned: false,
              delegate: _SliverAppBarDelegate(
                  minHeight: 60,
                  maxHeight: 200,
                  child: Container(
                    color: Colors.green,
                    child: const Center(
                      child: Text("SliverPersistantHeader 3"),
                    ),
                  ))),
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 4)],
                    child: Text("grid item $index"),
                  );
                },
                childCount: 20,
              ),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0)),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              //! Oddiy widget qo'shish uchun kk boladi aks xolda error beradi
              child: SizedBox(
                height: 200.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemExtent: 160,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        // margin: EdgeInsets.all(10),
                        color: Colors.teal[100 * (index % 9)],
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Widget child;
  _SliverAppBarDelegate(
      {required this.maxHeight, required this.minHeight, required this.child});

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }
}
