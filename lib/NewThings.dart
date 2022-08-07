import 'package:flutter/material.dart';
import 'package:todoapp/Styles.dart';


class NewThings extends StatefulWidget {
  const NewThings({Key? key}) : super(key: key);

  @override
  State<NewThings> createState() => _NewThingsState();
}

class _NewThingsState extends State<NewThings> {


  final TextEditingController workshopController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController notificationController = TextEditingController();
  // final TextEditingController workshopController = TextEditingController();
  // final TextEditingController workshopController = TextEditingController();
   String? _dropDownValue;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo,

        body:  Column(
          children: [
            Container(height: size.height*0.1,child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              IconButton(

                  onPressed: (){
                    Navigator.pop(context);

              }, icon:const Icon(Icons.arrow_back_rounded,color: Colors.lightBlue,)),
              Text("Add new thing",style: Styles.textStyle18,),
              IconButton(onPressed: (){}, icon: const Icon(Icons.menu,color: Colors.lightBlue,)),

            ],),),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: DropdownButton(
                dropdownColor: Colors.grey,
                hint: _dropDownValue == null
                    ?  Text('Business',style: Styles.textStyle15,)
                    : Text(
                  _dropDownValue!,
                  style: const TextStyle(color: Colors.white),
                ),
                isExpanded: true,
                iconSize: 30.0,
                style: const TextStyle(color: Colors.white),
                items: ['Business', 'Sports', 'Information','Manufacturing'].map(
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
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                  },
                )
            ),
          ],
        ),

      ),
    );
  }
}
