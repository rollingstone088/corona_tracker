// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'world_stats.dart';

class Deatils extends StatefulWidget {
   String name ,image;
   int total=0,deaths=0,recovered=0,active=0,todaycase=0,todayrec=0,test=0;
  Deatils({Key? key,required this.name,required this.image,required this.total,required this.deaths,required this.recovered,required this.active,required this.todaycase,required this.todayrec,required this.test}) : super(key: key);
  @override
  State<Deatils> createState() => _DeatilsState();
}

class _DeatilsState extends State<Deatils> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                // padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.06,),
                      helperrow(title: 'Cases', value: widget.total.toString()),
                      helperrow(title: 'Deaths', value: widget.deaths.toString()),
                      helperrow(title: 'Recoverd', value: widget.recovered.toString()),
                      helperrow(title: 'Active', value: widget.active.toString()),
                      helperrow(title: 'Critical', value: widget.todaycase.toString()),
                      helperrow(title: 'Today Recoverd', value: widget.todayrec.toString()),
                      helperrow(title: 'Tests', value: widget.test.toString())
                    ],
                  ),
                ),
              )
             ,CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.image),
             )
            ],
          )
        ],
      ),
    );
  }
}