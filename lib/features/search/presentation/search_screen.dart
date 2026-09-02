import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/core/constant/app_colors.dart';
import 'package:news_wave/core/constant/app_strings.dart';
import 'package:news_wave/features/news/models/category_news_model.dart';
import 'package:news_wave/features/search/presentation/widgets/buid_empty_state.dart';
import 'package:news_wave/features/search/presentation/widgets/build_Idle_state.dart';
import 'package:news_wave/features/search/provider/search_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/network/api_status.dart';
import '../../../core/utils/app_date_utils.dart';
import '../../home/presentation/detail_screen.dart';
import 'widgets/build_error_state.dart';
import 'widgets/build_shmmier_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final provider = context.watch<SearchProvider>();
    final response = provider.searchResponse;
    final articles = response.data?.articles ?? [];
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: SearchBar(provider: provider),
      ),
      body: Column(children: [
        buildBody(articles, colorScheme, theme,provider),
      ],),
    );
  }
}
/* buildBody start here*/
  Widget buildBody(List<Articles> articles, ColorScheme colorScheme, ThemeData theme,SearchProvider provider) {
    final response= provider.searchResponse;
    switch(response.status){
      case Status.loading:
        return buildShimmerCard();
      case Status.idle:
        return buildIdleState(colorScheme, theme);
      case Status.completed:
        final articles= response.data!.articles??[];
        if(articles.isEmpty){
return buildEmptyState(colorScheme, theme);
        }
      case Status.error:
        return buildErrorState(colorScheme, theme, response.message??AppStrings.somethingWentWrong);
    }
    return Expanded(
      child: ListView.builder(
shrinkWrap: true,
itemCount: articles.length,
itemBuilder: (context, index) {
  final item =articles[index];
return InkWell(
  borderRadius:BorderRadius.circular(12),
  onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(articles: item),),);
  },
  child:   Container(
    decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(12),
        color: colorScheme.surface,
    ),
    margin: EdgeInsets.symmetric(
        horizontal: 10, vertical: 6,),
    child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),),
          child: Image.network(
            item.urlToImage??AppStrings.noImage.tr(),height: 120,width: 120,fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(height: 120, width: 120, decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10),), child: Icon(Icons.image_not_supported,color: Colors.red,),),),),
        const SizedBox(width: 12,),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.title??AppStrings.noTitle.tr(),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8,),
            Text(item.source!.name??AppStrings.noSource.tr(),
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.primary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,),
            const SizedBox(height: 4,),
            Text(AppDateUtils.formatRelativeDate(item.publishedAt),
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 11,
                color: colorScheme.primary,),),
          ],),),

    ],),

  ),
);
},),
    );
  }
/* buildBody end here*/

/*SearchBar start here*/
class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.provider,
  });

  final SearchProvider provider;


  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    final colorScheme=theme.colorScheme;
    return Row(children: [
      //Back Button
      ValueListenableBuilder(valueListenable: provider.searchController, builder:(context, value, _) {
        return value.text.isEmpty?
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child:const Icon(Icons.arrow_back_ios_new_rounded,size: 18,color: AppColors.primary,) ,),
        ):const SizedBox.shrink();
      },),
      //Back Button
      const SizedBox(width: 15,),
      /*SearchField*/
      Expanded(
        child: TextField(
          textInputAction: TextInputAction.search,
          focusNode: provider.searchFocus,
          controller: provider.searchController,
          onSubmitted: (_) => provider.searchNews(),
          autofocus: true,
          decoration: InputDecoration(
            contentPadding:const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            filled: true,
            fillColor: colorScheme.surface,
            hintText: AppStrings.searchHint.tr(),
            hintStyle: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 1.5,
                color: AppColors.primary,
              ),
            ),
            suffixIcon:ValueListenableBuilder(valueListenable: provider.searchController, builder: (context, value, child) {
              return value.text.isNotEmpty? IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                icon: Icon(Icons.close_rounded,color: colorScheme.onSurfaceVariant,size: 18,),onPressed: () {
                provider.clearSearch();
              },):
           const   SizedBox.shrink();

            },),
          ),
        ),
      ),
      /*SearchField*/
    ],);
  }
}
/*SearchBar end here*/
