
import 'package:bnbapp/utils/base_equatable.dart';

class TabScreenState extends BaseEquatable {}
class TabScreenRefreshState extends TabScreenState {}
class TabScreenErrorState extends TabScreenState{
  final String error;
  TabScreenErrorState(this.error);
  @override
  bool operator ==(Object other) => false;
}