//https://newsapi.org/v2/everything?q=tesla&apiKey=0c53f0968a1a46f09dd4
// dd8dfec494cc
import '../../layout/cubit/cubit.dart';
import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

String? uid;
String? token;
bool? isOpened = false; // عشان لما يفتح علي login ميعملش get مرتين

void signOut(context){
  CacheHelper.removeData(key: 'token')?.then((value) {
      isOpened = true;
      navigateAndFinish(context,LoginScreen());
  }).catchError((error){
    print(error.toString());
  });
}
