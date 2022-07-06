import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Widget? trailing;

  const ListWidget({Key? key, this.title, this.subTitle, this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
            BoxShadow(
              offset: Offset(0, 0.5),
            ),
          ],
          color: Colors.white,
        ),
        child: ListTile(
          title: Text(title!),
          subtitle: Text(
            subTitle!,
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          trailing: trailing
        ),
      ),
    );
  }
}
