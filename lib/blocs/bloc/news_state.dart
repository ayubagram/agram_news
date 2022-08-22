part of 'news_bloc.dart';

@immutable
abstract class NewsState extends Equatable {
  final bool loading;
  const NewsState({required this.loading});

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {
  const NewsInitial({required super.loading});
}

class NewsLoaded extends NewsState {
  final List<NewsModel> news;
  const NewsLoaded({this.news = const <NewsModel>[], required bool loading})
      : super(loading: loading);

  @override
  List<Object> get props => [news];
}
