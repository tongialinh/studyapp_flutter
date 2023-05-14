import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

/*class QuestionPaperModel {
  String id;
  String title;
  String? imageUrl;
  Rxn<String?>? url;
  String description;
  int timeSeconds;
  List<Questions>? questions;
  int questionCount;

  QuestionPaperModel(
      {required this.id,
        required this.title,
        this.imageUrl,
        required this.description,
        required this.timeSeconds,
        required this.questionCount,
        this.questions});

  String timeInMinits() => "${(timeSeconds / 60).ceil()} mins";

  factory QuestionPaperModel.fromString(String jsonString) => QuestionPaperModel.fromJson(json.decode(jsonString));

  QuestionPaperModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        imageUrl = json['image_url'] as String,
        description = json['Description'] as String,
        timeSeconds = json['time_seconds'],
        questionCount = 0,

        questions = (json['questions'] as List)
            .map((dynamic e) => Questions.fromJson(e as Map<String, dynamic>))
            .toList();

  QuestionPaperModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        title = json['title'],
        imageUrl = json['image_url'] ,
        description = json['Description'] ,
        timeSeconds = json['time_seconds'],
        questionCount = json['questions_count'] as int,
        questions = [];



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image_url'] = this.imageUrl;
    data['Description'] = this.description;
    data['time_seconds'] = this.timeSeconds;

    return data;
  }
}

class Questions {
  String id;
  String question;
  List<Answers> answers;
  String? correctAnswer;
  String? selectedAnswer;

  Questions(
      {required this.id,
        required this.question,
        required this.answers,
        this.correctAnswer});

  Questions.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        answers =
        (json['answers'] as List).map((e) => Answers.fromJson(e)).toList(),
        correctAnswer = json['correct_answer'] as String?;

  Questions.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      :id=snapshot.id,
        question = snapshot['question'],
        answers = [],
        correctAnswer = snapshot['correct_answer'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    data['correct_answer'] = this.correctAnswer;
    return data;
  }
}

class Answers {
  String? identifier;
  String? answer;

  Answers({this.identifier, this.answer});

  Answers.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'],
        answer = json['Answer'];

  Answers.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : identifier = snapshot['identifier'] as String?,
        answer = snapshot['answer'] as String?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['Answer'] = answer;
    return data;
  }
}*/
class QuestionPaperModel {
  final String id;
  final String title;
  String? imageUrl;
  Rxn<String?>? url;
  final String description;
  final int timeSeconds;
  List<Questions>? questions;
  final int questionCount;

  QuestionPaperModel({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.description,
    required this.timeSeconds,
    required this.questions,
    required this.questionCount,
  });

  String timeInMinits() => "${(timeSeconds / 60).ceil()} mins";

  factory QuestionPaperModel.fromString(String jsonString) => QuestionPaperModel.fromJson(json.decode(jsonString));

  QuestionPaperModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'] as String,
        imageUrl = json['image_url'] as String?,
        description = json['Description'] as String,
        timeSeconds = json['time_seconds'] as int,
        questionCount = 0,

  /// will be update in PapersDataUploader
        questions = json['questions'] == null ? [] : (json['questions'] as List)
            .map((dynamic e) => Questions.fromJson(e as Map<String, dynamic>))
            .toList();

  QuestionPaperModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        title = snapshot['title'],
        imageUrl = snapshot['image_url'],
        description = snapshot['Description'],
        timeSeconds = snapshot['time_seconds'],
        questionCount = snapshot['questions_count'] as int,
        questions = [];

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'image_url': imageUrl,
    'Description': description,
    'time_seconds': timeSeconds,
    // 'questions':
    //     questions == null ? [] : questions!.map((e) => e.toJson()).toList()
  };
}

class Questions {
  final String id;
  String? imageUrlQues;
  final String question;
  List<Answers> answers;
  final String? correctAnswer;
  String? selectedAnswer;

  Questions({
    required this.id,
    this.imageUrlQues,
    required this.question,
    required this.answers,
    this.correctAnswer,
  });

  Questions.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        imageUrlQues = snapshot['image_ques'],
        question = snapshot['question'],
        answers = [],
        correctAnswer = snapshot['correct_answer'];

  Questions.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        imageUrlQues = json['image_ques'] as String?,
        question = json['question'] as String,
        answers =
        (json['answers'] as List).map((e) => Answers.fromJson(e)).toList(),
        correctAnswer = json['correct_answer'] as String?;

  Map<String, dynamic> toJson() => {
    'id': id,
    'image_ques': imageUrlQues,
    'question': question,
    //'answers' : answers.toJson(),
    'correct_answer': correctAnswer
  };
}

class Answers {
  final String? identifier;
  final String? answer;

  Answers({
    this.identifier,
    this.answer,
  });

  Answers.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'] as String?,
        answer = json['Answer'] as String?;

  Answers.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : identifier = snapshot['identifier'] as String?,
        answer = snapshot['answer'] as String?;

  Map<String, dynamic> toJson() => {'identifier': identifier, 'Answer': answer};
}
