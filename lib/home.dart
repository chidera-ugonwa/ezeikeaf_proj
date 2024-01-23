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

class DumyModal extends StatelessWidget {
  const DumyModal({super.key});

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
                  OutlinedButton(child: const Text('Modern'), onPressed: () {}),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(child: const Text('Old'), onPressed: () {}),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                      child: const Text('Community Service'), onPressed: () {})
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
                      child: const Text('2021'),
                      onPressed: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      child: const Text('2022'),
                      onPressed: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(child: const Text('2023'), onPressed: () {}),
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
                    onPressed: () {},
                    child: const Text('Active'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                      onPressed: () {}, child: const Text('Inactive')),
                ]),
                const SizedBox(
                  width: 250,
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                )
              ],
            )
          ]),
    );
  }
}
