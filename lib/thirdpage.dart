import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:loveshayari/fourthpage.dart';
import 'package:loveshayari/shayarilist.dart';
import 'package:share_plus/share_plus.dart';

class thirdPage extends StatefulWidget {
  List Shayari_list = [];
  int Sh_ind;

  thirdPage(this.Shayari_list, this.Sh_ind);

  @override
  State<thirdPage> createState() => _thirdPageState();
}

class _thirdPageState extends State<thirdPage> {
  @override
  PageController? controller;
  List<Color> myclr = [];
  List Emogi = [];
  bool status = false;
  Color clr = Colors.pink;
  int clr_ind = 0;
  bool gra = false;

  @override
  initState() {
    super.initState();
    controller = PageController(initialPage: widget.Sh_ind);
    myclr.addAll(data.mycolor);
    Emogi.addAll(data.myEmogi);
    //Emogi.shuffle();
    //myclr.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    double appbarheight = kToolbarHeight;
    double total = statusBarHeight + appbarheight;
    double height = MediaQuery.of(context).size.height - total;

    return Scaffold(
      appBar: AppBar(
        title: Text("Love Shayari"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                                  status = true;
                                  clr_ind = index;
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${data.myEmogi[widget.Sh_ind]}"
                                    "\nLove Shayari "
                                    "\n${data.myEmogi[widget.Sh_ind]}",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
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
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 0),
                    image: DecorationImage(
                      image: AssetImage("image/expand.png"),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child:
                    Text("${widget.Sh_ind + 1}/${widget.Shayari_list.length}"),
                margin: EdgeInsets.all(5),
                height: 30,
                width: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                //color: Colors.green,
              ),
              InkWell(onTap: () {
                if(clr_ind<=myclr.length)
                  {
                    status=true;
                    clr_ind++;
                    if(clr_ind==myclr.length)
                      {
                        clr_ind=0;
                      }
                    setState(() {

                    });
                  }

                setState(() {});
              },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 0),
                    image: DecorationImage(
                      image: AssetImage("image/reload.png"),
                    ),
                  ),
                  //color: Colors.green,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(5),
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: (status == false) ? clr : null,
              gradient: (status == true)
                  ? LinearGradient(colors: [myclr[clr_ind], myclr[clr_ind + 1]])
                  : null,
            ),
            child: PageView.builder(
              controller: controller,
              onPageChanged: (value) {
                widget.Sh_ind = value;
                setState(() {});
              },
              itemCount: widget.Shayari_list.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(
                    """${data.myEmogi[index]} 
                    ${widget.Shayari_list[widget.Sh_ind]} 
                    ${data.myEmogi[index]}""",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                );
              },
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(5),
              color: Colors.green,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      FlutterClipboard.copy(
                              "${widget.Shayari_list[widget.Sh_ind]}")
                          .then((value) => print('copied'));
                      //setState(() {});
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 0),
                        image: DecorationImage(
                          image: AssetImage("image/copy.png"),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (widget.Sh_ind > 0) {
                        widget.Sh_ind--;
                        controller?.jumpToPage(widget.Sh_ind);
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 0),
                        image: DecorationImage(
                          image: AssetImage("image/pre.png"),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return theme(widget.Shayari_list[widget.Sh_ind],
                              widget.Sh_ind);
                        },
                      ));
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 0),
                        image: DecorationImage(
                          image: AssetImage("image/pencil.png"),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (widget.Sh_ind <= widget.Shayari_list.length - 2) {
                        widget.Sh_ind++;
                        controller?.jumpToPage(widget.Sh_ind);
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 0),
                        image: DecorationImage(
                          image: AssetImage("image/next.png"),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Share.share("${widget.Shayari_list[widget.Sh_ind]}");
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 0),
                        image: DecorationImage(
                          image: AssetImage("image/share.png"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
