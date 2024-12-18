import 'package:bill_management_app/model/ProductData.dart';
import 'package:bill_management_app/ui/generate_bill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../bloc/counter/counter_bloc.dart';
import '../bloc/counter/counter_state.dart';
import '../dbhelper/databaseHelper.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  List data = [];
   ScreenshotController screenshotController=ScreenshotController();

  @override
  Widget build(BuildContext context) {
    data=ModalRoute.of(context)!.settings.arguments as List;
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    print(date);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.menu),
        title: Text("Bill Details"),
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Screenshot(
                controller: screenshotController,
                child: GestureDetector(
                  onTap:() {
                     shareImage();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    color: Colors.blue,
                    child: Icon(Icons.picture_as_pdf,color: Colors.white,),
                  ),
                ),
              ),
              SizedBox(width: 5,),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GenerateBill(),));
                },
                child: Container(
                  height: 40,
                  width: 40,
                  color: Colors.blue,
                  child: Icon(Icons.edit,color: Colors.white,),
                ),
              ),
              SizedBox(width: 5,),
              GestureDetector(
                onTap: () {
                  data.clear();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  color: Colors.redAccent,
                  child: Icon(Icons.delete,color: Colors.white,),
                ),
              ),
            ],
          ),
        )],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8,),
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  color: Colors.white,
                                  width: 178,
                                  height: 50,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Text("Bill No:",style: TextStyle(color: Colors.grey),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                        child: Text('1')
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                color: Colors.white,
                                width: 178,
                                height: 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20,top: 8),
                                      child: Text("Date:",style: TextStyle(color: Colors.grey)),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                        child: Container(
                                          height: 20,
                                          child: Text(date.toString()),
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Text('Customer Name',style: TextStyle(color: Colors.grey)),
                        Text(data[0]['cname'].toString())
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Product Details:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                ),
                SizedBox(
                  child: ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 8),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey.withOpacity(0.5), width: 2),
                                  left: BorderSide(color: Colors.grey.withOpacity(0.5)))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            data[index]['iname'],
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Quantity",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          data[index]['iquantity'],
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Rate",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text(
                                        "₹"+data[index]['iprice'],
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Amount",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          "₹ "+data[index]['iamount'],
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                BlocBuilder<CounterBloc, CounterState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text("Bill Amount"),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "₹ "+state.ans.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          )
      ),
    );
  }

  shareImage() async {

    final uint8List = await screenshotController.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    String fileName ="myFile";
    if (await Permission.storage.request().isGranted) {
      File file = await File('$tempPath/$fileName.png').create();
      file.writeAsBytesSync(uint8List!);
      await Share.shareXFiles([XFile(file.path)]);
    }
  }
}
