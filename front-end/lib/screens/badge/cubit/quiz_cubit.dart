import 'dart:io';

import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/contract/WowTCommunity.g.dart';
import 'package:bnbapp/contract/WowTPoints.g.dart';
import 'package:bnbapp/contract/WowTQuiz.g.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:bnbapp/utils/preferencehelper.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  ValueNotifier<BigInt> points = ValueNotifier(BigInt.parse("0"));
  int? index = 0;
  String imagePath = '';
  bool? trueOrFalse = true;
  ValueNotifier<String> communityName = ValueNotifier('');
  File? fileImage;
  ValueNotifier<File> valueNotifier = ValueNotifier(File(''));
  TextEditingController tittle = TextEditingController();
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController question = TextEditingController();
  TextEditingController option1 = TextEditingController();
  TextEditingController answer = TextEditingController();
  TextEditingController option2 = TextEditingController();
  TextEditingController option3 = TextEditingController();
  TextEditingController option4 = TextEditingController();
  TextEditingController textEditingController9 = TextEditingController();
  bool trueOrFalseCheck = false;
  Map<String, Map<List<dynamic>, List<List<dynamic>>>> hardMap = {};

  QuizCubit(this.authCubit) : super(QuizInitialState());
  List<String> quizName = [];
  Map<String, List<String>> maps = {};
  Map<List<String>, List<String>> mapsya = {};
  Map<String, Map<List<String>, List<String>>> mapData = {};
  String? userid;
  List<String> list = [
    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/jackie.jpg?alt=media&token=8fe45dfc-6e35-47a1-9bee-c60e4f494e0f",
    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/marvel.jpg?alt=media&token=549b7f2f-ac05-4d81-87dd-3345166dd2e0",
    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/miim.jpg?alt=media&token=0ac0d1a3-a7d2-4c34-84c6-216efd85aee2"
  ];

  Future<void> init() async {
    emit(QuizLoadingState());
    userid = await PreferenceHelper.getUserId();

    debugPrint('hi wellCome');
    final httpClient = Client();
    //trueOrFalse?.clear();

    Web3Client client = Web3Client(authCubit.node.toString(), httpClient);
    WowTCommunity wowTCommunity = WowTCommunity(
        address: EthereumAddress.fromHex(
            authCubit.profileModel!.community.toString()),
        client: client);
    WowTQuiz wowTQuiz = WowTQuiz(
        address:
            EthereumAddress.fromHex(authCubit.profileModel!.quiz.toString()),
        client: client);
    WowTPoints wowTPoints = WowTPoints(
        client: client,
        address:
            EthereumAddress.fromHex(authCubit.profileModel!.points.toString()));

    points.value =
        await wowTPoints.getPoints(EthereumAddress.fromHex(userid.toString()));
    // var userId = await PreferenceHelper.getUserId();
    var abc = await wowTCommunity.getCommunities();
    maps.clear();
    for (var i = 0; i < abc.length; i++) {
      debugPrint('the communities are ${abc.toString()}');
      var quizNames =
          await wowTCommunity.getCommunityDetails(abc[i].toString());
      for (var c = 0; c < quizNames.var3.length; c++) {
        debugPrint('the length is ${quizNames.var3.length.toString()}');
        var ayy =
            await wowTQuiz.getstringQuizdetails(quizNames.var3[c].toString());
        debugPrint(
            'the qu list ${ayy.var4.toString()} and ${ayy.var1.toString()} and ${ayy.var2.toString()} and ${ayy.var3.toString()}');
      }
      debugPrint('get community details ${quizNames.var3[0].toString()}');
      debugPrint('get community details ${quizNames.var3[1].toString()}');
      var ayy =
          await wowTQuiz.getstringQuizdetails(quizNames.var3[0].toString());
      maps[ayy.var3.toString()] = ayy.var4;

      // maps.update(ayy.var3.toString(), (value) => ayy.var4);
      debugPrint('the quiz details ${ayy.var3.toString()} ');
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
    trueOrFalse = true;
    //trueOrFalse?.add(false);
    emit(QuizBackButtonState());
  }

  Future<String> uploadFiles(String filepath) async {
    final storageRef = FirebaseStorage.instance.ref();
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    String timeStampString = timeStamp.toString();

    var childref = storageRef.child("fanposts/${userid!}/$timeStampString.jpg");
    try {
      File file = File(filepath);

      await childref.putFile(file);
      return childref.getDownloadURL();
    } catch (e) {
      debugPrint('Something went wrong! $e');
      return "Error";
    }
  }

  createQuiz() async {
    emit(QuizCreateRequestedState());

    //var url = "jhbnc";
    var url = await uploadFiles(imagePath);
    debugPrint('the one ${url.toString()}');
    debugPrint('the one 123 ${communityName.value.toString()}');
    debugPrint('the one 1234 ${tittle.value.text.toString()}');
    debugPrint('the one 12345 ${description.value.text.toString()}');
    debugPrint('the one 123456 ${question.value.text.toString()}');
    debugPrint('the one 1234567 ${option1.value.text.toString()}');
    debugPrint('the one appl ${option2.value.text.toString()}');
    debugPrint('the one sppk ${option3.value.text.toString()}');
    debugPrint('the one sppk ${option4.value.text.toString()}');
    debugPrint('the one sppk ${answer.value.text.toString()}');
    debugPrint('the one sppk ${userid.toString()}');
    var jsons = {
      "method": "createQuiz",
      "communityName": communityName.value.toString(),
      "quizName": tittle.value.text.toString(),
      "description": description.value.text.toString(),
      "imageUrl": url.toString(),
      "question": question.value.text.toString(),
      "option1": option1.value.text.toString(),
      "option2": option2.value.text.toString(),
      "option3": option3.value.text.toString(),
      "option4": option4.value.text.toString(),
      "answer": answer.value.text.toString(),
      "userAddress": userid.toString(),
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
    if (result.toString().contains("Quiz created successfully")) {
      emit(QuizAddedState());
    } else {
      emit(QuizNotAddedState());
    }
  }

  answerEvaluate(choice, quizName, indexes) async {
    trueOrFalse = false;

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
    if (result.data.toString().contains('Already tried')) {
      debugPrint('the error is was the');
      emit(QuizErrorState("Already tried"));
    }
  }
}
