import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/core/constant/app_colors.dart';
import 'package:news_wave/core/routes/route_names.dart';
import 'package:news_wave/features/main/providers/main_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/app_strings.dart';
import 'Widgets/news_drawer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  /*_getTitle start here*/
  String _getTitle(int index){
    switch(index){
      case 0:
        return AppStrings.appName.tr();
      case 1:
        return AppStrings.categories.tr();
      case 2:
        return AppStrings.bookmarks.tr();
      case 3:
        return AppStrings.profile.tr();
      default:
        return AppStrings.appName.tr();
    }
  }
/*_getTitle end here*/

  @override
  Widget build(BuildContext context) {
    final mainProvider = context.watch<MainProvider>();
    final width = MediaQuery.of(context).size.width;
    final theme=Theme.of(context);
    final colorScheme=theme.colorScheme;
    return Scaffold(
      drawer: NewsDrawer(),
      appBar: AppBar(
        leading: Builder(builder: (context) => IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,

            onPressed: ()=>Scaffold.of(context).openDrawer(), icon: Icon(Icons.menu_rounded,color: AppColors.primary,)),),
        centerTitle: true,
        title: Text(_getTitle(mainProvider.currentIndex),style: theme.textTheme.titleLarge!.copyWith(
          color: colorScheme.primary,
          fontSize: width * 0.035,
          fontWeight: FontWeight.w600,
      ),
        ),
        actions: [
          if(mainProvider.currentIndex==0)
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          onPressed: () {
            Navigator.pushNamed(context,RouteNames.search);

          }, icon: Icon(Icons.search_rounded,color: colorScheme.primary,),),
          if(mainProvider.currentIndex==1)
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onPressed: () {}, icon: Icon(Icons.tune_rounded,color: colorScheme.primary,),),
          if(mainProvider.currentIndex==3)
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onPressed: () {}, icon: Icon(Icons.settings_outlined,color: colorScheme.primary,),),
        ],
      ),
      /*bottomNavigationBar start here*/
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
            offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) => mainProvider.changeIndex(index),
          currentIndex: mainProvider.currentIndex,
          items:  [
BottomNavigationBarItem(
  label: AppStrings.home.tr(),
  icon: Icon(Icons.home_outlined),
  activeIcon: Icon(Icons.home),
),
            BottomNavigationBarItem(
              label:  AppStrings.categories.tr(),
              icon: Icon(Icons.category_outlined),
              activeIcon: Icon(Icons.category),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark_border),
              activeIcon: Icon(Icons.bookmark),
              label:  AppStrings.bookmarks.tr(),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person_outlined),
              activeIcon: Icon(Icons.person),
              label: AppStrings.profile.tr(),
            ),
          ],
        ),
      ),
      /*bottomNavigationBar end here*/
      body: IndexedStack(
        index: mainProvider.currentIndex,
        children: mainProvider.pages,
      ),
    );
  }
}


