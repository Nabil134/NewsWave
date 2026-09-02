import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/core/constant/app_colors.dart';
import 'package:news_wave/core/constant/app_strings.dart';
import 'package:news_wave/core/utils/app_date_utils.dart';
import 'package:news_wave/features/bookmarks/providers/bookmarks_provider.dart';
import 'package:news_wave/features/home/webview_screen.dart';
import 'package:news_wave/features/news/models/category_news_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
 const  DetailScreen({super.key,required this.articles});
   final Articles articles;
   
   /*_openUrl start here*/
  Future<void> _openUrl(BuildContext context) async{
    final url = articles.url;
    if(url==null || url.isEmpty ) return;
    final uri = Uri.parse(url);
    if( await canLaunchUrl(uri)){
await launchUrl(uri,mode: LaunchMode.externalApplication);
    }
    else{
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not open article"),),);
      }
    }

   }
   /*_openUrl end here*/


  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size= MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      /*bottomNavigationBar start here*/
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 50,
            child: ElevatedButton.icon(onPressed:(){
              _openUrl(context);
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(Icons.open_in_browser_rounded,color: AppColors.white,size: 20,),
                label: Text(AppStrings.readFullArticle.tr(),style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                  fontSize: 15,
                ),),),
          ),
        ),
      ),
      /*bottomNavigationBar end here*/
    body: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(articles: articles),),);
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /*SliverAppBar start here*/
          SliverAppBar(
            expandedHeight: size.height*0.38,
            pinned: true,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            elevation: 0,
            automaticallyImplyLeading: false,
           leading: Padding(
             padding: const EdgeInsets.all(8.0),
             child: InkWell(
               onTap: () {
                 Navigator.pop(context);
               },
               borderRadius: BorderRadius.circular(12),
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(12),
                   color: AppColors.primary.withOpacity(0.4),
                 ),
                 child: Icon(Icons.arrow_back_ios_new_rounded,
                   color: AppColors.white,
                   size: 18,
                 ),
               ),
             ),
           ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    _openUrl(context);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.black.withOpacity(0.4),
                    ),
                    child: Icon(Icons.share_rounded,
                      color: AppColors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
            /*flexibleSpace start here*/
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                Image.network(articles.urlToImage??AppStrings.noImage,fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: colorScheme.surfaceVariant,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Icon(Icons.image_not_supported,size: 60,color: colorScheme.onSurfaceVariant,),
                       const SizedBox(height: 8,),
                        Text(AppStrings.noImageAvailable.tr(),style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                        ),),
                    ],),
                  ),
                ),
                  DecoratedBox(decoration:BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                      Colors.transparent,
                      AppColors.black.withOpacity(0.6),
                    ],),
                  ),),
              ],),
            ),
            /*flexibleSpace end here*/
          ),
          /*SliverAppBar end here*/
          /*content start here*/
          SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Source badge
              Row(
                children: [
                  Container(
                    padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                    decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                    child: Text(articles?.source?.name??AppStrings.unknown.tr(),style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),),
                  ),
                  // Source badge
                  const Spacer(),
                  Consumer<BookmarksProvider>(
                    builder: (context,bookmarkProvider,_) {
                      final bool isBookmarked= bookmarkProvider.isBookmarked(articles.url);
                      return InkWell(
                        onTap: () {
                          bookmarkProvider.toggleBookmarks(articles);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color:isBookmarked? AppColors.primary.withOpacity(0.1):colorScheme.surface,
                          ),
                          child: Icon(isBookmarked?Icons.bookmark_rounded:Icons.bookmark_border_rounded,
                            color:isBookmarked? AppColors.primary:colorScheme.onSurfaceVariant,
                            size: 18,
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),
                const SizedBox(height: 14,),
                Row(children: [
                  Icon(Icons.access_time_outlined,size: 14,color: colorScheme.onSurfaceVariant,),
                  const SizedBox(width: 4,),
                  Text(AppDateUtils.formatRelativeDate(articles.publishedAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],),
        const SizedBox(height: 14,),
        /*title start here*/
        Text(articles.title??AppStrings.noTitle.tr(),
          style: theme.textTheme.headlineSmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
        ),
                /*title end here*/
              Container(height:5,width: size.width*0.8,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                ),
              ),
                const SizedBox(height: 14,),
                /*author start here*/
                if(articles.author!=null)
                  Row(children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: Icon(Icons.person_outline_rounded,size: 16,color: AppColors.primary,),
                    ),
                    const SizedBox(width: 8,),
                    Expanded(
                      child: Text(articles.author??AppStrings.noAuthor.tr(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],),
                /*author end here*/
                const SizedBox(height: 14,),
                /*description start here*/
                if(articles.description!=null)
                  Text(articles.description??AppStrings.noDescription.tr(),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                      height: 1.8,
                    ),
                  ),
                /*description end here*/
                const SizedBox(height: 14,),
                /*content start here*/
                if(articles.content!=null)
                  Text(articles.content!.replaceAll(RegExp(r'\[\+\d+ chars\]'),'').trim(),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.7,
                    ),
                  ),
                /*content end here*/
                const SizedBox(height: 80,),
            ],),
          ),),
          /*content end here*/
        ],
      ),
    ),
    );
  }
}
