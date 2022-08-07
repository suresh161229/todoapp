
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:todoapp/NewThings.dart';
import 'package:todoapp/Styles.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height*0.4,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/Weather.jpg"),fit: BoxFit.fitWidth)
            ),
            child: Row(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 80,top: 10),
                        child: Container(
                          child: Icon(Icons.density_medium_sharp,color: Colors.white,size: 30,),
                        ),
                      ),
                      Container(
                        height: size.height*0.2,
                        width: size.width*0.6,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 80, top: 30),
                          child: Text('Your \nThings',style: TextStyle(color: Colors.white,
                              fontSize: 40, fontWeight: FontWeight.w300),),
                        ),
                      ),
                      Container(
                        height: size.height*0.08,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 80, top: 30),
                          child: Text(DateFormat('MMM dd, yyyy').format(DateTime.now()).toString(),
                            style: (const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: size.height*0.2,
                  width: size.width*0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                           Column(
                             children: const [
                               Text('24', style: (TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),),
                               Text('Personal', style: (TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                               ),
                             ],
                           ),
                            const  SizedBox(width: 20,),
                            Column(
                              children:const [
                                Text('15', style: (TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),),
                                Text('Business', style: (TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const    SizedBox(height: 20,),
                      Row(
                        children: [
                          Container(
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
                            Text('65% Done',style: Styles.textStyle18),
                        ],
                      ),
                  ],),
                  // color: Colors.pinkAccent,
                ),
              ],
            ),
          ),
         const SizedBox(height: 20.0,),
         const Text('Inbox'),
          Container(
            height: size.height*0.4,
            child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.blue[50],
                      child: ListTile(
                        leading: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                                border: Border.all(color: Colors.black),),
                            child: const Icon(Icons.add)),
                        title: const Text(
                          'Boglioli suit fitting',
                          textScaleFactor: 1.5,
                        ),
                        trailing: const Icon(Icons.done),
                        subtitle: const Text('Linnegatan 2, Gothenburg'),
                        selected: true,
                        onTap: () {
                        },
                      ),
                    ),
                  );
                }),
          ),
          Row(
            children: [
              const Text('COMPLETE',style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey)),
              const SizedBox(
                width: 15,
              ),
              Container(
                height: 20.0,
                width: 20.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),),
                child: const Center(child: Text('5')),
              ),
            ],
          ),

        ],
      ),
      floatingActionButton:  FloatingActionButton(
          elevation: 0.0,
          backgroundColor:  Colors.lightBlue,
          onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>const NewThings()));

          },
          child:  const Icon(Icons.add)
      ),
    );
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

