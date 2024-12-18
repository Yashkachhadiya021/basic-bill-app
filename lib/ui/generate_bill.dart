import 'package:bill_management_app/dbhelper/Helper.dart';
import 'package:bill_management_app/model/ProductData.dart';
import 'package:bill_management_app/ui/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter/counter_bloc.dart';
import '../bloc/counter/counter_event.dart';
import '../bloc/counter/counter_state.dart';
import '../dbhelper/databaseHelper.dart';

class GenerateBill extends StatefulWidget {
  const GenerateBill({super.key});

  @override
  State<GenerateBill> createState() => _GenerateBillState();
}

class _GenerateBillState extends State<GenerateBill> {
//  Helper helper=Helper();
  DatabaseHepler databaseHepler = DatabaseHepler.instance;
  int amount=0;
  List _items = [];
  bool _isLoading = true;
  void _refreshproduct() async {
    final data=await databaseHepler.readItems();
    setState(() {
      _items=data;
      _isLoading=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshproduct();
  }
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerMobileController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemQuantityController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  final TextEditingController _itemAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    print(date);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.menu),
        title: Text("Generate Bill"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.settings),
          )
        ],
      ),
      body: _isLoading ?  Center(
        child: CircularProgressIndicator(),
      ) : SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
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
                                  // Padding(
                                  //   padding: const EdgeInsets.only(left: 20),
                                  //   child: Text("Bill No:"),
                                  // ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 8, 10, 0),
                                    child: Container(
                                        height: 40,
                                        child: Text("Bill No: 1")//+_items[0]['id'].toString()),
                                        // child: TextField(
                                        //   decoration: InputDecoration(
                                        //       border: OutlineInputBorder(),
                                        //       hintText: "Bill No."),
                                        // )
                                      ),
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
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 8),
                                  child: Text("Date:"),
                                ),
                                Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                    child: Container(
                                      height: 20,
                                      child: Text(date.toString()),
                                    ))
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
              height: 70,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _customerNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Customer Name"),
                ),
              ),
            ),
            Container(
              height: 70,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _customerMobileController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Customer Mobile Number"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Product Details:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            SizedBox(
              child: ListView.builder(
                itemCount: _items.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {

                    amount = int.parse(_items[_items.length-1]['iamount']);
                   // print(amount.toString());
                    //context.read<CounterBloc>().add(Addition(no1: amount,));

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
                                          _items[index]['iname'],
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          productDialog(_items[index]['id']);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 60,
                                          color: Colors.blue,
                                          child: Center(
                                              child: Text(
                                                "Edit",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _deleteItem(_items[index]['id']);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 60,
                                          color: Colors.redAccent,
                                          child: Center(
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
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
                                        _items[index]['iquantity'],
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
                                      "₹"+_items[index]['iprice'],
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
                                        "₹ "+_items[index]['iamount'],
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 40,
                width: double.infinity,
                color: Color(0xFF5CB85C),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF5CB85C)),
                    onPressed: () {
                      if(_customerNameController.text=="" && _customerMobileController.text=="" ){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Enter Name & Contact!"))
                        );
                      }
                      else {
                        productDialog(null);
                      }
                    },
                    child: Text(
                      "Add Products",
                      style: TextStyle(color: Colors.white),
                    )),
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

                            //_items.fold("0", (sum, ProductData) => sum + productData.iamount),
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
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 40,
          width: double.infinity,
          color: Colors.blue,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(),
                      settings: RouteSettings(arguments: _items)
                    ));
              },
              child: Text(
                "Save Bill",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }
  void productDialog(int? id) async{
    if(id != null){
      final existinguser= _items.firstWhere((element) => element['id']==id,);
      _itemNameController.text=existinguser['iname'];
      _itemQuantityController.text=existinguser['iquantity'];
      _itemPriceController.text=existinguser['iprice'];
    }
    showDialog(context: context, builder: (context){
      int a=0;
      int b=0;
      int c=0;
      _itemAmountController.text=c.toString();
      return Dialog(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: _itemNameController, decoration: const InputDecoration(helperText: "Item Name"),),
                TextField(
                    controller: _itemQuantityController,
                    onChanged: (value) {
                      a=int.parse(value);
                    },
                    decoration: const InputDecoration(
                        helperText: "Item Quantity"
                    )
                ),
                TextField(
                    controller: _itemPriceController,
                    onChanged: (value) {
                      b=int.parse(value);
                    },
                    decoration: const InputDecoration(helperText: "Item Price")
                ),
                TextField(
                    controller: _itemAmountController,
                    readOnly: true,
                    onTap: () {
                      c=a*b;
                      print(c.toString());
                      _itemAmountController.text=c.toString();
                    },
                    decoration: const InputDecoration(helperText: "Item Amount")
                ),
                const SizedBox(height: 10,),
                ElevatedButton(onPressed: ()async{
                  if( _itemNameController.text=="" && _itemQuantityController.text=="" && _itemPriceController.text=="" && _itemAmountController.text=="0"){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please Enter data!"))
                    );
                  }
                  else {
                    if (id == null) {
                      await _addItem();
                      print("success");
                      context.read<CounterBloc>().add(Addition(no1: amount,));
                    }
                  }
                  if(id != null){
                    await _updateItem(id);
                    context.read<CounterBloc>().add(Addition(no1: amount,));
                  }
                  _itemAmountController.text=c.toString();
                  _itemNameController.text='';
                  _itemQuantityController.text='';
                  _itemPriceController.text='';
                  Navigator.pop(context);
                }, child: Text(id == null ?"Add Product": "Upadte"))
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> _addItem() async {
    ProductData pdata =
    ProductData(cname: _customerNameController.text,
        cmobile: _customerMobileController.text,
        iname: _itemNameController.text,
        iquantity: _itemQuantityController.text,
        iprice: _itemPriceController.text,
        iamount: _itemAmountController.text);

    await databaseHepler.insertItem(pdata);
      //amount= int.parse(pdata.iamount);
      print("data::" + pdata.toString());
    _refreshproduct();
  }
  void _deleteItem(int id) async {
    await databaseHepler.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sucessfully deleted User!"))
    );
    _refreshproduct();
  }
  Future<void> _updateItem(int id) async {
    await databaseHepler.updateItem(
         id,
        _itemNameController.text,
        _itemQuantityController.text,
        _itemPriceController.text,
      _itemAmountController.text
    );
    _refreshproduct();
  }

}
