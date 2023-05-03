import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore = FirebaseFirestore.instance;
Reference get firebaseStorage => FirebaseStorage.instance.ref();

final userRF = fireStore.collection("users");
final leaderBoardRF = fireStore.collection('leaderboard');

final questionPaperRF = fireStore.collection('questionPapers');
DocumentReference questionRF({
  required String paperId,
  required String questionId,
})=>
    questionPaperRF.doc(paperId).collection("questions").doc(questionId);


DocumentReference recentQuestionsData({required String userId, required String paperId}) => userRF.doc(userId).collection('myrecent_questions').doc(paperId);

CollectionReference<Map<String, dynamic>> recentQuestions({required String userId}) => userRF.doc(userId).collection('myrecent_questions');

CollectionReference<Map<String, dynamic>> getLeaderBoard({required String paperId}) => leaderBoardRF.doc(paperId).collection('scores');