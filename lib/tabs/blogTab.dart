import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dart:async';

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../components/propertyList.dart';
import '../views/blogDisplay.dart';

class BlogTab extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _BlogTabState();
}

class _BlogTabState extends State<BlogTab> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();
  Map data;

  List userData;

  static List updatedData;

  Future getData() async {
    var response = await http.get(
        Uri.encodeFull("http://www.gohome.ng/get_blog_api.php"),
        headers: {"Accept": "application/json"});

    userData = json.decode(response.body);

    setState(() {
      updatedData = [for (var i = 0; i <= 2; i += 1) userData[i]];
    });

    debugPrint(userData.toString());
    return userData;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        onPageStarted: (String load) {
          return CircularProgressIndicator();
        },
        initialUrl: 'https://blog.gohome.ng/',
        onWebViewCreated: (WebViewController webViewController){
          _controller.complete(webViewController);
        },
        javascriptMode: JavascriptMode.unrestricted,
      )
    );
    // return SingleChildScrollView(
    //       child: Stack(
    //         children: <Widget>[
    //           Container(
    //             child: Text("Blogs"),
    //           ),
    //           Container(
    //             margin: EdgeInsets.only(top: 200),
    //                       child: MaterialButton(
    //                         child: Text(
    //                           "Go to Blogs",
    //                           style: TextStyle(color: Color(0xFF79c942)),
    //                         ),
    //                         color: Colors.white,
    //                         onPressed: () {
    //                           Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                               builder: (context) => BlogDisplay(),
    //                             ),
    //                           );
    //                         },
    //                       ),
    //                     )
    //           // SafeArea(
    //           //   child: Container(
    //           //     margin: EdgeInsets.only(top: 40),
    //           //     child: ListView.builder(
    //           //       shrinkWrap: true,
    //           //       physics: ClampingScrollPhysics(),
    //           //       itemCount: updatedData == null ? 0 : updatedData.length,
    //           //       itemBuilder: (context, index) {
    //           //         final item = updatedData[index];
    //           //         return GestureDetector(
    //           //           onTap: (){
    //           //             Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDisplay()));
    //           //           },
    //           //           child: Container(
    //           //             padding: EdgeInsets.all(5),
    //           //             width: double.infinity,
    //           //             child: Column(
    //           //               children: <Widget>[
    //           //                 Text(item["title"], textAlign: TextAlign.start, style: TextStyle(fontSize: 20),),
    //           //                 Text(item["author"], textAlign: TextAlign.start,)
    //           //               ],
    //           //             ),
    //           //           ),
    //           //           // child: PropertyList(
    //           //           //   amount: item["title"],
    //           //           //   propId: item["author"],
    //           //           //   region: item["excerpt"],
    //           //           //   imagePath: item["image"],
    //           //           // ),
    //           //         );
    //           //       },
    //           //     ),
    //           //   ),
    //           // ),
    //         ],
    //       ),
    //     );
  }
  
}