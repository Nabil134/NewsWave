import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/components/big_card_loading.dart';
import 'package:news_wave/components/category_loading_card.dart';
import 'package:news_wave/core/constant/app_strings.dart';
import 'package:news_wave/core/utils/app_date_utils.dart';
import 'package:news_wave/features/home/presentation/detail_screen.dart';
import 'package:news_wave/features/home/providers/home_provider.dart';
import 'package:news_wave/features/news/providers/news_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/network/api_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    final homeProvider = context.read<HomeProvider>();
    final newsProvider = context.read<NewsProvider>();
    homeProvider.initializeTabController(this,newsProvider);
    newsProvider.getCategoryNews(homeProvider.apiCategories[0]);
  }
  @override
  void dispose() {
    context.read<HomeProvider>().disposeTabController();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final newsProvider = context.watch<NewsProvider>();
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          /*first portion start here*/
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelPadding:const EdgeInsets.symmetric(horizontal: 8),
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            controller: homeProvider.tabController,
              overlayColor: MaterialStateProperty.all(
                Colors.transparent,
              ),
              tabs:
           homeProvider.categories.asMap().entries.map((entry){
final index=entry.key;
final category=entry.value;
return buildTab(category, isActive: homeProvider.tabIndex==index);
           }).toList(),
          ),
          /*first portion end here*/
          /*last portion start here*/
          Expanded(child: TabBarView(
            controller: homeProvider.tabController,
              children:homeProvider.apiCategories.map((e) => buildNews(newsProvider)).toList(),
          ),),
          /*last portion end here*/
        ],),
      ),
    );
  }
/*buildNews start here*/
Widget buildNews(NewsProvider provider){
final response = provider.categoryNewsResponse;
final theme=Theme.of(context);
final colorScheme=theme.colorScheme;
switch (response.status){
  case Status.idle:
    return Center(child: Text(AppStrings.noNewsLoaded.tr(),style: theme.textTheme.bodyLarge,),);
  case Status.loading:
    return SingleChildScrollView(
      child: Column(
        children: [
          BigCardLoading(),
          ListView.builder(
            shrinkWrap: true,
            itemCount:6,
            itemBuilder: (context, index) {
              return const CategoryLoadingCard();
            },
          ),
        ],
      ),
    );
  case Status.error:
    return Center(child: Column(
      children: [
        Text(response.message??AppStrings.somethingWentWrong.tr(),style: theme.textTheme.bodyLarge?.copyWith(
          color: colorScheme.error,
        ),),
      ],
    ),);
  case Status.completed:
    final articles= response.data?.articles??[];
  if(articles.isEmpty){
    return  Center(child: Text(AppStrings.noNewsAvailable.tr(),style: theme.textTheme.bodyLarge,),);
  }
  return ListView.builder(
    itemCount: articles.length,
    itemBuilder: (context, index) {
      final item= articles[index];
      if(index==0){
        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(articles: item),),);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(16),
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
                child: Image.network(
                  item.urlToImage??AppStrings.noImage.tr(),height: 200,width: double.infinity,fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.image_not_supported,color: Colors.red,),
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //ContainerBadge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:  Text(item.source?.name??AppStrings.unknown.tr(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    //ContainerBadge
                    const SizedBox(height: 8,),
                    Text(item.title??AppStrings.noTitle.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4,),
                    Text(AppDateUtils.formatRelativeDate(item.publishedAt),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 11,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],),
              ),
            ],),
          ),
        );
      }
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(articles: item),),);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(12),
          color: colorScheme.surface,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        child: Row(children: [
ClipRRect(
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12),
      bottomLeft: Radius.circular(12),

  ),
child: Image.network(
      item.urlToImage??AppStrings.noImage.tr(),height: 120,width: 120,fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) => Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(Icons.image_not_supported,color: Colors.red,),
  ),
),
),
          const SizedBox(width: 12,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(item.title??AppStrings.noTitle.tr(),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
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
              overflow: TextOverflow.ellipsis,
            ),
              const SizedBox(height: 4,),
              Text(AppDateUtils.formatRelativeDate(item.publishedAt),
                style: theme.textTheme.bodySmall?.copyWith(
                 fontSize: 11,
                  color: colorScheme.primary,
                ),
              ),
          ],),),
        ],),
      ),
    );
  },);
}
}
/*buildNews end here*/
}


/*buildTab start here*/
Widget buildTab(String title,{required bool isActive}){
  return  Tab(child: Container(
    decoration: BoxDecoration(
      color: isActive? AppColors.primary:null,
      borderRadius: BorderRadius.circular(10),
    ),
    child: ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 60,
        minHeight: 32,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
        child: Text(title,style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 11,
          color: isActive? AppColors.white:AppColors.primary,
        ),),
      ),
    ),),);
}
/*buildTab end here*/

