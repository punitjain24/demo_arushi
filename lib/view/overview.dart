import 'package:demo_finmap_arushi/modal/dashboard_response.dart';
import 'package:demo_finmap_arushi/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text("Selection Overview",style: TextStyle(
            color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold
        ),),
      ),
      body: Consumer<DashboardProvider>(
        builder: (context,provider,child) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 ListView.builder(
                      shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     itemCount: provider.fields!.length,
                     itemBuilder:(context,index){
                       return Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             "Question (${index+1})-"+provider.fields![index].schema!.label!,
                             style: TextStyle(
                                 color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold
                             ),
                           ),
                           SizedBox(height: 5,),
                           Text(
                             "Answer- "+provider.allAnswers[index],
                             style: TextStyle(
                                 color: Colors.black,fontSize: 15
                             ),
                           ),
                           SizedBox(height: 20,),

                         ],
                       );
                     })
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
