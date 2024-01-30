
extension SerializeName on String{
  String serialize(){
    return "${substring(0,1).toUpperCase()}${substring(1).toLowerCase()}";
  }
}