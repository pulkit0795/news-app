import 'package:flutter/material.dart';
import 'package:newsapp/folder/news.dart';
import 'home.dart';
import 'package:flip_panel/flip_panel.dart';

class CategoryNews extends StatefulWidget {
  final String newsCategory;

  CategoryNews({this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  PageController _controller = PageController(
    initialPage: 0,
    // viewportFraction: 0.85,
  );
  // var currentPageValue = 0.0;

  // PageController controller = PageController();
  // var currentPageValue = 0.0;

  // _controller.addListener(() {
  // setState(() {
  // currentPageValue = controller.page;
  // });
  // });

  var newslist;
  bool _loading = true;

  @override
  void initState() {
    getNews();
    super.initState();
  }

  void getNews() async {
    NewsForCategorie news = NewsForCategorie();
    await news.getNewsForCategory(widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.share,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PageView.builder(
              controller: _controller,

              physics: BouncingScrollPhysics(),
              // pageSnapping: false,

              itemBuilder: (BuildContext context, int position) {
                // if (position == _controller.page.floor()) {
                //   return Transform(
                //       transform: Matrix4.identity()
                //         ..rotateX(_controller.page - position),
                //       child: MyPageWidget(newslist, position));
                // } else if (position == _controller.page.floor() + 1) {
                //   return Transform(
                //       transform: Matrix4.identity()
                //         ..rotateX(_controller.page - position),
                //       child: MyPageWidget(newslist, position));
                // } else {
                return MyPageWidget(newslist, position);
                // }
              },
              itemCount: newslist.length,
            ),
    );
  }
}

class MyPageWidget extends StatelessWidget {
  var newslist;
  int index;

  MyPageWidget(this.newslist, this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NewsTile(
        imgUrl: newslist[index].urlToImage ?? "",
        title: newslist[index].title ?? "",
        desc: newslist[index].description ?? "",
        content: newslist[index].content ?? "",
        posturl: newslist[index].articleUrl ?? "",
      ),
    );
  }
}
