import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/Theme/app_theme.dart';
import 'package:news/core/utils/error_indicator.dart';
import 'package:news/core/utils/loading_indecator.dart';
import 'package:news/features/home/data/models/article.dart';
import 'package:news/features/home/data/models/source.dart';

import 'package:news/features/home/view_model/new_cubit.dart';
import 'package:news/features/home/view_model/news_states.dart';
import 'package:news/features/news/new_item.dart';
import 'package:news/features/news/new_tab.dart';


class NewView extends StatefulWidget {
  final String categoryId;

  const NewView({super.key, required this.categoryId});

  @override
  State<NewView> createState() => _NewViewState();
}

class _NewViewState extends State<NewView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getSources(widget.categoryId),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is SourcesSuccessState) {
            var sources = state.sourcesResponse.sources ?? [];
            if (sources.isNotEmpty) {
              NewsCubit.get(context).getNews(sources[0].id!);
            }
          }
        },
        builder: (context, state) {
          var cubit = NewsCubit.get(context);

          if (state is SourcesLoadingState) {
            return const LoadingIndecator();
          } else if (state is SourcesErrorState) {
            return const ErrorIndicator();
          }

          if (cubit.sources.isNotEmpty) {
            List<Source> sources = cubit.sources;

            return DefaultTabController(
              length: sources.length,
              child: Column(
                children: [
                  TabBar(
                    onTap: (index) {
                      if (currentIndex == index) return;
                      setState(() {
                        currentIndex = index;
                      });
                      cubit.getNews(sources[index].id!);
                    },
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicatorColor: AppTheme.white,
                    tabAlignment: TabAlignment.start,
                    labelPadding: const EdgeInsets.only(left: 16),
                    tabs: sources
                        .map(
                          (source) => NewTab(
                            source: source,
                            isSelected:
                                currentIndex == sources.indexOf(source),
                          ),
                        )
                        .toList(),
                  ),

                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (state is NewsLoadingState) {
                          return const LoadingIndecator();
                        } else if (state is NewsErrorState) {
                          return const ErrorIndicator();
                        } else if (state is NewsSuccessState) {
                          List<Article> news =
                              state.newsResponse.articles ?? [];
                          if (news.isEmpty) return const ErrorIndicator();

                          return ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemBuilder: (_, index) =>
                                NewItem(news: news[index]),
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 16),
                            itemCount: news.length,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return const ErrorIndicator();
        },
      ),
    );
  }
}