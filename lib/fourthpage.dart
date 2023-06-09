import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:loveshayari/shayarilist.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:external_path/external_path.dart';

class theme extends StatefulWidget {
  String shay;
  int CI;

  theme(this.shay, this.CI);

  @override
  State<theme> createState() => _themeState();
}

class _themeState extends State<theme> {
  List<Color> myclr = [];
  List Emogi = [];
  bool cont_status = false,
      textstatus = false,
      backstatus = false,
      emostatus = false;
  Color clr = Colors.red, textclr = Colors.black;
  int clr_ind = 0, text_ind = 0, back_ind = 0, emo_ind = 0;
  double textsize = 20, a = 20;
  List Font = [
    "f1",
    "f2",
    "f3",
    "f4",
    "f5",
    "f6",
    "f7",
    "f8",
    "f9",
    "f10",
  ];
  String ff = "f1";
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;

  @override
  initState() {
    super.initState();
    getData();
    myclr.addAll(data.mycolor);
    Emogi.addAll(data.myEmogi);
  }

  getData() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
      //print(statuses[Permission.location]);
    }
  }

  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    double appbarheight = kToolbarHeight;
    double total = statusBarHeight + appbarheight;
    double height = MediaQuery.of(context).size.height - total;

    //double cont = MediaQuery.of(context).size.width ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Write Shayari"),
      ),
      body: Column(
        children: [
          WidgetsToImage(
            controller: controller,
            child: Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Text(
                  "${(emostatus == false ? data.myEmogi[widget.CI] : data.myEmogi[emo_ind])} "
                  "${widget.shay} "
                  "${(emostatus == false ? data.myEmogi[widget.CI] : data.myEmogi[emo_ind])}",
                  style: TextStyle(
                    fontFamily: ff,
                    fontSize: textsize,
                    color: (textstatus == false) ? textclr : myclr[text_ind],
                  ),
                ),
              ),
              alignment: Alignment.center,
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: (backstatus == false)
                    ? (cont_status == false)
                        ? clr
                        : null
                    : myclr[back_ind],
                //   decoration: BoxDecoration(
                //     color: (status == false) ? clr : data.mycolor[back_ind],
                gradient: (cont_status == true)
                    ? LinearGradient(
                        colors: [myclr[clr_ind], myclr[clr_ind + 1]])
                    : null,
              ),
            ),
          ),

          Spacer(),
          Container(
            color: Colors.black,
            margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 25,
                  width: 70,
                  color: Colors.white,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          clr_ind++;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("image/reload.png"),
                              ),
                              color: Colors.white),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Container(
                                  margin: EdgeInsets.all(5),
                                  color: Colors.white,
                                  height: height,
                                  child: GridView.builder(
                                    itemCount: 10,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 5),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {});
                                          cont_status = true;
                                          clr_ind = index;
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${data.myEmogi[widget.CI]}"
                                            "\nLove Shayari "
                                            "\n${data.myEmogi[widget.CI]}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                myclr[index],
                                                myclr[index + 1],
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              });
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("image/expand.png"),
                              ),
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black,
            margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 120,
                            child: Row(mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: GridView.builder(
                                      itemCount: myclr.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 10),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {});
                                            backstatus = true;
                                            back_ind = index;
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            height: 30,
                                            width: 30,
                                            color: myclr[index],
                                          ),
                                        );
                                      }),
                                ),
                                InkWell(onTap: () {
                                  Navigator.pop(context);
                                },
                                  child: Container(alignment: Alignment.center,
                                    margin: EdgeInsets.all(5),
                                    height: 30,
                                    width: 30,
                                    child: Text("X",style: TextStyle(fontSize: 25,color: Colors.white),),
                                    decoration: BoxDecoration(color: Colors.red,shape: BoxShape.circle),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    height: 20,
                    width: 80,
                    color: Colors.red,
                    child: Text(
                      "Background",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 120,
                            child: Row(mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child
                                      : GridView.builder(
                                      itemCount: myclr.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 10),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            textstatus = true;
                                            text_ind = index;
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            height: 30,
                                            width: 30,
                                            color: myclr[index],
                                          ),
                                        );
                                      }),
                                ),
                                InkWell(onTap: () {
                                  Navigator.pop(context);
                                },
                                  child: Container(alignment: Alignment.center,
                                    margin: EdgeInsets.all(5),
                                    height: 30,
                                    width: 30,
                                    child: Text("X",style: TextStyle(fontSize: 25,color: Colors.white),),
                                    decoration: BoxDecoration(color: Colors.red,shape: BoxShape.circle),
                                  ),
                                )
                              ],
                            ),

                          );
                        });
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    height: 20,
                    width: 80,
                    color: Colors.red,
                    child: Text(
                      "Text Color",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    //Share.share("${widget.shay}");
                    bytes != null ? Image.memory(bytes!) : Text("");
                    bytes = await controller.capture();
                    var path =
                        await ExternalPath.getExternalStoragePublicDirectory(
                            ExternalPath.DIRECTORY_DOWNLOADS);
                    Directory dir = Directory(path);

                    if (!await dir.exists()) {
                      dir.create();
                    }

                    int Ran = Random().nextInt(100);
                    String image_name = "img${Ran}.jpg";

                    File F = File("$path/$image_name");
                    await F.writeAsBytes(bytes!);
                    //print(F.path);
                    Share.shareFiles(
                      ["${F.path}"],
                    );
                    //print(bytes);
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    height: 20,
                    width: 80,
                    color: Colors.red,
                    child: Text(
                      "Share",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black,
            margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                            height: 100,
                            color: Colors.white,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Font.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    ff = Font[index];
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 100,
                                    color: Colors.red,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      "Shayari",
                                      style: TextStyle(fontFamily: Font[index]),
                                    ),
                                  ),
                                );
                              },
                            ));
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    height: 20,
                    width: 80,
                    color: Colors.red,
                    child: Text(
                      "Font",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    emostatus = true;
                                    emo_ind = index;
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    title: Text("${data.myEmogi[index]}"),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  height: 2,
                                  color: Colors.black,
                                );
                              },
                              itemCount: data.myEmogi.length),
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    height: 20,
                    width: 80,
                    color: Colors.red,
                    child: Text(
                      "Emogi",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState1) {
                            return Container(
                              height: 100,
                              color: Colors.white,
                              child: Slider(
                                value: a,
                                min: 20,
                                max: 50,
                                onChanged: (value) {
                                  a = value;
                                  textsize = value;
                                  setState1(() {
                                    setState(() {});
                                  });
                                },
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    height: 20,
                    width: 80,
                    color: Colors.red,
                    child: Text(
                      "Text Size",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //SizedBox(height: 10,),
        ],
      ),
    );
  }
}
