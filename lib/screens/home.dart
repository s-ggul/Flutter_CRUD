import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './write.dart';
import '../database/db.dart';
import '../database/memo.dart';
import './view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String deleteId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5, top: 40, bottom: 20),
            child: Container(
              child: Text('Nemo Memo',
                  style: TextStyle(fontSize: 36, color: Colors.blue)),
              alignment: Alignment.centerLeft,
            ),
          ),
          Expanded(child: memoBuilder(context))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => WritePage()));
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

  Future<void> deleteMemo(String id) async {
    DBHelper sd = DBHelper();
    await sd.deleteMemo(id);
  }

  void showAlertDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 경고'),
          content: Text("정말 삭제하시겠습니까?\n삭제된 메모는 복구되지 않습니다."),
          actions: <Widget>[
            TextButton(
              child: Text('삭제'),
              onPressed: () {
                Navigator.pop(context, "삭제");
                setState(() {
                  deleteMemo(deleteId);
                });
                deleteId = '';
              },
            ),
            TextButton(
              child: Text('취소'),
              onPressed: () {
                deleteId = '';
                Navigator.pop(context, "취소");
              },
            ),
          ],
        );
      },
    );
  }

  Widget memoBuilder(BuildContext parentContext) {
    return FutureBuilder<List<Memo>>(
      builder: (context, AsyncSnapshot snap) {
        //snapshot 앞에는 `AsyncSnapshot` 키워드를 이용하자
        if (snap.data?.isEmpty ?? true) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              "메모가 없습니다. 메모를 추가하세요!\n\n\n\n\n",
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue.shade900,
              ),
            ),
          );
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(20),
          itemCount: snap.data?.length,
          //AsyncSnapshot를 통해 ! 를 사용할 수 있다.
          itemBuilder: (context, index) {
            Memo memo = snap.data![index];
            return InkWell(
              onTap: () {
                Navigator.push(
                    parentContext,
                    CupertinoPageRoute(
                        builder: (context) => ViewPage(id: memo.id)));
              },
              onLongPress: () {
                deleteId = memo.id;
                showAlertDialog(parentContext);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(15),
                alignment: Alignment.center,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          memo.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          //오버플로우로 인한 화면깨짐을 방지
                        ),
                        Text(
                          memo.text,
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      //Widget to display the list of project
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "최종 수정 시간 : " + memo.editTime.split('.')[0],
                          style: TextStyle(fontSize: 11),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.green[100],
                    border: Border.all(
                      color: Colors.teal.shade300,
                      width: 2,
                    ),
                    boxShadow: [BoxShadow(color: Colors.teal, blurRadius: 3)],
                    borderRadius: BorderRadius.circular(12)),
              ),
            );
          },
        );
      },
      future: loadMemo(),
    );
  }
}
