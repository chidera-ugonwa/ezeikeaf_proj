import 'package:carousel_slider/carousel_slider.dart';
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

  Stream<QuerySnapshot> getListings() {
    setState(() {});
    final db = FirebaseFirestore.instance;
    final projects = db.collection('projects');
    return projects.snapshots();
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
              return GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, childAspectRatio: 1.75),
                  children: snapshot.data!.docs
                      .map((document) => _buildGridItem(document, context))
                      .toList());
            }));
  }
}

Widget _buildGridItem(DocumentSnapshot document, BuildContext context) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  return GridTile(
    header: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(children: [
        const Text(
          'ezikeaf',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        Positioned(
            right: 10,
            child: IconButton(
                icon: const Icon(Icons.menu),
                color: Colors.white,
                onPressed: () async {
                  await showTopModalSheet<String?>(context, const DumyModal());
                }))
      ]),
    ),
    child: Stack(fit: StackFit.expand, children: [
      Positioned(
        child: CarouselSlider.builder(
          options: CarouselOptions(
            //onPageChanged: (val, _) {
            //setState(() {
            //activePage = val;
            //});
            //},
            aspectRatio: 1,
            viewportFraction: 1,
            enableInfiniteScroll: true,
          ),
          itemCount: data['photoLink'].length,
          itemBuilder: (context, itemIndex, realIndex) {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        data['photoLink'][itemIndex],
                      ))),
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
              Text(data['title'],
                  style: const TextStyle(color: Colors.white, fontSize: 24)),
              Text(data['location'],
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
              OutlinedButton(onPressed: () {}, child: const Text('Learn More'))
            ],
          )))
    ]),
  );
}

class DumyModal extends StatefulWidget {
  const DumyModal({super.key});

  @override
  State<DumyModal> createState() => _DumyModalState();
}

class _DumyModalState extends State<DumyModal> {
  bool selected = false;
  bool selected2 = false;
  bool selected3 = false;
  bool selected4 = false;
  bool selected5 = false;
  bool selected6 = false;
  bool selected7 = false;
  bool selected8 = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 50),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Project typology',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor:
                              selected ? Colors.grey : Colors.white),
                      child: const Text('Modern'),
                      onPressed: () {
                        setState(() => selected = !selected);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor:
                              selected2 ? Colors.grey : Colors.white),
                      child: const Text('Old'),
                      onPressed: () {
                        setState(() => selected2 = !selected2);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor:
                              selected3 ? Colors.grey : Colors.white),
                      child: const Text('Community Service'),
                      onPressed: () {
                        setState(() => selected3 = !selected3);
                      })
                ]),
                const SizedBox(
                  width: 250,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Year',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor:
                              selected4 ? Colors.grey : Colors.white),
                      child: const Text('2021'),
                      onPressed: () {
                        setState(() => selected4 = !selected4);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor:
                              selected5 ? Colors.grey : Colors.white),
                      child: const Text('2022'),
                      onPressed: () {
                        setState(() => selected5 = !selected5);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor:
                                selected6 ? Colors.grey : Colors.white),
                        child: const Text('2023'),
                        onPressed: () {
                          setState(() => selected6 = !selected6);
                        }),
                  ],
                ),
                const SizedBox(
                  width: 250,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Status',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor:
                            selected7 ? Colors.grey : Colors.white),
                    onPressed: () {
                      setState(() => selected7 = !selected7);
                    },
                    child: const Text('Active'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor:
                              selected8 ? Colors.grey : Colors.white),
                      onPressed: () {
                        setState(() => selected8 = !selected8);
                      },
                      child: const Text('Inactive')),
                ]),
                const SizedBox(
                  width: 200,
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ]),
    );
  }
}
