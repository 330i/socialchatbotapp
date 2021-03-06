import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialchatbotapp/leaderboard.dart';
import 'package:socialchatbotapp/login.dart';
import 'package:socialchatbotapp/ui/screens/startpage.dart';

class PostGuess extends StatefulWidget {

  final bool wasCorrect;

  const PostGuess({Key key, this.wasCorrect}) : super(key: key);
  @override
  _PostGuessState createState() => _PostGuessState();
}

class _PostGuessState extends State<PostGuess> {

  getPoint() async {
    print('enter getPoint');
    int userPoint;
    var userDoc = Firestore.instance.collection('users').document(userid);
    print('mid');
    await Firestore.instance.collection('users').document(userid).get().then((value) {
      userPoint = value.data['points'];
    });
    if(widget.wasCorrect){
      userDoc.setData({
        'points':userPoint+50,
      },merge: true);
      print('added');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getWidget(widget.wasCorrect),
      //NAV BAR
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[200],
        child: Icon(
          Icons.home,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StartPage()),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 9,
        color: Colors.grey[200],
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FutureBuilder(
                future: getPoint(),
                builder: (context, snapshot){
                  return Container();
                },
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.grey[200],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LeaderBoard()),
                  );
                },
                child: Text('LeaderBoards'),
              ),
              SizedBox(
                width: 60,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.grey[200],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text('Sign-Out'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget getWidget(wasCorrect) {
  if (wasCorrect == true) {
    return Align(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.greenAccent[100],
                  Colors.greenAccent[200]
                ])),
            child: Column(
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          "Congrats!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          Container(
                            width: 250,
                            child: Text(
                              'You guessed it properly!',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 26),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 200,
                              height: 200,
                              child: Image.asset(
                                  'assets/images/ThumbsUP.png',
                                fit: BoxFit.cover,
                              )
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 250,
                            child: Text(
                              "You weren't going to be fooled!",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 26),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 250,
                            child: Text(
                              "You get 50 points!",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 26),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ])));
  } else {
    return Align(
        child: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.redAccent[100],
                          Colors.redAccent[200]
                        ])),
                child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              Container(
                                width: 250,
                                child: Text(
                                  "Oops!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 26),
                                ),
                              ),
                              SizedBox(height: 20),
                              Column(
                                children: [
                                  Container(
                                    width: 250,
                                    child: Text(
                                      'You guessed it incorrectly!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 26),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                      width: 200,
                                      height: 200,
                                      child: Image.asset(
                                        'assets/images/ThumbsDown.png',
                                        fit: BoxFit.cover,
                                      )
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 250,
                                    child: Text(
                                      "You got fooled by your opponent!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 26),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 250,
                                    child: Text(
                                      "You get 0 points...",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 26),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
    ]))));
  }
}
