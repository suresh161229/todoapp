import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/LoginScreen.dart';
import 'package:todoapp/Models/todomodel.dart';
import 'package:todoapp/Styles.dart';


class NewThings extends StatefulWidget {
  const NewThings( {Key? key}) : super(key: key);

  @override
  State<NewThings> createState() => _NewThingsState();
}

class _NewThingsState extends State<NewThings> {


  final TextEditingController workshopController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController notificationController = TextEditingController();

   String _dropDownValue = "Business";
   File? image;
  var pickedgalleryFile;
 var  pickedcameraFile;
   List todolist = [];
  // final ImagePicker _picker = ImagePicker();

  // @override
  // void initState() {
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,

        body:  SingleChildScrollView(
          child: Column(
            children: [
              Container(height: size.height*0.1,child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                IconButton(

                    onPressed: (){
                      Navigator.pop(context,todolist);

                }, icon:const Icon(Icons.arrow_back_rounded,color: Colors.lightBlue,)),
                Text("Add new thing",style: Styles.textStyle18,),
                IconButton(onPressed: (){}, icon: const Icon(Icons.menu,color: Colors.lightBlue,)),

              ],),),
              const SizedBox(height: 10.0,),
              SizedBox(height: size.height*0.1,
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                      border: Border.all(color: borderColor),),
                    child: Icon(statusIcon(_dropDownValue),size: 50.0,color: Colors.lightBlue,),)),
              const SizedBox(height: 20.0,),
              
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: DropdownButton(
                  dropdownColor: Colors.grey,
                  hint: _dropDownValue == "Business"
                      ?  Text('Business',style: Styles.textStyle15,)
                      : Text(
                    _dropDownValue,
                    style: Styles.textStyle15,
                  ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: const TextStyle(color: Colors.white),
                  items: ['Business', 'Suit', 'Meeting','Techno'].map(
                        (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val,style: Styles.textStyle15,),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                          () {
                        _dropDownValue = val.toString();
                      },
                    );
                  },
                ),
              ),
               Padding(
                padding:const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: workshopController,
                  style: Styles.textStyle18,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color:Clr.grey),
                      hintText: "Sketch Workshop"
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: placeController,
                  style: Styles.textStyle18,
                  decoration: InputDecoration(
                      hintStyle: Styles.textStyle15grey,
                      hintText: "Place"
                  ),
                ),
              ),
               Padding(
                padding:const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  style: Styles.textStyle18,
                  controller: timeController,
                  decoration: InputDecoration(
                      hintStyle: Styles.textStyle15grey,
                      hintText: "Time"
                  ),
                  onTap: () async{
                    var time =  await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,);
                    timeController.text = time!.format(context);

                  },
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller:notificationController,
                  style: Styles.textStyle18,
                  decoration: InputDecoration(
                      hintStyle: Styles.textStyle15grey,
                      hintText: "Notification"
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: size.height*0.06,
                  width: size.width*0.8,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child:  Text('Add Your Things',style: Styles.textStyle18,),
                    onPressed: () async{
                  var  docid  = FirebaseFirestore.instance.collection('tododata').doc().id;
                  setData(docid);
                     workshopController.clear();
                     placeController.clear();
                     timeController.clear();
                     notificationController.clear();
                      ToastMessage.successToast("You have Successfully Created Task");
                      Future.delayed(const Duration(seconds: 2)).whenComplete((){
                        return Navigator.pop(context,docid);
                      });
                    },
                  )
              ),
             const SizedBox(height: 20,),
              Container(
                  height: size.height*0.04,
                  width: size.width*0.6,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child:  Text('Logout',style: Styles.textStyle15,),
                    onPressed: () async{
                      if (kDebugMode) {
                        print(todolist.toString());
                      }
                      SharedPreferences pref = await SharedPreferences.getInstance();

                      pref.clear();
                      ToastMessage.successToast("You have Successfully logged Out");
                      Future.delayed(const Duration(seconds: 2)).whenComplete((){
                        return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                      });


                    },
                  )
              ),

            ],
          ),
        ),

      ),
    );
  }
  Future getImage()async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imagepicked = File(image.path);
      setState(() {
        this.image = imagepicked;
      });
    } on PlatformException catch (e) {
      print('failed to pick image$e');
    }
  }
  String statusEmoji(value) {
    switch (value) {
      case "Techno":
        {
          return "assets/images/musical.png";
        }
      case "Suit":
        {
          return "assets/images/tie.png";
        }
      case "Meeting":
        {
          return "assets/images/running.png";
        }
      default:
        {
          return "assets/images/editoff.png";
        }
    }
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
  void addingTaskmodel(IconData icon, String place,String notification,String time,String type,String workshop) {
    final todomodel = TodoModel(
      image: DateTime.now().toString(),
      type: type,
      place: place,
      workshop: workshop,
      notification: notification,
      time: time
    );
    setState(() {
      todolist.add(todomodel);
      print(todolist.toString());
    });
  }

  setData(docid) async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    String id = auth.currentUser!.uid;
    CollectionReference reference =  firestore.collection("tododata");
    reference.doc(docid).set({
      'type':_dropDownValue.toString(),
      'place':placeController.text.toString(),
      'work':workshopController.text.toString(),
      'time':timeController.text.toString(),
      'notification':notificationController.text.toString(),
      "id":id,
      "docid":docid

    });
  }

}
