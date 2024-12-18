class ProductData {
  final int? id;
  final String cname;
  final String cmobile;
  final String iname;
  final String iquantity;
  final String iprice;
  final String iamount;

  ProductData({this.id, required this.cname, required this.cmobile, required this.iname,required this.iprice,required this.iquantity,required this.iamount});

  Map<String, dynamic> toMap() {
    return {'id': id, 'cname': cname, 'cmobile': cmobile,'iname':iname,'iquantity':iquantity,'iprice':iprice,'iamount':iamount};
  }

  factory ProductData.fromMap(Map<String, dynamic> map) {
    return ProductData(
      id: map['id'],
      cname: map['cname'],
      cmobile: map['cmobile'],
      iname: map['iname'],
      iquantity: map['iquantity'],
      iprice: map['iprice'],
      iamount: map['iamount']
    );
  }

  @override
  String toString() {
    return 'ProductData{id: $id, cname: $cname, cmobile: $cmobile,iname: $iname,iquantity:$iquantity,iprice:$iprice,iamount:$iamount}';
  }
}
