
 import 'package:chatapp/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'const.dart';


 Widget buildTextFormField({
   required String hint,
   required String label,
   Function(String)? onChanged,
   bool isPassword = false,

 }) => TextFormField(
   obscureText: isPassword,
       decoration: InputDecoration(
         label: Text(label,
           style: const TextStyle(color: Colors.white),),
         hintText: hint,
         border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
           borderSide: const BorderSide(
             color: Colors.white,
           ),
         ),
         enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
           borderSide: const BorderSide(
             color: Colors.white,
           ),
         ),
       ),
   onChanged:onChanged,
   validator: (value) {
     if (value!.isEmpty){
       return "Field is Required";
     }
   },
     );







Widget buildBottom ({
   required String label,
   required VoidCallback onTap,
 }) =>InkWell(
  onTap: onTap ,
  child: Container(
    width: double.infinity,
    height: 60,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
      color: Colors.white,),
    child: Center(child: Text(
      "$label",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color:Color(0xff2B475e) ,
      ),
    ),),
  ),
);





 class ChatWidget extends StatelessWidget {
    const ChatWidget({
     Key? key,
     required this.message,
   }) : super(key: key);

   final Message message;
   @override
   Widget build(BuildContext context) {
     return Align(
       alignment: Alignment.centerLeft,
       child: Container(
         margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
         padding: const EdgeInsets.all(16),
         decoration: const BoxDecoration(
           color: KPrimaryColor,
           borderRadius: BorderRadius.only(
             topLeft: Radius.circular(32),
             topRight: Radius.circular(32),
             bottomRight: Radius.circular(32),
           ),
         ),
         child: Text(
           message.message,
           style: const TextStyle(
             color: Colors.white,
           ),
         ),
       ),
     );
   }
 }


 class ChatWidgetFriend extends StatelessWidget {
   const ChatWidgetFriend({
     Key? key,
     required this.message,
   }) : super(key: key);

   final Message message;
   @override
   Widget build(BuildContext context) {
     return Align(
       alignment: Alignment.centerRight,
       child: Container(
         margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
         padding: const EdgeInsets.all(16),
         decoration: const BoxDecoration(
           color: Colors.orange,
           borderRadius: BorderRadius.only(
             topLeft: Radius.circular(32),
             topRight: Radius.circular(32),
             bottomLeft: Radius.circular(32),
           ),
         ),
         child: Text(
           message.message,
           style: const TextStyle(
             color: Colors.white,

           ),
         ),
       ),
     );
   }
 }










Widget buildTextField ({
   Function (String)? onChange,
  TextEditingController? controller ,
  required VoidCallback onPressed,

}) =>TextField(
  controller: controller,
     onChanged: onChange ,
     decoration: InputDecoration(
       enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(16) ,
           borderSide: const BorderSide(color: KPrimaryColor)
       ),
       border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(16) ,
           borderSide: const BorderSide(color: KPrimaryColor)
       ),
       suffixIcon:  IconButton( icon: Icon(Icons.send),
       onPressed: onPressed ,
       ),
       hintText: "Send Message",
     ),
   );


