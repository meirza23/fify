import 'dart:math';
import 'package:fify/blocs/movies_bloc.dart';
import 'package:fify/models/item_model.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class Lucky extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetRandomMovie(),
    );
  }
}

class GetRandomMovie extends StatefulWidget {
  @override
  State<GetRandomMovie> createState() => _GetRandomMovieState();
}

class _GetRandomMovieState extends State<GetRandomMovie> {
  int randomNumber = Random().nextInt(20); // randomNumber'ı burada tutuyoruz
  final bloc = MoviesBloc(); // bloc'ı burada tanımladık

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.allMovies,
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Something went wrong"));
        } else if (snapshot.hasData) {
          // Veriyi aldıktan sonra bu widget'ı göstereceğiz
          return Column(
            children: [
              SizedBox(height: 50),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  snapshot.data!.results[randomNumber].posterPath,
                  height: 280,
                  width: 350,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  snapshot.data!.results[randomNumber].title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  snapshot.data!.results[randomNumber].releaseDate
                      .substring(0, 4),
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width - 40) / 3,
                      height: 120,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data!.results[randomNumber].popularity
                                  .toStringAsFixed(0),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Popularity',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 40) / 3,
                      height: 120,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: iconColor,
                              size: 28,
                            ),
                            RichText(
                              text: TextSpan(
                                text: snapshot
                                    .data!.results[randomNumber].voteAverage
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' / 10',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 40) / 3,
                      height: 120,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data!.results[randomNumber].voteCount
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Vote Count',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      snapshot.data!.results[randomNumber].overview,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    randomNumber =
                        Random().nextInt(20); // Buton ile filmi değiştir
                  });
                },
                tooltip: "Change the Movie!",
                icon: Icon(
                  Icons.auto_awesome_sharp,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Click the button to change the movie',
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          );
        } else {
          return Center(child: Text("No Data Available"));
        }
      },
    );
  }
}
