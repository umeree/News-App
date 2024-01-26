import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatefulWidget {
  String source, author, title, description, imageUrl, publishAt, content;
  NewsDetailsScreen({super.key, required this.source, required this.author, required this.title, required this.imageUrl, required this.publishAt, required this.description, required this.content});
  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final format = DateFormat("MMM dd,yy");
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    final date = DateTime.parse(widget.publishAt);
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            height: height * 0.45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context,url) => Container(child: SpinKitCircle(size: 42, color: Colors.blue,),),
                errorWidget: (context, url, error) => Icon(Icons.error_outline, color: Colors.red,),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            ),
            height: height * 0.6 ,
            margin: EdgeInsets.only(top: height * 0.43),
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                Text(widget.title, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black87),),
                SizedBox(height: height *0.04,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.source, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue),),
                    Text(format.format(date), style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),),
                  ],
                ),
                SizedBox(height: height *0.04,),
                Text(widget.description, style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87
                ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
