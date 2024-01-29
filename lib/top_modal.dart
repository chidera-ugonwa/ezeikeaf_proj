//import 'package:ezeikeaf_proj/home.dart';
import 'package:flutter/material.dart';

class TopModal extends StatefulWidget {
  const TopModal({super.key});

  @override
  State<TopModal> createState() => _TopModalState();
}

class _TopModalState extends State<TopModal> {
  List projectTypology = [];
  List status = [];
  List year = [];
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
                      onPressed: () async {
                        setState(() => selected = !selected);

                        if (selected) {
                          projectTypology.add('Modern');
                        } else {
                          projectTypology.remove('Modern');
                        }
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

                        if (selected2) {
                          projectTypology.add('Old');
                        } else {
                          projectTypology.remove('Old');
                        }
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

                        if (selected3) {
                          projectTypology.add('Community Service');
                        } else {
                          projectTypology.remove('Community Service');
                        }
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

                        if (selected4) {
                          year.add('2021');
                        } else {
                          year.remove('2021');
                        }
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

                        if (selected5) {
                          year.add('2022');
                        } else {
                          year.remove('2022');
                        }
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

                          if (selected6) {
                            year.add('2023');
                          } else {
                            year.remove('2023');
                          }
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

                      if (selected7) {
                        status.add('Active');
                      } else {
                        status.remove('Active');
                      }
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

                        if (selected8) {
                          status.add('Inactive');
                        } else {
                          status.remove('Inactive');
                        }
                      },
                      child: const Text('Inactive')),
                ]),
                const SizedBox(
                  width: 200,
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.pop(context, {
                      'project typology': projectTypology,
                      'status': status,
                      'year': year,
                    });
                  },
                )
              ],
            )
          ]),
    );
  }
}
