
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customers_collector_feedback/features/feedback_management/data/data_source/feedback_remote_datasource.dart';
import 'package:customers_collector_feedback/features/feedback_management/domain/entities/feedback.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/feedback_model.dart';

class FeedbackFormFirebaseRemoteDataSource implements FeedbackFormRemoteDataSource {
  final FirebaseFirestore _firestore;

  FeedbackFormFirebaseRemoteDataSource(this._firestore);
  
  @override
  Future<void> createFeedbackForm(FeedbackForm form) async{
   try {
      final feedbackFormDocRef = _firestore.collection('feedbackForm').doc(); 
      final feedbackFormModel = FeedbackFormModel(
          id: feedbackFormDocRef.id,
          title: form.title,
          questions: (['questions'] as List)
          .map((q) => QuestionModel.fromMap(q as Map<String, dynamic>))
          .toList(), isRSVP: true,
        );
      await feedbackFormDocRef.set(feedbackFormModel.toMap());
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occured',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }
  
  @override
  Future<void> deleteFeedbackForm(String id) async{
     try {
      await _firestore.collection('feedbackform').doc(id).delete();
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occured',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }
  
  @override
  Future<List<FeedbackForm>> getAllFeedbackForms() async{
  try {
      final querySnapshot = await _firestore
          .collection('feedbackForm')
          .orderBy("date", descending: true)
          .get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return FeedbackForm(
          id: data['id'],
          title: data['title'],
          questions: (['questions'] as List)
          .map((q) => QuestionModel.fromMap(q as Map<String, dynamic>))
          .toList(), isRSVP: true,
        );
      }).toList();
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occured',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }
  
  @override
  Future<FeedbackForm?> getFeedbackFormById(String id) async{
    try {
      final doc = await _firestore.collection('feedbackForm').doc(id).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return FeedbackForm(
          id: data['id'],
          title: data['title'],
         questions: (['questions'] as List)
          .map((q) => QuestionModel.fromMap(q as Map<String, dynamic>))
          .toList(), isRSVP: true,
        );
      }
      return null;
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occured',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<void> updateFeedbackForm(FeedbackForm form) async{
    final feedbackFormModel = FeedbackFormModel(
      id: form.id,
          title: form.title,
          questions: (['questions'] as List)
          .map((q) => QuestionModel.fromMap(q as Map<String, dynamic>))
          .toList(), isRSVP: true,
        );
    try {
      await _firestore
          .collection('feedbackForm')
          .doc(feedbackFormModel.id)
          .update(feedbackFormModel.toMap());
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occured',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }
}