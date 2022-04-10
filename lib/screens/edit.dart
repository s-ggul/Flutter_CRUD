import 'package:flutter/material.dart';
import 'package:flutter_crud/database/db.dart';
import '../database/memo.dart';
import '../database/db.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class EditPage extends StatelessWidget {
  String title = '';
  String text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
            IconButton(
              onPressed: saveDB,
              icon: const Icon(Icons.save),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (String title) {
                  this.title = title;
                },
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                //obscureText: true,
                // obscureText => 비밀번호 입력창처럼 글자가 안보이게 하는 기능
                keyboardType: TextInputType.multiline,
                maxLines: null,
                // 줄바꿈 속성
                // maxLines 도 지정해줘야한다. 이 경우 제한없음 (null)
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  hintText: '제목을 입력하세요.',
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              TextField(
                onChanged: (String text) {
                  this.text = text;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: '내용을 입력하세요.',
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> saveDB() async {
    // Future 키워드 => async키워드와 함께 메소드에서사용됨
    DBHelper sd = DBHelper();

    var fido = Memo(
      id: Str2Sha512(DateTime.now().toString()),
      title: this.title,
      text: this.text,
      createTime: DateTime.now().toString(),
      editTime: DateTime.now().toString(),
    );

    await sd.insertMemo(fido);

    print(await sd.memos());
  }

  String Str2Sha512(String text) {
    var bytes = utf8.encode(text);
    //data being hashed

    var digest = sha512.convert(bytes);

    return digest.toString();
  }
}
