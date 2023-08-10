import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gallery_cache/src/features/news/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:flutter_gallery_cache/src/features/news/presentation/widgets/news_item.dart';

import '../../../../constants/colors/app_colors.dart';
import '../widgets/error.dart';
import '../widgets/not_connected.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray01,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions:  [
          GestureDetector(
            onTap: () async {
              BlocProvider.of<NewsBloc>(context).add(GetNews());
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.refresh,
                color: Colors.black,
              ),
            ),
          )
        ],
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DakarNews',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Hello, voici les dernières news 🤗',
              style: TextStyle(
                color: gray02,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(builder: (context, newsState) {
        print(newsState);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: newsState is NewsLoaded
              ? SingleChildScrollView(
                child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      newsState.isCachedData == true
                          ? const NotConnected()
                          : Container(),
                      // List articles
                      newsState.articles.isNotEmpty ? ListView.separated(
                        separatorBuilder: (context, index){
                          return const Divider();
                        },
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: newsState.articles.length,
                        itemBuilder: (context, index) {
                          return NewsItem(article: newsState.articles[index]);
                        },
                      ) : const Center(child: Text('Aucune donnée')),
                    ],
                  ),
              )
              : newsState is NewsError
                  ? const ErrorMessage()
                  : const Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }
}
