import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './edit.dart';
import '../database/db.dart';
import '../database/memo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Text('Memo Memo',
                  style: TextStyle(fontSize: 36, color: Colors.blue))),
          Expanded(child: memoBuilder())
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => EditPage()));
        },
        // 페이지 라우팅을 담당하는 부분의 코드
        // 여기서는 CupertinoPageRouter를 사용했음
        tooltip: '노트를 추가하려면 클릭하세요',
        label: Text('메모 추가'),
        icon: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<List<Memo>> loadMemo() async {
    DBHelper sd = DBHelper();
    return await sd.memos();
  }

  Widget memoBuilder() {
    return FutureBuilder(
      builder: (context, AsyncSnapshot snap) {
        //snapshot 앞에는 `AsyncSnapshot` 키워드를 이용하자
        if (snap.data!.isEmpty) {
          return Container(child: Text("메모가 없습니다. 메모를 추가하세요"));
        }
        return ListView.builder(
          itemCount: snap.data!.length,
          //AsyncSnapshot를 통해 ! 를 사용할 수 있다.
          itemBuilder: (context, index) {
            Memo memo = snap.data![index];
            return Column(
              children: <Widget>[
                Text(memo.title),
                Text(memo.text),
                Text(memo.editTime),
                //Widget to display the list of project
              ],
            );
          },
        );
      },
      future: loadMemo(),
    );
  }
}
