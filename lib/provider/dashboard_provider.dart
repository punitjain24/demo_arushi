import 'dart:convert';

import 'package:demo_finmap_arushi/modal/dashboard_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class DashboardProvider extends ChangeNotifier{
 DashboardResponse? dashboardResponse;
 List<Fields>? fields=[];
 List<List<Options>>? options=[];
 List<String> allAnswers=[];

 int labelIndex=0;
 bool isLoading=true;

 void getDashboardData()async{
  isLoading=true;
  final response=await rootBundle.loadString('asset/question.json');
  final result=jsonDecode(response);
  dashboardResponse=DashboardResponse.fromJson(result);
  dashboardResponse!.schema!.fields;
    dashboardResponse!.schema!.fields!.forEach((element) {
     if(element.schema!.options!=null){
      fields!.add(element);
     }
    });

  isLoading=false;
   extractOptionList(fields);
  notifyListeners();
 }





 void extractOptionList(List<Fields>? data1){
  for(int i=0;i<data1!.length;i++){
   if(data1[i].schema!.options!=null){
    options!.add(data1[i].schema!.options!);
   }
   allAnswers.add("");
  }

  notifyListeners();
 }
 void setFlag(String val,int index){
  allAnswers[index]=val;
  notifyListeners();
 }
 void nextQuestion(){
  ++labelIndex;
  notifyListeners();
 }
 void previousQuestion(){
  --labelIndex;
  notifyListeners();
 }

}