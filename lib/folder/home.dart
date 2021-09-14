import 'package:flutter/material.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/folder/categories.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsapp/folder/news.dart';
import 'package:newsapp/folder/view_news.dart';
import 'package:newsapp/folder/view_categoryy.dart';
import 'package:url_launcher/url_launcher.dart';

launchLinkedIn() async {
  const url = 'https://www.linkedin.com/in/pulkit0795/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = List<CategorieModel>();
  var newslist;
  bool _loading;

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();

    categories = getCategories();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Mass",
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
      ),
      body: GridView.builder(
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 3),
          ),
          itemBuilder: (context, index) {
            return CategoryCard(
              imageAssetUrl: categories[index].imageAssetUrl,
              categoryName: categories[index].categorieName,
            );
          }),
      // floatingActionButton: IconButton(
      //     icon: Icon(
      //       Icons.info_outline,
      //       color: Colors.blueGrey,
      //     ),
      //     onPressed: () {
      //       return showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //             shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.all(Radius.circular(12.0))),
      //             title: Text("Developers Zone!!"),
      //             content: Text("This App has been developed by Pulkit Goyal"),
      //             actions: [
      //               FlatButton(
      //                 child: Text("LinkedIn"),
      //                 onPressed: () {
      //                   launchLinkedIn();
      //                   Navigator.of(context).pop();
      //                 },
      //               ),
      //               FlatButton(
      //                 child: Text("OK"),
      //                 onPressed: () {
      //                   Navigator.of(context).pop();
      //                 },
      //               ),
      //             ],
      //           );
      //         },
      //       );
      //     }),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  CategoryCard({this.imageAssetUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNews(
              newsCategory: categoryName.toLowerCase(),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          margin: EdgeInsets.zero,
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imageAssetUrl,
                  height: 100,
                  width: 190,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 100,
                width: 190,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black26),
                child: Text(
                  categoryName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl;

  NewsTile(
      {this.imgUrl,
      this.desc,
      this.title,
      this.content,
      @required this.posturl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              postUrl: posturl,
            ),
          ),
        );
      },
      child: Container(
        // margin: EdgeInsets.only(bottom: 24),
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      imgUrl,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    desc,
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
