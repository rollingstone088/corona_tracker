// ignore_for_file: must_be_immutable
import 'package:covid_tracker/Model/Covidrecord.dart';
import 'package:covid_tracker/View/countires_list.dart';
import 'package:covid_tracker/services/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class world_stats extends StatefulWidget {
  const world_stats({Key? key}) : super(key: key);

  @override
  State<world_stats> createState() => _world_statsState();
}

class _world_statsState extends State<world_stats> with TickerProviderStateMixin{
  late final AnimationController _controller=AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this)..repeat();
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  final  colorlist=<Color> [const Color(0xff4285F4),const Color(0xff1aa260),const Color(0xffde5246)] ;
  @override
  Widget build(BuildContext context) {
    stats_services stats =stats_services();
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              FutureBuilder(future: stats.fetchstats(),builder: (context,AsyncSnapshot<Covidrecord> snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(color: Colors.white,size: 50,controller: _controller,),
                  );
                }else{
                  return Column(
                    children: [
                                   PieChart(
                dataMap:  {
                  // double.parse(snapshot.data!.cases!.toString()),
                  "Total":double.parse(snapshot.data!.cases.toString()),
                  "Recoverd":double.parse(snapshot.data!.recovered.toString()),
                  "Deaths":double.parse(snapshot.data!.deaths.toString()),
                },
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true
                ),
                chartRadius: MediaQuery.of(context).size.width/3.2,
                legendOptions: const LegendOptions(
                  legendPosition: LegendPosition.left,
                ),
                animationDuration: const Duration(milliseconds: 1200),
                chartType: ChartType.ring,
                colorList: colorlist,
                ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height *.06),
                child: Card(
                  child: Column(
                    children:  [
                      helperrow(title:'Total', value: snapshot.data!.cases.toString()),
                      helperrow(title:'Recoverd', value: snapshot.data!.recovered.toString(),),
                      helperrow(title:'Deaths', value: snapshot.data!.deaths.toString(),),
                      helperrow(title:'Active', value: snapshot.data!.active.toString(),),
                      helperrow(title:'TodayCases', value: snapshot.data!.todayCases.toString(),),
                      helperrow(title:'TodayRecovered', value: snapshot.data!.todayRecovered.toString(),),
                      helperrow(title:'TodayDeaths', value: snapshot.data!.todayDeaths.toString(),),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountriesList()));
                },
                child: Container(
                  height: 50,
                  decoration:  BoxDecoration(
                    color: const Color(0xff1aa260),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(
                    child: Text('Track Countries')
                    ),
                ),
              )
                    ],
                  );
                }
              }),
              
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class helperrow extends StatelessWidget {
  final String title,value;
  const helperrow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}