
import 'package:flutter/material.dart';
import '../Helpers/APIhelpers.dart';
import '../models/Covid19Modelclass.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  late Future<WorldWideData?> worldWideData;
  @override
  initState(){
    super.initState();
    worldWideData = APIHelper.apiHelper.getCovidData();
  }
  uiBox({required String text,required String data, required Color color, }){
    return Container(
      padding: const EdgeInsets.all(10),
      height: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text,style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),),
          Text(data,style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),),
        ],
      ),
    );
  }

  bool isGlobal = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon:const Icon(Icons.search_rounded) , onPressed:(){
          }),
          IconButton(icon:const Icon(Icons.refresh) , onPressed:(){
            setState((){
              worldWideData = APIHelper.apiHelper.getCovidData();
            });
          })
        ],
        title: const Text("Covid 19 Live"),
        backgroundColor: const Color(0xff313131),
      ),
      body: FutureBuilder(
        future: worldWideData,
        builder:(BuildContext context, AsyncSnapshot<WorldWideData?> snapshot){
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }else if(snapshot.hasData){
            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(15),
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0,0),
                        ),
                      ]
                  ),
                  child: Row(
                    children: [
                      const Text("Global", style: TextStyle(color:  Color(0xff313131), fontSize: 22, fontWeight: FontWeight.w500)),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: (){
                          isGlobal = true;
                          setState((){});
                        },
                        style: ElevatedButton.styleFrom(
                            primary: isGlobal?const Color(0xff313131):Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: (isGlobal)?const BorderSide():const BorderSide(
                                color: Color(0xff313131),
                                width: 1,
                              ),
                            )
                        ),
                        child:  Text("Total",style: TextStyle(color: isGlobal?Colors.white:const Color(0xff313131)),),

                      ),
                      const SizedBox(width: 10,),
                      ElevatedButton(
                        onPressed: (){
                          isGlobal = false;
                          setState((){});
                        },
                        style: ElevatedButton.styleFrom(
                            primary: isGlobal==false?const Color(0xff313131):Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: (isGlobal==false)?const BorderSide():const BorderSide(
                                color: Color(0xff313131),
                                width: 1,
                              ),
                            )
                        ),
                        child:  Text("New",style: TextStyle(color: isGlobal==false?Colors.white:const Color(0xff313131)),),

                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height*0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0,0),
                        ),
                      ]
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                  child: uiBox(text: "Confirmed", data: "${isGlobal?snapshot.data!.totalConfirmed:snapshot.data!.newConfirmed}", color: const Color(0xffFF983C))
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                  child:uiBox(text: "Active", data: "${isGlobal?snapshot.data!.totalConfirmed-(snapshot.data!.totalRecovered+snapshot.data!.totalDeaths):snapshot.data!.newConfirmed-(snapshot.data!.newRecovered+snapshot.data!.newDeaths)}", color: const Color(0xff309AFE),)
                              )
                            ],
                          )
                      ),
                      const SizedBox(height: 10,),
                      Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: uiBox(text: "Recovered", data: "${isGlobal?snapshot.data!.totalRecovered:snapshot.data!.newRecovered}", color: const Color(0xff31C95C),),
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: uiBox(text: "Death", data: "${isGlobal?snapshot.data!.totalDeaths:snapshot.data!.newDeaths}", color: const Color(0xffFF3B3C),),
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: const Color(0xff313131),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0,0),
                        ),
                      ]
                  ),
                  child: Row(
                    children: const [
                      Expanded(
                          child: Text("Country",style: TextStyle(color: Colors.white),)
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("Recover",style: TextStyle(color: Colors.white),))
                      ),
                      Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child:  Text("confirmed",style: TextStyle(color: Colors.white),),
                          )
                      ),
                      Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("Death",style: TextStyle(color: Colors.white),),
                          )
                      )
                    ],
                  ),
                ),
                Column(
                  children: snapshot.data!.countries.map((e) {
                    Country n = e;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height*0.07,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(0,0),),
                          ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(n.country)
                          ),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(n.totalRecovered.toString()))
                          ),
                          Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child:  Text(n.totalConfirmed.toString()),
                              )
                          ),
                          Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(n.totalDeaths.toString()),
                              )
                          )
                        ],
                      ),
                    );}).toList(),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator(color: Color(0xff313131),),);
          }
        },
      ),
      backgroundColor: const Color(0xffF4F6FD),
    );
  }
}
