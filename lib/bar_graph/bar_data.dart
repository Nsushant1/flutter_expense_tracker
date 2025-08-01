import 'package:expense_tracker/bar_graph/individual_bar.dart';

class BarData {

  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thursAmount;
  final double friAmount;
  final double satAmount;


  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thursAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<IndividualBar> barData=[];

  //initialize bar data
  void initializeBarData(){
    barData=[
      // Sunday
      IndividualBar(x: 0, y: sunAmount),
      // Monday
      IndividualBar(x: 1, y: monAmount),  
      // Tuesday
      IndividualBar(x: 2, y: tueAmount),
      // Wednesday
      IndividualBar(x: 3, y: wedAmount),
      // Thursday
      IndividualBar(x: 4, y: thursAmount),
      // Friday
      IndividualBar(x: 5, y: friAmount),
      // Saturday
      IndividualBar(x: 6, y: satAmount),
    ];
  }

}