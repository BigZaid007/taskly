import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  InputField({Key? key,required this.inputLabel,required this.textType,this.textEditingController,this.widget,this.onTap}) : super(key: key);
  final String textType;
  final String inputLabel;
  final TextEditingController? textEditingController;
  final Widget?widget;
  final Function()?onTap;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(textType,style:GoogleFonts.roboto(
              fontSize: 22,fontWeight: FontWeight.w900
            )),
          ),
          const SizedBox(height: 3,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 52,
            decoration: BoxDecoration(
              //color: Colors.red,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey
              )
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                    ),

                    onTap: onTap,

                    controller: textEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 10),
                      //suffixIcon: widget,
                      hintText: inputLabel,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    child: widget,
                  ),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
