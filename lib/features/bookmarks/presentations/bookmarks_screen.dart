import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/features/bookmarks/providers/bookmarks_provider.dart';
import 'package:news_wave/features/news/models/category_news_model.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_strings.dart';
import '../../../core/utils/app_date_utils.dart';
import '../../home/presentation/detail_screen.dart';

class BookMarksScreen extends StatefulWidget {
  const BookMarksScreen({super.key});

  @override
  State<BookMarksScreen> createState() => _BookMarksScreenState();
}

class _BookMarksScreenState extends State<BookMarksScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookmarksProvider>().loadBookMarks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    final colorScheme = theme.colorScheme;
    final provider = context.watch<BookmarksProvider>();
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body:       SafeArea(child: buildList(provider: provider),),
    );
  }
}

class buildList extends StatelessWidget {
  const buildList({
    super.key,
    required this.provider,
  });

  final BookmarksProvider provider;

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    final colorScheme = theme.colorScheme;
    if(provider.isLoading){
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    }
    if(provider.bookmarks.isEmpty){
      return buildEmptyList();
    }
    return     buildBookmarkList(provider: provider);
  }
}
/*buildBookmarkList start here*/
class buildBookmarkList extends StatelessWidget {
  const buildBookmarkList({
    super.key,
    required this.provider,
  });
  final BookmarksProvider provider;
  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Row(children: [
            Text(
              '${provider.bookmarks.length} ${AppStrings.savedArticles.tr()}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                showDialog(context: context,builder: (_) =>AlertDialog(
                  backgroundColor: theme.scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(AppStrings.clearAllBookMarks.tr(),style: TextStyle(fontWeight: FontWeight.bold),),
                  content:  Text(
                    AppStrings.areYouSureYouWantToRemoveAllSavedArticles.tr(),
                  ),
                  actions: [
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text(AppStrings.cancel.tr(), style: TextStyle(color: AppColors.primary),
                    ),),
                    ElevatedButton(
                      style:ElevatedButton.styleFrom(
backgroundColor: Colors.red, elevation: 0,shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      ),
                      onPressed: () {
                      provider.clearAllBookmarks();
                      Navigator.pop(context);
                    }, child: Text(AppStrings.clearAll.tr(), style: TextStyle(color: AppColors.white),
                    ),),
                  ],
                ),);
              },
              child: Text(
                AppStrings.clearAll.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: provider.bookmarks.length,
          itemBuilder: (context, index) {
          final item = provider.bookmarks[index];
          return  BookMarkCard(article: item,onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(articles: item),),);
          },
            onRemove: () {
              provider.toggleBookmarks(item);
            },
          );
        },),
      ],
    );
  }
}
/*buildBookmarkList end here*/
/*buildEmptyList start here*/
class buildEmptyList extends StatelessWidget {
  const buildEmptyList({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Expanded(child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.bookmark_border_rounded,
              size: 60,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppStrings.bookmarks.tr(),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.saveArticlesToReadLater.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            AppStrings.tapOnAnyArticleToSaveIt.tr(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    ),);
  }
}
/*buildEmptyList end here*/
/*BookMarkCard start here*/
class BookMarkCard extends StatelessWidget {
  const BookMarkCard({
    super.key,
    required this.article,
    required this.onTap,
    required this.onRemove,
  });

  final Articles article;
 final  void Function() onTap;
  final  void Function() onRemove;

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Dismissible(
      onDismissed: (_) => onRemove(),
      key: Key(article.url??""),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(Icons.delete_outline_rounded,color: AppColors.white,size: 28,),
      ),
      child: InkWell(
        borderRadius:BorderRadius.circular(12),
        onTap:onTap,
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
                article.urlToImage??AppStrings.noImage.tr(),height: 120,width: 120,fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(height: 120, width: 120, decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10),), child: Icon(Icons.image_not_supported,color: Colors.red,),),),),
            const SizedBox(width: 12,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.title??AppStrings.noTitle.tr(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8,),
                Text(article.source!.name??AppStrings.noSource.tr(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,),
                const SizedBox(height: 4,),
                Text(AppDateUtils.formatRelativeDate(article.publishedAt),
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    color: colorScheme.primary,),),
              ],),),

          ],),

        ),
      ),
    );
  }
}
/*BookMarkCard start here*/
