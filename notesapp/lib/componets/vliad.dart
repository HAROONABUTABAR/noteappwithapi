import 'package:notesapp/constant/mesage.dart';

validInput(String val, int min, int max) {
  if (val.isEmpty) {
    // ignore: unnecessary_string_interpolations
    return "$messageInputEmpty";
  }
  if (val.length < min) {
    return "$messageInputMin $min";
  }
  if (val.length > max) {
    return "$messageInputMax $max";
  }
}
