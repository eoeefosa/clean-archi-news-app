import 'package:flutter/material.dart';
import 'package:newscleanapp/features/daily_news/domain/entities/article.dart';
import 'package:newscleanapp/features/daily_news/presentation/pages/home/daily_news.dart';

import '../../features/daily_news/presentation/pages/article_detail/article_detail.dart';
import '../../features/daily_news/presentation/pages/saved_article/saved_article.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const DailyNews());
      case ArticleDetailsView.route:
        return MaterialPageRoute(
          builder: (_) {
            final values = settings.arguments as List;
            return ArticleDetailsView(
              article: values[0] as ArticleEntity,
              index: values[1] as int,
            );
          },
        );
      case SavedArticles.route:
        return _materialRoute(const SavedArticles());

      default:
        return _materialRoute(const DailyNews());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
