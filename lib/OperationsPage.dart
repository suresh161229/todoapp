import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:todoapp/Styles.dart';

// ignore: must_be_immutable
class OperationsPage extends StatefulWidget {
   OperationsPage({Key? key,required this.data,required this.index}) : super(key: key);
List data;
int index;

  @override
  State<OperationsPage> createState() => _OperationsPageState();
}

class _OperationsPageState extends State<OperationsPage> {
  bool showProgress = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
 late TextEditingController businessController;
  late TextEditingController placeController ;
  late TextEditingController timeController ;
  late TextEditingController workController ;
  late TextEditingController notificationController ;
  @override
  initState(){
    super.initState();
    //for(int i = 0;i<=widget.data.length;i++)
      businessController = TextEditingController(text: widget.data[widget.index]['type']);
      placeController = TextEditingController(text: widget.data[widget.index]['place']);
      workController = TextEditingController(text: widget.data[widget.index]['work']);
      timeController = TextEditingController(text: widget.data[widget.index]['time']);
      notificationController = TextEditingController(text: widget.data[widget.index]['notification']);


  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0,right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                space3(),
                TextField(
                  controller: businessController,
                  decoration: InputDecoration(
                      hintText: widget.data[widget.index]['type'],
                      labelText: "Type",
                      border:const OutlineInputBorder()
                  ),
                  autofocus: true,
                  onSubmitted: (String value)  {
                    setState((){
                      businessController.text = value;
                    });

                  },

                ),
                space(),
                TextField(
                  controller: placeController,
                  decoration: InputDecoration(
                      hintText: widget.data[widget.index]['place'],
                      labelText: "Place",
                      border:const OutlineInputBorder()
                  ),
                  autofocus: true,
                  onSubmitted: (String value)  {
                    setState((){
                      placeController.text = value;
                    });

                  },

                ),
                space(),
                TextField(
                  controller: workController,
                  decoration: InputDecoration(
                      hintText: widget.data[widget.index]['work'],
                      labelText: "Work",
                      border:const OutlineInputBorder()
                  ),
                  autofocus: true,
                  onSubmitted: (String value)  {
                    setState((){
                      workController.text = value;
                    });

                  },

                ),
                space(),
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(
                      hintText: widget.data[widget.index]['time'],
                      labelText: "Time",
                      border:const OutlineInputBorder()
                  ),
                  autofocus: true,
                  onSubmitted: (String value)  {
                    setState((){
                      timeController.text = value;
                    });

                  },

                ),
                space(),
                TextField(
                  controller: notificationController,
                  decoration: InputDecoration(
                      hintText: widget.data[widget.index]['notification'],
                      labelText: "Notification",
                      border:const OutlineInputBorder()
                  ),
                  autofocus: true,
                  onSubmitted: (String value)  {
                    setState((){
                      notificationController.text = value;
                    });

                  },

                ),
                space3(),
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    horSpace(),
                    Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: borderColor.withOpacity(0.2),
                          )),
                      child: TextButton(
                          onPressed: (){
                            print('docid---'+widget.data[widget.index]['docid'].toString());
                            updateTask(widget.data[widget.index]['docid']);
                            ToastMessage.successToast('You have Successfully Updated Details');
                            Future.delayed(const Duration(seconds: 1)).whenComplete((){
                              return Navigator.pop(context);
                            });
                      },
                          child:const Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:  Text('Update'),
                          )),
                    ),
                    horSpace(),
                    Container(
                      decoration: BoxDecoration(
                          color: errorColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: borderColor.withOpacity(0.2),
                          )),
                      child: TextButton(
                          onPressed: (){
                            deleteTask(widget.data[widget.index]['docid']);
                            ToastMessage.successToast('You have Successfully Deleted Details');
                            Future.delayed(const Duration(seconds: 2)).whenComplete((){
                              return Navigator.pop(context);
                            });
                      },
                          child:const Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:  Text('Delete'),
                          )),
                    ),
                    horSpace()
                  ],
                ),

            ],
            ),
          ),
        ),
      ),
    );

  }
  Widget space(){
    Size size = MediaQuery.of(context).size;

    return SizedBox(height: size.height*0.01,);
  }
 Widget space3(){
   Size size = MediaQuery.of(context).size;

   return SizedBox(height: size.height*0.03,);
 }
 Widget horSpace(){
   Size size = MediaQuery.of(context).size;

   return SizedBox(height: size.width*0.1,);
 }
 void deleteTask(id)async{
   await firestore.collection('tododata').doc(id).delete();
 }
 void updateTask(id)async{
   await  firestore.collection('tododata').doc(id).update({
     "notification":notificationController.text.toString(),
     "time":timeController.text.toString(),
     "work":workController.text.toString(),
     "type":businessController.text.toString(),
     "place":placeController.text.toString()
   });
 }

}
