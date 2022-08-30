
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:todoapp/NewThings.dart';
import 'package:todoapp/test.dart';
import 'package:todoapp/OperationsPage.dart';
import 'package:todoapp/Styles.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

List data = [];
  @override
  void initState() {
    super.initState();
  //  getData();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height*0.33,
                width: size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/Weather.jpg"),fit: BoxFit.fitHeight)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 30.0),
                            child: Container(
                             // height: size.height*0.1,
                              child:const Icon(Icons.density_medium_sharp,color: Colors.white,size: 30,),
                            ),
                          ),
                          Container(
                            height: size.height*0.16,
                            width: size.width*0.55,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 20.0, top: 30),
                              child: Text('Your \nThings',style: TextStyle(color: Colors.white,
                                  fontSize: 40, fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Container(
                            height: size.height*0.08,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, top: 30),
                              child: Text(DateFormat('MMM dd, yyyy').format(DateTime.now()).toString(),
                                style: (const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Container(
                        height: size.height*0.4,
                        width: size.width*0.45,
                        color: Colors.transparent.withOpacity(0.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             SizedBox(height: size.height*0.1,),

                            Padding(
                              padding: const EdgeInsets.only(top: 50.0,right: 10.0),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                   Column(
                                     crossAxisAlignment:CrossAxisAlignment.end,

                                     children:  [
                                       FittedBox(child: Text('24', style:Styles.textStyle30,)),
                                       FittedBox(
                                         child: Text('Personal', style: Styles.textStyle15grey)),
                                     ],
                                   ),
                                    Column(
                                      children: [
                                        Text('15', style: Styles.textStyle30),
                                        Text('Business', style: Styles.textStyle15grey,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const    SizedBox(height: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    child: SfCircularChart(
                                        series: <CircularSeries>[
                                          // Renders doughnut chart
                                          DoughnutSeries<ChartData, String>(
                                              dataSource: chartData,
                                              pointColorMapper:(ChartData data,  _) => data.color,
                                              xValueMapper: (ChartData data, _) => data.x,
                                              yValueMapper: (ChartData data, _) => data.y,
                                            innerRadius: 15.toString(),
                                            radius: 10.toString()
                                          ),
                                        ]
                                    ),
                                  ),
                                ),
                                  SizedBox(
                                      height: 50,


                                      child: Center(child: Text('65% Done',style: Styles.textStyle15grey))),
                              ],
                            ),
                        ],),
                        // color: Colors.pinkAccent,
                      ),
                    ),
                  ],
                ),
              ),
             const SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text('Inbox'.toUpperCase(),style: Styles.textStyle18grey,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                child: Container(
                  height: size.height*0.4,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('tododata').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                      data = snapshot.data!.docs;
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                             print('uuid'+auth.currentUser!.uid);
                            if(auth.currentUser!.uid == snapshot.data!.docs[index]['id'] && snapshot.hasData){
                              return   Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(0.0),
                                    leading: Container(
                                        height: 70.0,
                                        width: 70.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.black),),
                                        child: Icon(statusIcon(snapshot.data!.docs[index]['type'].toString()))),
                                    title:  RichText(
                                      textScaleFactor: 1.5,
                                      text: TextSpan(
                                          style: Styles.fieldstyle,
                                          children: [
                                            TextSpan(text: snapshot.data!.docs[index]['type'].toString(),),
                                            const TextSpan(text: "  "),
                                            TextSpan(text:snapshot.data!.docs[index]['place'].toString(), ),


                                          ]),
                                    ),
                                    trailing: Text(snapshot.data!.docs[index]['time'].toString(),style: Styles.fieldstylegrey,),
                                    subtitle: RichText(
                                      textScaleFactor: 1.5,
                                      text: TextSpan(
                                          style: Styles.fieldstylegrey,
                                          children: [
                                            TextSpan(text: snapshot.data!.docs[index]['notification'].toString(),),
                                            const TextSpan(text: "  "),
                                            TextSpan(text:snapshot.data!.docs[index]['work'].toString(), ),


                                          ]),
                                    ),
                                    selected: true,
                                    onTap: () {
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=> OperationsPage(data: data,index: index,)));

                                    },
                                  ),
                                ),
                              );
                            } else if(snapshot.data!.docs.isEmpty && auth.currentUser!.uid != snapshot.data!.docs[index]['id']){
                              return SizedBox(height: size.height*0.3,
                                child:  Center(child: Text("Create a New Task",style: Styles.textStyle15black,),),
                              );
                            } else {
                              return const Text("");
                            }
                          });
                    },
                  ),



                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text('Completed'.toUpperCase(),style: Styles.textStyle18grey,),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),

            ],
          ),
        ),
        floatingActionButton:  FloatingActionButton(
            elevation: 0.0,
            backgroundColor:  Colors.lightBlue,
            onPressed: () {

             Navigator.push(context, MaterialPageRoute(builder: (context)=>const  NewThings()));


            },
            child:  const Icon(Icons.add)
        ),
      ),
    );
  }
IconData statusIcon(value) {
  switch (value) {
    case "Techno":
      {
        return  Icons.music_note_outlined;
      }
    case "Suit":
      {
        return Icons.snowshoeing_outlined;
      }
    case "Meeting":
      {
        return Icons.accessible_sharp;
      }
    default:
      {
        return Icons.edit_off_sharp;
      }
  }
}
  final List<ChartData> chartData = [
    ChartData('David', 65, Colors.lightBlue),
    ChartData('David', 35, Colors.grey),

  ];
}
class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}

