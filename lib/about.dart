import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('S.n. Ahad',
                  style: TextStyle(
                    fontFamily: 'Orbitron Regular',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                'DEVELOPER',
                style: TextStyle(
                    fontFamily: 'Orbitron Regular',
                    color: Colors.teal.shade100,
                    fontSize: 12.0,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),
              Card(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                      leading: Icon(
                        Icons.link,
                      ),
                      title: Text(
                        'www.github.com/i-am-ahad',
                        style: TextStyle(
                            fontFamily: 'Orbitron Regular', fontSize: 16.0),
                      ))),
              Card(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                    ),
                    title: Text(
                      'hello@iamahad.com',
                      style: TextStyle(
                        fontFamily: 'Orbitron Regular',
                        fontSize: 16.0,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
