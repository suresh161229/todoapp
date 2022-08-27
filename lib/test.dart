//
// import 'package:flutter/material.dart';
// import 'package:todoapp/OperationsPage.dart';
//
// // ignore: must_be_immutable
// class OperationsPage extends StatelessWidget {
//    OperationsPage({Key? key,required this.data,required this.index}) : super(key: key);
//   List data;
//   int index;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SizedBox(
//           child: Table(
//             border: TableBorder.all(),
//             children: [
//               TableRow(
//                   children: [
//                     Center(child: Text(data[index]['type'].toString(),textScaleFactor: 1.5,)),
//                     Center(child: Text(data[index]['place'].toString(),textScaleFactor: 1.5,)),
//                     Center(child: Text(data[index]['work'].toString(),textScaleFactor: 1.5,)),
//                     Center(child: Text(data[index]['time'].toString(),textScaleFactor: 1.5,)),
//                     Center(child: Text(data[index]['notification'].toString(),textScaleFactor: 1.5,)),
//                    Center(child:Row(
//                      children: [
//                        IconButton(onPressed: (){
//                          Navigator.push(context, MaterialPageRoute(builder: (context)=> OperationsPage2(data: data,index: index,)));
//                        }, icon: const Icon(Icons.edit,size: 16.0,)),
//                        IconButton(onPressed: (){
//                          Navigator.push(context, MaterialPageRoute(builder: (context)=> OperationsPage2(data: data,index: index,)));
//
//                        }, icon: const Icon(Icons.delete,size: 16.0,)),
//                      ],
//                    ))
//                   ]
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   // icons(function1,function2){
//   //   return
//   // }
//
//   // editText(){
//   // Navigator.push(context, MaterialPageRoute(builder: (context)=>const OperationsPage2()));
//   // }
//   // bool isDeletted = false;
//   // deleteText(){
//   //
//   // }
// }
//
