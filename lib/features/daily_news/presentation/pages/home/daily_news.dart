import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newscleanapp/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:newscleanapp/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

import '../../../domain/entities/article.dart';
import '../../widgets/article_tile.dart';
import '../article_detail/article_detail.dart';
import '../saved_article/saved_article.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody() ,
    );
  }
  
  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
          'Daily News',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => _onShowSavedArticlesViewTapped(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(Icons.bookmark, color: Colors.black),
            ),
          ),
        ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticlesBloc,RemoteArticlesState> (
      builder: (_,state) {
        if (state is RemoteArticlesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteArticlesError) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is RemoteArticlesDone) {
          return ListView.builder(
           itemBuilder: (context,index){
            return ArticleWidget(
              article: state.articles![index] ,
              onArticlePressed: (article) => _onArticlePressed(context,article, index),
            );
           },
           itemCount: state.articles!.length,
         );
        }
        return const SizedBox();
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article, int index) {
    Navigator.pushNamed(context, ArticleDetailsView.route, arguments: [article, index]);
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, SavedArticles.route);
  }
  
}