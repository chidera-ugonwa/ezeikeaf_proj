import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activePage = 0;

  Future getListings() async {
    final db = FirebaseFirestore.instance;
    final projects = db.collection('projects');
    var check = projects
        .where('year', isEqualTo: '2023')
        .where("status", isEqualTo: 'active')
        .snapshots();
    Future<bool> checks = check.isEmpty;
    debugPrint(checks.toString());
  }

  @override
  void initState() {
    getListings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
            itemCount: 3,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, childAspectRatio: 1.75),
            itemBuilder: (context, index) {
              return GridTile(
                header: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'ezikeaf',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                footer: const Text('Title'),
                child: Stack(fit: StackFit.expand, children: [
                  Positioned(
                    child: CarouselSlider.builder(
                      options: CarouselOptions(
                        onPageChanged: (val, _) {
                          setState(() {
                            activePage = val;
                          });
                        },
                        aspectRatio: 1,
                        viewportFraction: 1,
                        enableInfiniteScroll: true,
                      ),
                      itemCount: 5,
                      itemBuilder: (context, itemIndex, realIndex) {
                        return Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('image1.jpg'))),
                        );
                      },
                    ),
                  ),
                  Positioned(
                      top: 200,
                      bottom: 200,
                      right: 200,
                      left: 200,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Title of the Project',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24)),
                          const Text('Location of the Project',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          OutlinedButton(
                              onPressed: () {}, child: const Text('Learn More'))
                        ],
                      )))
                ]),
              );
            }));
  }
}
