import 'package:flutter/material.dart';
import 'package:loveshayari/secondpage.dart';
import 'package:loveshayari/shayarilist.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: app(),
  ));
}

class app extends StatefulWidget {
  const app({Key? key}) : super(key: key);

  @override
  State<app> createState() => _appState();
}

class _appState extends State<app> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Love Shayari"),
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return shayri(index, data.img[index]);
                  },
                ));
              },
              child: ListTile(
                tileColor: Colors.white,
                leading: Container(
                    margin: EdgeInsets.all(5),
                    child: Image(
                      image: AssetImage("${data.img[index]}"),
                    )),
                title: Text(data.catagory[index]),
              ),
            );
          },
          itemCount: data.catagory.length,
          separatorBuilder: (context, index) {
            return Divider(
              //color: Colors.white70,
              height: 5,
            );
          },
        ),
      ),
    );
  }
}
