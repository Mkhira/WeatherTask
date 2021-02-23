



import 'package:rflutter_alert/rflutter_alert.dart';

onCustomAnimationAlertPressed(context,String title,String des) {
  Alert(
    context: context,
    title: "$title",
    desc: "$des",
  ).show();
}