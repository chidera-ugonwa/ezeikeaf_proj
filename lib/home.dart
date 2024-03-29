import 'package:carousel_slider/carousel_slider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ezeikeaf_proj/top_modal.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activePage = 0;
  bool isFiltered = false;
  List projectTypology = [];
  List status = [];
  List year = [];

  Stream<QuerySnapshot> getListings() {
    if (!isFiltered) {
      setState(() {});
      final db = FirebaseFirestore.instance;
      final projects = db.collection('projects');

      return projects.snapshots();
    } else {
      if (projectTypology.isNotEmpty && status.isNotEmpty && year.isNotEmpty) {
        debugPrint('one');
        final db = FirebaseFirestore.instance;
        final projects = db.collection('projects').where(Filter.and(
            Filter(
              'project typology',
              whereIn: projectTypology,
            ),
            Filter('status', whereIn: status),
            Filter('year', whereIn: year)));
        debugPrint(projectTypology.toString());
        return projects.snapshots();
      }
      if (projectTypology.isNotEmpty && status.isNotEmpty) {
        debugPrint('two');
        final db = FirebaseFirestore.instance;
        final projects = db.collection('projects').where(Filter.and(
            Filter('project typology', whereIn: projectTypology),
            Filter('status', whereIn: status)));

        return projects.snapshots();
      }
      if (projectTypology.isNotEmpty && year.isNotEmpty) {
        debugPrint('three');
        final db = FirebaseFirestore.instance;
        final projects = db.collection('projects').where(Filter.and(
            Filter('project typology', whereIn: projectTypology),
            Filter('year', whereIn: year)));

        return projects.snapshots();
      }
      if (status.isNotEmpty && year.isNotEmpty) {
        debugPrint('four');
        final db = FirebaseFirestore.instance;
        final projects = db.collection('projects').where(Filter.and(
            Filter('status', whereIn: status), Filter('year', whereIn: year)));
        return projects.snapshots();
      }
      if (projectTypology.isNotEmpty) {
        debugPrint('five');
        final db = FirebaseFirestore.instance;
        final projects = db
            .collection('projects')
            .where('project typology', whereIn: projectTypology);
        return projects.snapshots();
      }
      if (status.isNotEmpty) {
        debugPrint('six');
        final db = FirebaseFirestore.instance;
        final projects =
            db.collection('projects').where('status', whereIn: status);

        return projects.snapshots();
      }
      if (projectTypology.isEmpty && status.isEmpty && year.isEmpty) {
        debugPrint('seven');
        setState(() {});
        final db = FirebaseFirestore.instance;
        final projects = db.collection('projects');

        return projects.snapshots();
      }
      {
        debugPrint('eight');
        final db = FirebaseFirestore.instance;
        final projects = db.collection('projects').where('year', whereIn: year);

        return projects.snapshots();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: getListings(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading...'));
              }
              var docs = snapshot.data!.docs;
              return GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio:
                          MediaQuery.of(context).size.aspectRatio),
                  children: docs
                      .map((doc) => GridTile(
                            header: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Stack(children: [
                                Text(
                                  'ezikeaf',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.sp),
                                ),
                                Positioned(
                                    right: 10,
                                    child: IconButton(
                                        icon: const Icon(Icons.menu),
                                        color: Colors.white,
                                        onPressed: () async {
                                          var value =
                                              await showTopModalSheet<Map?>(
                                                  context, const TopModal());
                                          debugPrint(value.toString());
                                          if (value != null) {
                                            setState(() {
                                              projectTypology =
                                                  value['project typology'];
                                              status = value['status'];
                                              year = value['year'];
                                              isFiltered = true;
                                            });
                                          }
                                        }))
                              ]),
                            ),
                            child: Stack(fit: StackFit.expand, children: [
                              Positioned(
                                child: CarouselSlider.builder(
                                  options: CarouselOptions(
                                    aspectRatio:
                                        MediaQuery.of(context).size.aspectRatio,
                                    viewportFraction: 1,
                                    enableInfiniteScroll: true,
                                  ),
                                  itemCount: doc['photoLink'].length,
                                  itemBuilder: (context, itemIndex, realIndex) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                doc['photoLink'][itemIndex],
                                              ))),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                  top: 20,
                                  bottom: 20,
                                  right: 20,
                                  left: 20,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(doc['title'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20.sp)),
                                      Text(doc['location'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp)),
                                      OutlinedButton(
                                          onPressed: () {},
                                          child: const Text('Learn More'))
                                    ],
                                  )))
                            ]),
                          ))
                      .toList());
            }));
  }
}
