
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsappflutter/model/categories_news_model.dart';

import '../view_model/news_view_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat("MMM dd,yy");
  String category = "General ";

  List<String> btnCategories = [
    "General",
    "Entertainment",
    "Health",
    "Sports",
    "Business",
    "Technology"
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                  // padding: EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: btnCategories.length,
                  itemBuilder: (context,index) {
                return Row(
                  children: [
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        category = btnCategories[index];
                        setState(() {

                        });
                      },
                      child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                      color: category == btnCategories[index] ? Colors.blue: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(btnCategories[index], style: GoogleFonts.poppins(
                        fontSize: 13, color: Colors.white
                      ),),
                      ),
                    ),
                  ],
                );
              }),
            ),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCetegoryNewsApi(category),
                builder: (BuildContext context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(size: 50, color: Colors.blue,),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
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
      ),
    );
  }
}
