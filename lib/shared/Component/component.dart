import 'package:flutter/material.dart';
import 'package:inkaz/shared/Cubit/AppCubit.dart';

Widget defaultTextForm({
  TextEditingController? controller,
  TextInputType? type,
  String? Function(String?)? validate,
  IconData? prefix,
  IconData? suffix,
  String? label,
  String? hint,
  void Function()? ontap,
}) =>
    TextFormField(
      cursorColor: Colors.red,
      controller: controller,
      keyboardType: type,
      validator: validate,
      onTap: ontap,
      decoration: InputDecoration(
          prefixIcon: Icon(prefix),
          suffixIcon: Icon(suffix),
          label: Text(label!),
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          hintText: hint,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    );

Widget buildChatItem(Map data , context) => Dismissible(
  key: Key(data['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.deepPurple[350],
              radius: 38,
              child: Text(
                '${data["time"]}',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data["title"]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${data["date"]}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              splashColor: Colors.greenAccent,
              onPressed: () {
                AppCubit.get(context)
                    .UpdateItem(status: 'done', id: data['id']);
              },
              icon: Icon(Icons.check_box_outlined),
              color: Colors.green,
            ),
            IconButton(
              splashColor: Colors.blueGrey[200],
              onPressed: () {
                AppCubit.get(context)
                    .UpdateItem(status: 'archive', id: data['id']);
              },
              icon: Icon(Icons.archive),
              color: Colors.black,
            ),
          ],
        ),
      ),
      background:Container(
    color: Colors.pinkAccent[200],
  ),
  onDismissed: (directional)
  {
    AppCubit.get(context).DeleteItem(id: data['id']);
  },
);
