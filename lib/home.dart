import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activePage = 0;

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
                child: Stack(children: [
                  CarouselSlider.builder(
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
                ]),
              );
            }));
  }
}
