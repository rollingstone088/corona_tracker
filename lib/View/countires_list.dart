import 'package:covid_tracker/View/Details.dart';
import 'package:covid_tracker/services/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchcontroller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    stats_services stats = stats_services();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchcontroller,
              onChanged: (value){
                setState(() {
                  
                });
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Enter Country Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: stats.coutrieslisapi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ));
                      });
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name=snapshot.data![index]['country'];

                        if(searchcontroller.text.isEmpty){
                          return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context, 
                                MaterialPageRoute(builder: (context)=> Deatils(
                                  name: snapshot.data![index]['country'],
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  total: snapshot.data![index]['cases'],
                                  test: snapshot.data![index]['tests'],
                                  todaycase: snapshot.data![index]['critical'],
                                  todayrec: snapshot.data![index]['todayRecovered'],
                                  deaths: snapshot.data![index]['deaths'],
                                  active: snapshot.data![index]['active'],
                                  recovered: snapshot.data![index]['recovered'],
                                ))
                                );
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            )
                          ],
                        );
                        }else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase())){
                          return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context, 
                                MaterialPageRoute(builder: (context)=> Deatils(
                                  name: snapshot.data![index]['country'],
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  total: snapshot.data![index]['cases'],
                                  test: snapshot.data![index]['tests'],
                                  todaycase: snapshot.data![index]['critical'],
                                  todayrec: snapshot.data![index]['todayRecovered'],
                                  deaths: snapshot.data![index]['deaths'],
                                  active: snapshot.data![index]['active'],
                                  recovered: snapshot.data![index]['recovered'],
                                ))
                                );
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            )
                          ],
                        );
                        }else{
                          return Container();
                        }
                        
                      });
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}
