import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsappflutter/model/headlines_news_model.dart';
import 'package:newsappflutter/view/category_screen.dart';
import 'package:newsappflutter/view_model/news_view_model.dart';

import '../model/categories_news_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum FilterList {bbcNews, aryNews, Independent, CNN, AlJazeera, FoxNews, GoogleNews}

class _HomeViewState extends State<HomeView> {
  NewsViewModel newsViewModel = NewsViewModel();
   final format = DateFormat("MMM dd,yy");
   FilterList? selectedItem;
   String name = "bbc-news";
   String newName = "bbc-news";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen()));
          },
          icon: Icon(Icons.grid_on,),

        ),
        title: Text("News", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 24),),
        centerTitle: true,
        actions: [
          PopupMenuButton<FilterList>(
            icon: const Icon(Icons.more_vert, color: Colors.black,),
        initialValue: selectedItem,
        onSelected: (FilterList item) {
              if(FilterList.bbcNews.name == item.name){
                 name = "bbc-news";
                 setState(() {
                   newName = name;
                   print(newName);
                 });
              }
              if(FilterList.CNN.name == item.name){
                name = "cnn";
                setState(() {
                  newName = name;
                  print(newName);
                });
              }
              if(FilterList.aryNews.name == item.name) {
                name = "ary-news";
                setState(() {
                  newName = name;
                  print(newName);
                });
              }
              if(FilterList.AlJazeera.name == item.name) {
                name = "al-jazeera-english";
                setState(() {
                  newName = name;
                  print(newName);
                });
              }
              if(FilterList.FoxNews.name == item.name) {
                name = "fox-news";
                setState(() {
                  newName = name;
                  print(newName);
                });
              }
              if(FilterList.GoogleNews.name == item.name) {
                name = "google-news";
                setState(() {
                  newName = name;
                  print(newName);
                });
              }
              else{
                print("Match not found");
              }

        },
        itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
          const PopupMenuItem(
            value: FilterList.bbcNews,
            child: Text( "BBC News"),
          ),const PopupMenuItem(
            value: FilterList.CNN,
            child: Text( "CNN News"),
          ),const PopupMenuItem(
            value: FilterList.AlJazeera,
            child: Text( "Al Jazeera News"),
          ),
          const PopupMenuItem(
            value: FilterList.FoxNews,
            child: Text( "Fox News"),
          ),
          const PopupMenuItem(
            value: FilterList.aryNews,
            child: Text( "Ary News"),
          ),
          const PopupMenuItem(
            value: FilterList.GoogleNews,
            child: Text( "Google News"),
          )
        ],)
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            width: width,
            height: height * 0.55,
            child: FutureBuilder<HeadlinesNewsModel>(
              future: newsViewModel.fetchNewsChannelHeadlineApi(newName),
              builder: (BuildContext context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                  child: SpinKitCircle(size: 50, color: Colors.blue,),
                );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime date = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: width * 0.8,
                                  height: height* 0.6,
                                  padding: EdgeInsets.symmetric(horizontal: height*0.01),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context,url) => Container(child: SpinKitCircle(size: 42, color: Colors.blue,),),
                                      errorWidget: (context, url, error) => Icon(Icons.error_outline, color: Colors.red,),

                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                                      padding: EdgeInsets.all(15),
                                      alignment: Alignment.bottomCenter,
                                      height: height * 0.22,

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width * 0.7,
                                            child :Text(
                                                snapshot.data!.articles![index].title.toString(),
                                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: width * 0.7,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data!.articles![index].source!.name.toString(),
                                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                                ),
                                                Text(format.format(date), style: GoogleFonts.poppins(),),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchCetegoryNewsApi("General"),
              builder: (BuildContext context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(size: 50, color: Colors.blue,),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      DateTime date = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                height: height * 0.18,
                                width: width * 0.32,
                                decoration: BoxDecoration(

                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context,url) => Container(child: SpinKitCircle(size: 42, color: Colors.blue,),),
                                    errorWidget: (context, url, error) => Icon(Icons.error_outline, color: Colors.red,),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                    height: height * 0.18,
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].title.toString(),
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index].source!.name.toString(),
                                              // maxLines: 2,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                            Text(format.format(date),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,

                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
