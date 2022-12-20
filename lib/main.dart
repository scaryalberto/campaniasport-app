import 'dart:convert';
import 'research_screen.dart';
import 'article_detail.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future futureAlbum;
  late List libri=[];
  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true; // your loader has started to load
    });
    super.initState();
    futureAlbum = fetchAlbum();
  }

  Future fetchAlbum() async {
    final response = await http
    .get(Uri.parse('http://3.73.244.65/api/campaniasport/'));
        //.get(Uri.parse('http://10.0.2.2:8000/api/campaniasport/'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("eccolo");
      print(jsonDecode(response.body));


      //data['all_campaniasport_articles'][100]['fields']

      Map<String, dynamic> data = jsonDecode(response.body);
      List lista_di_cose=data['all_campaniasport_articles'];
      setState(() {
        libri=lista_di_cose;
        _isLoading = false;
      });

      //return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CampaniaSport APP")),

      body: _isLoading
          ? CircularProgressIndicator(//per inserirelo al centro: https://www.woolha.com/tutorials/flutter-using-circularprogressindicator-examples
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              strokeWidth : 4.0
          )
       : ListView.builder(
          itemCount: libri.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(//image_url
                  onTap: () async {
                      String url = libri[index]['fields']['article_url'];
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }

                    //Navigator.of(context).push(MaterialPageRoute(builder:(context)=>DetailPage(libri[index])));
                    //print("INSERIRE LA PAGINA DI DETAIL"); //https://stackoverflow.com/questions/53861302/passing-data-between-screens-in-flutter
                    },
                leading: Image.network(libri[index]['fields']['image_url']),
                        title: Text(libri[index]['fields']['title_for_list']))
            );
          }),
        floatingActionButton: Column(//per inserire 2 floating button nello stessa app
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  fetchAlbum();
                  // Add your onPressed code here!
                },
                backgroundColor: Colors.green,
                child: const Icon(Icons.refresh),
              ),
              Padding(
                padding: EdgeInsets.all(5), //apply padding to all four sides
              ),

              FloatingActionButton(
                child: Icon(
                    Icons.search
                ),
                onPressed: () {
                  //Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ResearchPage()));
                  print("INSERIRE LA PAGINA DI ricerca"); //https://stackoverflow.com/questions/53861302/passing-data-between-screens-in-flutter
                },
                heroTag: null,
              )
            ]
        ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Image.network("https://scontent-fco2-1.xx.fbcdn.net/v/t39.30808-6/302558272_532703418759087_1741488890313189617_n.png?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=bwiHR2JXmdMAX9nntJW&_nc_ht=scontent-fco2-1.xx&oh=00_AfBvIt4jH5N1ho8FXcm122KcxbFktktp5pI7l8lEpo5GfQ&oe=6397D16D"),
            ),
            ListTile(
              title: const Text('CampaniaSport.it'),
              onTap: () {

                String url="https://www.campaniasport.it/";
                launch(url);
                },
            ),
            ListTile(
              title: const Text('Credentials'),
              onTap: () {
                String url="http://www.albertoscaringi.it/";
                launch(url);
              },
            ),
            ListTile(
              title: const Text('Preferiti'),
              onTap: () {
              },
            ),

          ],
        ),
      ),
    );
  }

}