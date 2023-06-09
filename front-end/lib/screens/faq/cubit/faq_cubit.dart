import 'dart:convert';

import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/screens/faq/model/faq_model.dart';
import 'package:bnbapp/utils/base_cubit.dart';

import 'faq_state.dart';

class FAQCubit extends BaseCubit<FAQState> {
  final AuthCubit authCubit;
  List<dynamic> map = [];
  Map<String, dynamic> maps = {};
  List<String> answer = [];
  List<String> question = [];
  List<FAQModel> faqModel = [];

  FAQCubit(this.authCubit) : super(FAQInitialState());
  var abcd;

  Future<void> init() async {
    emit(FAQLoadingState());
    final data = await authCubit.paths?.master.child("FAQs").get();
    map = jsonDecode(jsonEncode(data?.value)) as List<dynamic>;
    List<dynamic> decodedJson =
    jsonDecode(jsonEncode(data?.value)) as List<dynamic>;
    faqModel.clear();
    for (var index = 0; index < decodedJson.length; index++) {
      faqModel
          .add(FAQModel.fromJson(decodedJson[index] as Map<String, dynamic>));
    }


    abcd = data?.value.toString();

    emit(FAQLoadedState());
  }
}
