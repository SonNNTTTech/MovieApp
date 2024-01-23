// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:test_app/presentation/home/component/movie_widget.dart';
import 'package:test_app/presentation/home/entity/movie_entity.dart';
import 'package:test_app/widget/pagination_wrapper.dart';

class MoviePage extends StatelessWidget {
  final List<MovieEntity> items;
  final Future Function() onReload;
  final Future Function() onNewPage;
  final bool isNoMorePage;
  final String? errorText;
  const MoviePage({
    Key? key,
    required this.items,
    required this.onReload,
    required this.onNewPage,
    required this.isNoMorePage,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginationWrapper(
        onReload: onReload,
        isNoMorePage: isNoMorePage,
        onNewPage: onNewPage,
        errorText: errorText,
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: List.generate(
              items.length, (index) => MovieWidget(entity: items[index])),
        ));
  }
}
