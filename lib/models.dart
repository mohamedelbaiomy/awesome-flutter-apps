class Question {
  final String questionText;
  final List<Answer> answerList;

  Question(this.questionText, this.answerList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];

  list.add(
    Question(
      'Who is the owner of Flutter ?',
      [
        Answer('Nokia', false),
        Answer('Samsung', false),
        Answer('Google', true),
        Answer('Apple', false),
      ],
    ),
  );

  list.add(
    Question(
      'Who is the owner of Iphone ?',
      [
        Answer('Microsoft', false),
        Answer('Oppo', false),
        Answer('Google', false),
        Answer('Apple', true),
      ],
    ),
  );
  list.add(
    Question(
      'Youtube is ________ platform ?',
      [
        Answer('Music Sharing', false),
        Answer('Video Sharing', false),
        Answer('Live Streaming', false),
        Answer('All of the above', true),
      ],
    ),
  );
  list.add(
    Question(
      'Flutter uses Dart as a language ?',
      [
        Answer('True', true),
        Answer('False', false),
      ],
    ),
  );

  return list;
}

/*
class Question {
  final String questionText;
  final List<Answer> answerList;

  Question(this.questionText, this.answerList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];

  list.add(
    Question(
      'هل طفلك متأخر في المشي أو الكلام ؟',
      [
        Answer('True', true),
        Answer('False', false),
      ],
    ),
  );

  list.add(
    Question(
      'ابنك في عمر كبير بس بينسي كتير سواء بينسي أشخاص أو أشياء',
      [
        Answer('True', true),
        Answer('False', false),
      ],
    ),
  );
  list.add(
    Question(
      'ابنك بيغضب كتير ومش بتقدر تسيطر علي العصبيه بتاعته ؟',
      [
        Answer('True', true),
        Answer('False', false),
      ],
    ),
  );
  list.add(
    Question(
      'هل عند ابنك اصدقاء وبيحب يخرج ويلعب معاهم ؟',
      [
        Answer('True', false),
        Answer('False', true),
      ],
    ),
  );
  list.add(
    Question(
      'ابنك في سن كبير شويه بس مش بيعرف يقرأ ولا يكتب ولا يعد ارقام ؟',
      [
        Answer('True', true),
        Answer('False', false),
      ],
    ),
  );
  list.add(
    Question(
      'ابنك مش بيعرف يتكلم ودائما بيبقي قاعد لوحده ؟',
      [
        Answer('True', true),
        Answer('False', false),
      ],
    ),
  );
  list.add(
    Question(
      'ابنك عنده شكوك في الناس أنهم عايزين ياذوه ومش بيقدر يخرج لوحده ؟',
      [
        Answer('True', true),
        Answer('False', false),
      ],
    ),
  );
  list.add(
    Question(
      'ابنك عنده خلل واضح في الحركه بتاعته ؟',
      [
        Answer('True', true),
        Answer('False', false),
      ],
    ),
  );
  list.add(
    Question(
      'ابنك عنده سلس في التبول ؟',
      [
        Answer('True', true),
        Answer('False', false),
      ],
    ),
  );
  list.add(
    Question(
      'ابنك بيضرب أو يشتم اي حد ومش بيقدر يبطل الأسلوب دا ؟',
      [
        Answer('True', true),
        Answer('False', false),
      ],
    ),
  );

  return list;
}
*/
