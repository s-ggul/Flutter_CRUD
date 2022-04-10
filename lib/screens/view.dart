import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../database/db.dart';
import '../database/memo.dart';
import './home.dart';
import './edit.dart';

class ViewPage extends StatefulWidget {
  ViewPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  BuildContext? _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: showAlertDialog,
              icon: const Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => EditPage(id: widget.id)));
              },
              icon: const Icon(Icons.edit),
            )
          ],
        ),
        body: Padding(padding: EdgeInsets.all(10), child: LoadBuilder()));
  }

  Future<List<Memo>> loadMemo(String id) async {
    DBHelper sd = DBHelper();
    return await sd.findMemo(id);
  }

  LoadBuilder() {
    return FutureBuilder<List<Memo>>(
      future: loadMemo(widget.id),
      builder: (BuildContext context, AsyncSnapshot<List<Memo>> snapshot) {
        if (snapshot.data?.isEmpty ?? true) {
          return Container(child: Text('데이터를 불러올 수 없습니다.'));
        } else {
          Memo memo = snapshot.data![0];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 100,
                child: SingleChildScrollView(
                  //정해진 구간내에서 스크롤이 가능하게 함.
                  // 현재 높이 100짜리로 지정 위의 heigh: 100에 의함
                  child: Text(
                    memo.title,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Text(
                '메모 추가 시간 : ' + memo.createTime.split('.')[0],
                style: TextStyle(
                  fontSize: 11,
                ),
                textAlign: TextAlign.end,
              ),
              Text(
                '메모 수정 시간 : ' + memo.editTime.split('.')[0],
                style: TextStyle(
                  fontSize: 11,
                ),
                textAlign: TextAlign.end,
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(memo.text),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Future<void> deleteMemo(String id) async {
    DBHelper sd = DBHelper();
    await sd.deleteMemo(id);
  }

  void showAlertDialog() async {
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
                  deleteMemo(widget.id);
                });
                Navigator.pop(_context!, "삭제");
              },
            ),
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context, "취소");
              },
            ),
          ],
        );
      },
    );
  }
}
