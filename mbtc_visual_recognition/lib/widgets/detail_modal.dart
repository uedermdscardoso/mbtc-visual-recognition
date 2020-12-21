
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart';
import 'package:mbtc_visual_recognition/main.dart';

//Modal Bottom Sheet
class DetailModal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DetailModalState();
}

class _DetailModalState extends State<DetailModal> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black, width: 0.30)),
            ),
            child: Text('Visual Recognition result', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold))
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Observer(
                  builder: (_) {

                    return FutureBuilder(
                      future: mainStore.visualRecognition.predicted,
                      builder: (context, snapshot) {

                        if(snapshot.hasData) {

                          String predicted =  snapshot.data;

                          predicted = mainStore.visualRecognition.getName(result: predicted);

                          return Text('${ predicted }', style: TextStyle(color: Colors.grey, fontSize: 22));
                        }

                        return Column(
                          children: [
                            Image.asset("assets/icons/loading.gif", scale: 5),
                            Text('loading data', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
