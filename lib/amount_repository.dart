class AmountRepository {
  int grandTot=0;
  add({required int no1,}) {
    grandTot=grandTot+no1;
  return grandTot;
}

// subtract({required int no1, required int no2}) {
//   return no1 - no2;
// }
//
// multiply({required int no1, required int no2}) {
//   return no1 * no2;
// }
//
// divide({required int no1, required int no2}) {
//   return no1 / no2;
// }
}