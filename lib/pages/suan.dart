import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hongda_fushi/utils/contant.dart';

class Suan extends StatefulWidget {
  const Suan({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SuanState createState() => _SuanState();
}

class _SuanState extends State<Suan> {
  String _text1 = "鼠";
  String _text2 = "鼠";
  String _jieguo = "";
  String _zhishu = "";
  String _pingshu = "";
  String _img1 = AssetsManager.SHU_IMG;
  String _img2 = AssetsManager.NIU_IMG;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            height: 60,
            width: double.infinity,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 100.0,
                  offset: Offset(2, 2),
                  color: Colors.deepOrangeAccent,
                  spreadRadius: 2.0,
                )
              ],
            ),
            child: ListView(
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.horizontal,
              children: _buildList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            height: 60,
            width: double.infinity,
            child: ListView(
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.horizontal,
              children: _buildList2(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ClipOval(
                      child: Image(
                        fit: BoxFit.fill,
                        height: 100,
                        width: 100,
                        image: AssetImage(_img1),
                      ),
                    ),
                    Text(
                      _text1,
                      style: TextStyle(color: Colors.purple, fontSize: 16),
                    ),
                  ],
                ),
                // child: Text(
                //   _text1,
                //   style:
                //       TextStyle(fontSize: 16, color: Colors.deepPurpleAccent),
                // ),
              ),
              Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ClipOval(
                        child: Image(
                          fit: BoxFit.fill,
                          height: 100,
                          width: 100,
                          image: AssetImage(_img2),
                        ),
                      ),
                      Text(
                        _text2,
                        style: TextStyle(color: Colors.purple, fontSize: 16),
                      ),
                    ],
                  ))
            ],
          ),
          Text(_zhishu),
          Text(_jieguo),
          Container(
            // width: 700,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(10, 10, 20, 0),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              // border: Border.all(color: Color.fromARGB(255, 232, 141, 6)),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                  opacity: 0.5,
                  fit: BoxFit.cover,
                  image: AssetImage(AssetsManager.JIEGUO_BG)),
            ),
            child: Text(
              _pingshu,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildList() {
    return AssetsManager.SX.map((e) => _genWidget(e)).toList();
  }

  List<Widget> _buildList2() {
    return AssetsManager.SX.map((e) => _genWidget2(e)).toList();
  }

  getData() async {
    Response response;
    response = await Dio().get("https://x.quhuitu.com/?n=$_text1&v=$_text2");
    // print(response.data.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.toString());
      var t = data["data"];
      setState(() {
        _jieguo = t["jieguo"];
        _pingshu = t["pingshu"];
        _zhishu = t["zhishu"];
      });
    }
  }

  Widget _genWidget(name) {
    return Container(
      height: 100,
      width: 50,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
          onPressed: () {
            setState(() {
              _text1 = name;
              _img1 = AssetsManager.getImage(name);
            });
          },
          style: const ButtonStyle(
            alignment: Alignment.center,
          ),
          child: Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }

  Widget _genWidget2(name) {
    return Container(
      height: 100,
      width: 50,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
          onPressed: () {
            setState(() {
              _text2 = name;
              _img2 = AssetsManager.getImage(name);
            });
            getData();
          },
          // ignore: prefer_const_constructors
          style: ButtonStyle(
            alignment: Alignment.center,
          ),
          child: Text(
            name,
            style: const TextStyle(color: Colors.yellow, fontSize: 20),
          )),
    );
  }
}
