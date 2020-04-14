import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'country.dart';
import 'package:fl_chart/fl_chart.dart';
import 'data.dart';
import 'indicator.dart';
import 'about.dart';

void main() => runApp(Corona());

class Corona extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: CoronaStats(),
    );
  }
}

class CoronaStats extends StatefulWidget {
  @override
  _CoronaStatsState createState() => _CoronaStatsState();
}

class _CoronaStatsState extends State<CoronaStats> {
  int touchedIndex;
  String dropdownValue = 'Bangladesh';

  String totalCases;
  String newCases;
  String totalDeaths;
  String recovered;

  String worldTotalCases = 'Loading...';
  String worldNewCases = 'Loading...';
  String worldTotalDeaths = 'Loading...';
  String worldRecovered = 'Loading...';

  double valueForTotalCases;
  double valueForNewCases;
  double valueForTotalDeaths;
  double valueForRecovered;

  void getData() async {
    Data data = new Data(dropdownValue);
    var fromAPI = await data.getData();
    setState(() {
      totalCases = fromAPI['data'][0]['cases'].toString();
      newCases = fromAPI['data'][0]['todayCases'].toString();
      totalDeaths = fromAPI['data'][0]['deaths'].toString();
      recovered = fromAPI['data'][0]['recovered'].toString();

      worldTotalCases = fromAPI['worldStats']['cases'].toString();
      worldNewCases = fromAPI['worldStats']['todayCases'].toString();
      worldTotalDeaths = fromAPI['worldStats']['deaths'].toString();
      worldRecovered = fromAPI['worldStats']['recovered'].toString();

      double oneHundredPercent = double.parse(totalCases) +
          double.parse(newCases) +
          double.parse(totalDeaths) +
          double.parse(recovered);
      valueForTotalCases =
          (int.parse(totalCases) / oneHundredPercent * 100) + 10;
      valueForNewCases = (int.parse(newCases) / oneHundredPercent * 100) + 10;
      valueForTotalDeaths =
          (int.parse(totalDeaths) / oneHundredPercent * 100) + 10;
      valueForRecovered = (int.parse(recovered) / oneHundredPercent * 100) + 10;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return About();
                }),
              );
            },
          )
        ],
        title: Text(
          "C O R O N A    S T A T S",
          style: TextStyle(fontFamily: "Orbitron Regular"),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Select your country",
                  style:
                      TextStyle(fontFamily: "Orbitron Regular", fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.flag),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(fontFamily: "Orbitron Regular"),
                  underline: Container(
                    height: 2,
                    color: Colors.redAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      getData();
                      showingSections();
                    });
                  },
                  items: country.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                          pieTouchData:
                              PieTouchData(touchCallback: (pieTouchResponse) {
                            setState(() {
                              if (pieTouchResponse.touchInput
                                      is FlLongPressEnd ||
                                  pieTouchResponse.touchInput is FlPanEnd) {
                                touchedIndex = -1;
                              } else {
                                touchedIndex =
                                    pieTouchResponse.touchedSectionIndex;
                              }
                            });
                          }),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingSections()),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'WORLD STATS',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Orbitron Regular",
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Indicator(
                          color: Colors.lightBlue,
                          text: 'Total Cases',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Indicator(
                          color: Colors.yellowAccent,
                          text: 'New Cases',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Indicator(
                          color: Colors.red,
                          text: 'Total Deaths',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Indicator(
                          color: Colors.green,
                          text: 'Recovered',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 28,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Indicator(
                              color: Colors.lightBlue,
                              text: '',
                              isSquare: false,
                            ),
                            Text(
                              worldTotalCases + '',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Orbitron Regular",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            Indicator(
                              color: Colors.yellowAccent,
                              text: '',
                              isSquare: false,
                            ),
                            Text(
                              worldNewCases,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Orbitron Regular",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            Indicator(
                              color: Colors.red,
                              text: '',
                              isSquare: false,
                            ),
                            Text(
                              worldTotalDeaths,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Orbitron Regular",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            Indicator(
                              color: Colors.green,
                              text: '',
                              isSquare: false,
                            ),
                            Text(
                              worldRecovered,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Orbitron Regular",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 28,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.lightBlue,
            value: valueForTotalCases,
            title: totalCases,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xff000000)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellowAccent,
            value: valueForNewCases,
            title: newCases,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xff000000)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.red,
            value: valueForTotalDeaths,
            title: totalDeaths,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xff000000)),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: valueForRecovered,
            title: recovered,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xff000000)),
          );
        default:
          return null;
      }
    });
  }
}
