import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sharpsell_app/model/model_page_data.dart';
import 'package:sharpsell_app/services/comic_services.dart';

class ComicPage extends StatefulWidget {
  const ComicPage({super.key});

  @override
  State<ComicPage> createState() => _ComicPageState();
}

class _ComicPageState extends State<ComicPage> {

  final _comicService = ComicServices();
  
  final rng = Random();
  final ValueNotifier<int> _pageNumberNotifier = ValueNotifier<int>(1);

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
                      if (_pageNumberNotifier.value > 1) {
                        _pageNumberNotifier.value--;
                      }
                    },
                    child: const Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _pageNumberNotifier.value = rng.nextInt(100);
                    },
                    child: const Text('Random'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _pageNumberNotifier.value++;
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ValueListenableBuilder(
                valueListenable: _pageNumberNotifier,
                builder: (context,pageNo,child) {
                  return FutureBuilder(
                    future: _comicService.requestPage(pageNo),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
