import 'dart:developer';

import 'package:agram_news/models/news_model.dart';
import 'package:agram_news/respositories/news_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _repository;
  NewsBloc({required NewsRepository repository})
      : _repository = repository,
        super(const NewsInitial(loading: true)) {
    on<LoadNews>((event, emit) async {
      log('18');
      try {
        log('20');
        final news = await _repository.getNews();
        emit(NewsLoaded(loading: false, news: news));
      } catch (e) {
        log('Error ${e.toString()}');
      }
    });
  }
}
