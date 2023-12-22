import 'package:demo_finmap_arushi/provider/dashboard_provider.dart';
import 'package:demo_finmap_arushi/view/overview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../modal/dashboard_response.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DashboardProvider? provider;
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider=Provider.of<DashboardProvider>(context,listen: false);
      provider!.getDashboardData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("About loan",style: TextStyle(
              color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold
          ),),
        ),
        body: Consumer<DashboardProvider>(
          builder: (context,provider,child){
            if(provider.isLoading==false){
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*1,
                      width: MediaQuery.of(context).size.width*1,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Container(
                              height: 3,
                              width: MediaQuery.of(context).size.width*1,
                              child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                  itemCount: provider.allAnswers.length,
                                  itemBuilder:(context,index){
                                    return Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: MediaQuery.of(context).size.width*0.25,
                                      height: 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: provider.allAnswers[index].isNotEmpty?Colors.green:Colors.grey
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            provider.fields![provider.labelIndex].schema!.label??"",
                            style: TextStyle(
                                color: Colors.black,fontSize: 15
                            ),
                          ),
                          SizedBox(height: 5,),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:provider.options![provider.labelIndex].length,
                              itemBuilder:(context,index){
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  width: MediaQuery.of(context).size.width*1,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                          (provider.options![provider.labelIndex][index].value==provider.allAnswers[provider.labelIndex])?
                                          Colors.deepOrangeAccent: Colors.grey),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: provider.options![provider.labelIndex][index].value,
                                          groupValue:provider.allAnswers[provider.labelIndex],
                                          activeColor: Colors.deepOrangeAccent,
                                          onChanged: (val){
                                            print(val);
                                            provider.setFlag(val!,provider.labelIndex);
                                          }),
                                      SizedBox(width: 20,),
                                      Text(provider.options![provider.labelIndex][index].value??"",
                                      style: TextStyle(
                                        color:
                                        (provider.options![provider.labelIndex][index].value==provider.allAnswers[provider.labelIndex])
                                            ?Colors.deepOrangeAccent: Colors.grey,
                                      ),
                                      ),
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed:(){
                              if(provider.labelIndex>0){
                                provider.previousQuestion();
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.arrow_back_ios,color: Colors.black,size: 17,),
                                Text("Back",style: TextStyle(
                                    color: Colors.black,fontWeight: FontWeight.normal
                                ),)
                              ],
                            )
                        ),
                        FloatingActionButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          onPressed: (){
                            if(provider.labelIndex<provider.fields!.length-1){
                              provider.nextQuestion();
                            }
                            else{
                              Navigator.push(context, MaterialPageRoute(builder:(context)=>Overview()));
                            }
                          },
                          backgroundColor: Colors.amber,
                          child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                        )
                      ],
                    )
                  ],
                ),
              );
            }
            else{
              return Center(child: CircularProgressIndicator(),);
            }

          },
        )
    );
  }
}
