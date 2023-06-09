import 'package:flutter/material.dart';
import 'package:loveshayari/shayarilist.dart';
import 'package:loveshayari/thirdpage.dart';

class shayri extends StatefulWidget {
  int index;
  String im;

  shayri(this.index, this.im);

  @override
  State<shayri> createState() => _shayriState();
}

class _shayriState extends State<shayri> {
  List sh = [];

  @override
  void initState() {
    super.initState();

    if (widget.index == 0) {
      sh.addAll(data.shubh);
    } else if (widget.index == 1) {
      sh.addAll(data.dosti);
    } else if (widget.index == 2) {
      sh.addAll(data.majedar);
    } else if (widget.index == 3) {
      sh.addAll(data.god);
    } else if (widget.index == 4) {
      sh.addAll(data.prerna);
    } else if (widget.index == 5) {
      sh.addAll(data.shubh);
    } else if (widget.index == 6) {
      sh.addAll(data.jivan);
    } else if (widget.index == 7) {
      sh.addAll(data.mahobbat);
    } else if (widget.index == 8) {
      sh.addAll(data.yade);
    } else if (widget.index == 9) {
      sh.addAll(data.other);
    } else if (widget.index == 10) {
      sh.addAll(data.rajneeti);
    } else if (widget.index == 11) {
      sh.addAll(data.love);
    } else if (widget.index == 12) {
      sh.addAll(data.dard);
    } else if (widget.index == 13) {
      sh.addAll(data.sharab);
    } else if (widget.index == 14) {
      sh.addAll(data.bewafa);
    } else if (widget.index == 15) {
      sh.addAll(data.birthday);
    } else if (widget.index == 16) {
      sh.addAll(data.holi);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Love Shayari"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return thirdPage(sh, index);
                  },
                ));
              },
              child: ListTile(
                title: Text(maxLines: 2,
                  "${data.myEmogi[index]} ${sh[index]} ${data.myEmogi[index]}",
                ),
                tileColor: Colors.pink,
                leading: Container(
                    margin: EdgeInsets.all(5),
                    child: Image(image: AssetImage("${widget.im}"))),
              ),
            ),
          );
        },
        itemCount:sh.length,
        separatorBuilder: (context, index) {
          return Divider(
            height: 0,
            color: Colors.white,
          );
        },
      ),
    );
  }
}
