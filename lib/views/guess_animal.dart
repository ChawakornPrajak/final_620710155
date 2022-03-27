import 'dart:async';
import 'package:flutter/material.dart';
import 'package:final_620710155/models/animal.dart';
import 'package:final_620710155/services/api.dart';
class Guessanimal extends StatefulWidget {
  const Guessanimal({Key? key}) : super(key: key);

  @override
  _GuessanimalState createState() => _GuessanimalState();
}

class _GuessanimalState extends State<Guessanimal> {
  List<Animal>? _animalList ;
  var loading = true;
  var index = 0;
  var check = "";
  var wrong = 0;
  @override
  void initState() {
    super.initState();
    _fetchAnimal();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading? isloading(): index<_animalList!.length-1? quizzespage():newpage()
      );
  }
  Widget isloading(){
    return const Center(child: CircularProgressIndicator());
  }
  Widget quizzespage(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.network(_animalList![index].image,fit: BoxFit.cover,),
        Column(
          children: [
            for(int i=0;i<_animalList![index].choices.length;i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              if(_animalList![index].choices[i]==_animalList![index].answer)
                                check="ถูกครับ";
                              else
                                check="ผิดครับ";
                            });
                            Timer(Duration(seconds: 2),(){
                              setState(() {
                                if(check=="ถูกครับ")
                                    index++;
                                else
                                  wrong++;
                                  check="";
                              });
                            });
                          },
                          child:Text(_animalList![index].choices[i])),
                    )
                  ],
                ),
              ),
          ],
        ),
        if(check.length==0)
          SizedBox(height: 30,width: 1,),
        if(check.length!=0)
          Text(check)
      ],);
  }
  void _fetchAnimal() async {
    List list = await Api().fetch('quizzes');
    setState(() {
      _animalList = list.map((item) => Animal.fromJson(item)).toList();
      loading = false;
    });
  }
  Widget newpage()
  {
    return Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text("จบเกมแล้วครับ"),
         ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text("ทายผิด ${wrong} ครั้ง"),
         ),
         ElevatedButton(onPressed: (){
           setState(() {
             index = 0;
             check = "";
             wrong = 0;
             loading = true;
             _animalList = null;
             _fetchAnimal();
           });
         }, child: Text("เริ่มใหม่"))
       ],
      ),);
  }
}
