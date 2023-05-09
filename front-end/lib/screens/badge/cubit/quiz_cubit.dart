import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/contract/WowTCommunity.g.dart';
import 'package:bnbapp/contract/WowTQuiz.g.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:bnbapp/utils/preferencehelper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import 'quiz_state.dart';

class QuizCubit extends BaseCubit<QuizState> {
  final AuthCubit authCubit;
  List<String> imageUrlList = [];
  List<String> descriptionList = [];
  List<String> questionList = [];
  List<String> answerList = [];
  int? index = 0;
  List<bool>? trueOrFalse = [];

  // bool? trueOrFalse = false;

  QuizCubit(this.authCubit) : super(QuizInitialState());
  List<String> quizName = [];
  Map<String, List<String>> maps = {};
  List<String> list = [
    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/jackie.jpg?alt=media&token=8fe45dfc-6e35-47a1-9bee-c60e4f494e0f",
    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/marvel.jpg?alt=media&token=549b7f2f-ac05-4d81-87dd-3345166dd2e0",
    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/miim.jpg?alt=media&token=0ac0d1a3-a7d2-4c34-84c6-216efd85aee2"
  ];

  Future<void> init() async {
    emit(QuizLoadingState());
    debugPrint('hi wellCome');
    final httpClient = Client();
    trueOrFalse?.clear();
    for (var j = 0; j < 10; j++) {
      trueOrFalse?.add(false);
    }
    Web3Client client = Web3Client(authCubit.node.toString(), httpClient);
    WowTCommunity wowTCommunity = WowTCommunity(
        address: EthereumAddress.fromHex(
            authCubit.profileModel!.community.toString()),
        client: client);
    WowTQuiz wowTQuiz = WowTQuiz(
        address:
            EthereumAddress.fromHex(authCubit.profileModel!.quiz.toString()),
        client: client);
    var userId = await PreferenceHelper.getUserId();
    var abc = await wowTCommunity.getCommunities();
    maps.clear();
    for (var i = 0; i < abc.length; i++) {
      debugPrint('the communities are ${abc[i]}');
      var quizNames =
          await wowTCommunity.getCommunityDetails(abc[i].toString());
      debugPrint('get community details ${quizNames.var3[0].toString()}');
      var ayy =
          await wowTQuiz.getstringQuizdetails(quizNames.var3[0].toString());
      maps[ayy.var3.toString()] = ayy.var4;
      // maps.update(ayy.var3.toString(), (value) => ayy.var4);
      debugPrint('the quiz details ${ayy.var4.toString()} ');
      imageUrlList.add(ayy.var2.toString());
      quizName.add(quizNames.var3[0].toString());
      questionList.add(ayy.var3);
      answerList.addAll(ayy.var4);

      descriptionList.add(abc[i]);
      debugPrint('the quiz name is was ${ayy.var1.toString()}');
    }

    debugPrint('the quiz name is was ${maps.toString()}');
    // wowTQuiz.
    // wowTQuiz.getQuizdetails();
    emit(QuizLoadedState());
  }

  back() {
    trueOrFalse?.add(false);
    emit(QuizBackButtonState());
  }

  answerEvaluate(choice, quizName, indexes) async {
    trueOrFalse![indexes] = true;
    debugPrint('index is ${index.toString()}');
    index = indexes;
    debugPrint('index is two ${index.toString()}');
    debugPrint(
        'its come ya ${choice.toString()} ${quizName.toString()}  ${authCubit.address.toString()}');
    emit(QuizAnswerClickedState());
    var jsons = {
      "method": "quizEval",
      "quizName": quizName.toString(),
      "choice": choice.toString(),
      "userAddress": authCubit.address.toString()
    };
    final result = await Dio().post(
        authCubit.profileModel!.requestUrl.toString(),
        options: Options(
            headers: {"x-api-key": authCubit.profileModel!.apiKey.toString()},
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
        data: jsons);

    debugPrint('the result is ${result.data.toString()}');
    if (result.data.toString().contains('Correct answer')) {
      debugPrint('contains result');
      emit(QuizAnsweredState());
    } else {
      emit(QuizWrongAnswerState());
    }
  }
}
