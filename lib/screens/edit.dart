import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
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
              onPressed: () {},
              icon: const Icon(Icons.save),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
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
}
// test
