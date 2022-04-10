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
      body: ListView(
        physics: BouncingScrollPhysics(),
        // 섬세한 애니메이션 동작 정의 => physics
        /*children: <Widget>[
          Container(
            color: Colors.redAccent,
            height: 70,
          ),
          Container(
            color: Colors.orange,
            height: 70,
          ),
          Container(
            color: Colors.yellow,
            height: 70,
          ),
          이렇게 선언하면 메모마다 추가해야겠지 당연히 
          어떻게 구현할 수 있을까? 
          */
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Text('Memo Memo',
                      style: TextStyle(fontSize: 36, color: Colors.blue)))
            ],
          ),
          ...LoadMemo()
          // ... 이 의미하는건 리스트가 다 돌때까지 반복적으로 loadMemo를 실행
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

  List<Widget> LoadMemo() {
    List<Widget> memoList = [];
    memoList.add(Container(
      color: Colors.redAccent,
      height: 70,
    ));

    return memoList;
  }

  Future<List<Memo>> loadMemo() async {
    DBHelper sd = DBHelper();
    return await sd.memos();
  }
}
//test