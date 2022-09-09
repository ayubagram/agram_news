import 'dart:developer';

import 'package:agram_news/blocs/bloc/news_bloc.dart';
import 'package:agram_news/respositories/news_repository.dart';
import 'package:agram_news/widgets/custom_image_provider.dart';
import 'package:agram_news/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsBloc(
            repository: NewsRepository(),
          )..add(LoadNews()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.arrow_right_alt),
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              log('Baskte pressed');
            },
            icon: const Icon(Icons.shopping_basket),
          ),
          TextButton(
            onPressed: () {
              log('Text button pressed');
            },
            child: const Text(
              'Text Button',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<NewsBloc>().add(LoadNews());
        },
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsInitial) {
              return const Loader();
            } else if (state is NewsLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  var news = state.news[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          color: Colors.white,
                          width: double.infinity,
                          child: news.urlToImage != null ? CustomImageProvider(image: news.urlToImage) : const SizedBox(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(news.title),
                              const SizedBox(height: 8),
                              Text(news.description),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: state.news.length,
              );
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}
