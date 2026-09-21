
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news/core/Theme/app_theme.dart';

class UIUtil {
static void showErrorMessage(String?message)=>
Fluttertoast.showToast(
        msg:message?? "SomeThing is Wrong",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: AppTheme.red,
        textColor: AppTheme.white,
    
    );
static void showSuccMessage(String message)=>
Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: AppTheme.green,
        textColor: AppTheme.white,
     
    );
}