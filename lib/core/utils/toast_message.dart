
import 'package:fluttertoast/fluttertoast.dart';

Future<void> toastMessage(
    {required String content}) async {
  await Fluttertoast.showToast(msg: content);
}
