class Memo {
  final String id;
  final String title;
  final String text;
  final String createTime;
  final String editTime;

  Memo(
      {required this.id,
      // required 속성은 생성자가 기본값이 없고 null 이 아닐 경우에 사용.
      // 그리고 assert 메서드를 이용해 null일 경우를 체크하는 기능도 있음
      required this.title,
      required this.text,
      required this.createTime,
      required this.editTime});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'createTime': createTime,
      'editTime': editTime,
    };
  }

  // 각 memo 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현
  @override
  String toString() {
    return 'Memo{id: $id, title: $title, text: $text, createTime: $createTime, editTime: $editTime}';
  }
}
