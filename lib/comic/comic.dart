import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sharpsell_app/model/model_page_data.dart';
import 'package:sharpsell_app/services/comic_services.dart';

class Comic extends StatefulWidget {
  const Comic({super.key});

  @override
  State<Comic> createState() => _ComicState();
}

class _ComicState extends State<Comic> {
  Future<ComicPageData> _requestPage(int pageNumber) {
    return ComicServices().requestPage(pageNumber);
  }

  Random rng = Random();

  int index = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (index > 1) {
                        setState(() {
                          index--;
                        });
                      }
                    },
                    child: const Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        index = rng.nextInt(100);
                      });
                    },
                    child: const Text('Random'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        index++;
                      });
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
            Flexible(
              child: FutureBuilder(
                future: _requestPage(index),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<ComicPageData> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Image.network(
                      snapshot.data!.img!,
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
