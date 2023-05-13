import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/contract/WowTCommunity.g.dart';
import 'package:bnbapp/screens/tab_community/cubit/tab_community_state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:bnbapp/utils/preferencehelper.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class TabCommunityCubit extends BaseCubit<TabCommunityState> {
  final AuthCubit authCubit;
  String userId = "";
  List<String> lists = [];

  TabCommunityCubit(this.authCubit) : super(TabCommunityInitialState());
  final httpClient = Client();
  List<String> imageUrlList = [];
  List<String> list = [
    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/jackie.jpg?alt=media&token=8fe45dfc-6e35-47a1-9bee-c60e4f494e0f",
    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/marvel.jpg?alt=media&token=549b7f2f-ac05-4d81-87dd-3345166dd2e0",
    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/miim.jpg?alt=media&token=0ac0d1a3-a7d2-4c34-84c6-216efd85aee2"
  ];

  Future<void> init() async {
    emit(TabCommunityLoadingState());
    userId = await PreferenceHelper.getUserId() ?? '';

    EthereumAddress address =
        EthereumAddress.fromHex(authCubit.profileModel!.community.toString());
    Web3Client client = Web3Client(authCubit.node.toString(), httpClient);
    WowTCommunity wowTCommunity =
        WowTCommunity(address: address, client: client);
    lists = await wowTCommunity.getCommunities();
    for (var i = 0; i < lists.length; i++) {
      var abc = await wowTCommunity.communityMap(lists[i]);
      imageUrlList.add(abc.imageUrl.toString());
    }

    emit(TabCommunityLoadedState());
  }
}
