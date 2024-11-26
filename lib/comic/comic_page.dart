import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sharpsell_app/model/model_page_data.dart';
import 'package:sharpsell_app/services/comic_services.dart';
import 'package:sharpsell_app/util/string_constants.dart';

class ComicPage extends StatefulWidget {
  const ComicPage({super.key});

  @override
  State<ComicPage> createState() => _ComicPageState();
}

class _ComicPageState extends State<ComicPage> {
  final _comicService = ComicServices();

  final rng = Random();
  final ValueNotifier<int> _pageNumberNotifier = ValueNotifier<int>(1);

  Widget _previousButton() {
    return ValueListenableBuilder(
      valueListenable: _pageNumberNotifier,
      builder: (context, pageNo, child) {
        return ElevatedButton(
          onPressed: _pageNumberNotifier.value > 1
              ? () {
                  _pageNumberNotifier.value--;
                }
              : null,
          child: const Text(StringConstants.previous),
        );
      },
    );
  }

  Widget _randomButton() {
    return ElevatedButton(
      onPressed: () {
        _pageNumberNotifier.value = rng.nextInt(999) + 1;
      },
      child: const Text(StringConstants.random),
    );
  }

  Widget _nextButton() {
    return ElevatedButton(
      onPressed: () {
        _pageNumberNotifier.value++;
      },
      child: const Text(StringConstants.next),
    );
  }

  Widget _controls() {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _previousButton(),
          _randomButton(),
          _nextButton(),
        ],
      ),
    );
  }

  Widget _display() {
    return Flexible(
      child: ValueListenableBuilder(
        valueListenable: _pageNumberNotifier,
        builder: (context, pageNo, child) {
          return FutureBuilder(
            future: _comicService.requestPage(pageNo),
            builder: (
              BuildContext context,
              AsyncSnapshot<ComicPageData> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data!.img != null) {
                  return Column(
                    children: [
                      Text(
                        snapshot.data!.title!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Flexible(
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data!.img!,
                          height: double.infinity,
                          fit: BoxFit.contain,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('Oops !!! An error occured.'),
                  );
                }
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _controls(),
            _display(),
          ],
        ),
      ),
    );
  }
}
