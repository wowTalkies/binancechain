// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bool","name":"","type":"bool"}],"name":"Answer","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint8","name":"version","type":"uint8"}],"name":"Initialized","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"inputs":[{"internalType":"string","name":"_quizName","type":"string"},{"internalType":"bytes32","name":"choice","type":"bytes32"}],"name":"checkAnswer","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"createEligibility","outputs":[{"internalType":"uint16","name":"","type":"uint16"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"string","name":"_communityName","type":"string"},{"internalType":"string","name":"_quizName","type":"string"},{"internalType":"string","name":"_description","type":"string"},{"internalType":"string","name":"_imageUrl","type":"string"},{"internalType":"string","name":"_question","type":"string"},{"internalType":"string[4]","name":"_options","type":"string[4]"},{"internalType":"bytes32","name":"_answer","type":"bytes32"},{"internalType":"address","name":"_creatorAddress","type":"address"}],"name":"createQuiz","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"","type":"string"},{"internalType":"address","name":"","type":"address"}],"name":"evalStatus","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"string","name":"_quizName","type":"string"},{"internalType":"address","name":"_userAddress","type":"address"}],"name":"getEvalStatus","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"string","name":"_quizName","type":"string"}],"name":"getQuizdetails","outputs":[{"components":[{"internalType":"string","name":"description","type":"string"},{"internalType":"string","name":"imageUrl","type":"string"},{"internalType":"string","name":"question","type":"string"},{"internalType":"string[4]","name":"options","type":"string[4]"},{"internalType":"bytes32","name":"answer","type":"bytes32"},{"internalType":"address","name":"creatorAddress","type":"address"}],"internalType":"struct WowTQuiz.Quiz","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"string","name":"_quizName","type":"string"}],"name":"getstringQuizdetails","outputs":[{"internalType":"string","name":"","type":"string"},{"internalType":"string","name":"","type":"string"},{"internalType":"string","name":"","type":"string"},{"internalType":"string[4]","name":"","type":"string[4]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint16","name":"_quizePoints","type":"uint16"},{"internalType":"uint16","name":"_createEligibility","type":"uint16"},{"internalType":"uint16","name":"_pointsToAnswer","type":"uint16"},{"internalType":"address","name":"_pointsContract","type":"address"},{"internalType":"address","name":"_communityContract","type":"address"}],"name":"initialize","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"pointsToAnswer","outputs":[{"internalType":"uint16","name":"","type":"uint16"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_userAddress","type":"address"},{"internalType":"string","name":"_quizName","type":"string"},{"internalType":"bytes32","name":"choice","type":"bytes32"}],"name":"quizEval","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"quizePoints","outputs":[{"internalType":"uint16","name":"","type":"uint16"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"string","name":"","type":"string"}],"name":"quizmap","outputs":[{"internalType":"string","name":"description","type":"string"},{"internalType":"string","name":"imageUrl","type":"string"},{"internalType":"string","name":"question","type":"string"},{"internalType":"bytes32","name":"answer","type":"bytes32"},{"internalType":"address","name":"creatorAddress","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"renounceOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint16","name":"_createEligibility","type":"uint16"}],"name":"setCreateEligibility","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint16","name":"_pointsToAnswer","type":"uint16"}],"name":"setPointsToAnswer","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint16","name":"_quizePoints","type":"uint16"}],"name":"setQuizePoints","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
  'WowTQuiz',
);

class WowTQuiz extends _i1.GeneratedContract {
  WowTQuiz({
    required _i1.EthereumAddress address,
    required _i1.Web3Client client,
    int? chainId,
  }) : super(
          _i1.DeployedContract(
            _contractAbi,
            address,
          ),
          client,
          chainId,
        );

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> checkAnswer(
    String _quizName,
    _i2.Uint8List choice, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[0];
    assert(checkSignature(function, '326ca712'));
    final params = [
      _quizName,
      choice,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> createEligibility({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '96bef46b'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> createQuiz(
    String _communityName,
    String _quizName,
    String _description,
    String _imageUrl,
    String _question,
    List<String> _options,
    _i2.Uint8List _answer,
    _i1.EthereumAddress _creatorAddress, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '4b1ebb5a'));
    final params = [
      _communityName,
      _quizName,
      _description,
      _imageUrl,
      _question,
      _options,
      _answer,
      _creatorAddress,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> evalStatus(
    String $param10,
    _i1.EthereumAddress $param11, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '68618f90'));
    final params = [
      $param10,
      $param11,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> getEvalStatus(
    String _quizName,
    _i1.EthereumAddress _userAddress, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, 'f5198bfb'));
    final params = [
      _quizName,
      _userAddress,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getQuizdetails(
    String _quizName, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '16ecdad1'));
    final params = [_quizName];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<GetstringQuizdetails> getstringQuizdetails(
    String _quizName, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, '5efe62e8'));
    final params = [_quizName];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return GetstringQuizdetails(response);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> initialize(
    BigInt _quizePoints,
    BigInt _createEligibility,
    BigInt _pointsToAnswer,
    _i1.EthereumAddress _pointsContract,
    _i1.EthereumAddress _communityContract, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, '8ccba74a'));
    final params = [
      _quizePoints,
      _createEligibility,
      _pointsToAnswer,
      _pointsContract,
      _communityContract,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> owner({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, '8da5cb5b'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> pointsToAnswer({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, '8d5410f8'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> quizEval(
    _i1.EthereumAddress _userAddress,
    String _quizName,
    _i2.Uint8List choice, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, 'c96b9c5a'));
    final params = [
      _userAddress,
      _quizName,
      choice,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> quizePoints({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[11];
    assert(checkSignature(function, 'f9994e2d'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<Quizmap> quizmap(
    String $param24, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, 'fe4309d4'));
    final params = [$param24];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Quizmap(response);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> renounceOwnership({
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[13];
    assert(checkSignature(function, '715018a6'));
    final params = [];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setCreateEligibility(
    BigInt _createEligibility, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[14];
    assert(checkSignature(function, '8c6f2c80'));
    final params = [_createEligibility];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setPointsToAnswer(
    BigInt _pointsToAnswer, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[15];
    assert(checkSignature(function, '5b0ebb1c'));
    final params = [_pointsToAnswer];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setQuizePoints(
    BigInt _quizePoints, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[16];
    assert(checkSignature(function, 'e4aa90c1'));
    final params = [_quizePoints];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> transferOwnership(
    _i1.EthereumAddress newOwner, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[17];
    assert(checkSignature(function, 'f2fde38b'));
    final params = [newOwner];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// Returns a live stream of all Answer events emitted by this contract.
  Stream<Answer> answerEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('Answer');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return Answer(decoded);
    });
  }

  /// Returns a live stream of all Initialized events emitted by this contract.
  Stream<Initialized> initializedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('Initialized');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return Initialized(decoded);
    });
  }

  /// Returns a live stream of all OwnershipTransferred events emitted by this contract.
  Stream<OwnershipTransferred> ownershipTransferredEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('OwnershipTransferred');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return OwnershipTransferred(decoded);
    });
  }
}

class GetstringQuizdetails {
  GetstringQuizdetails(List<dynamic> response)
      : var1 = (response[0] as String),
        var2 = (response[1] as String),
        var3 = (response[2] as String),
        var4 = (response[3] as List<dynamic>).cast<String>();

  final String var1;

  final String var2;

  final String var3;

  final List<String> var4;
}

class Quizmap {
  Quizmap(List<dynamic> response)
      : description = (response[0] as String),
        imageUrl = (response[1] as String),
        question = (response[2] as String),
        answer = (response[3] as _i2.Uint8List),
        creatorAddress = (response[4] as _i1.EthereumAddress);

  final String description;

  final String imageUrl;

  final String question;

  final _i2.Uint8List answer;

  final _i1.EthereumAddress creatorAddress;
}

class Answer {
  Answer(List<dynamic> response) : var1 = (response[0] as bool);

  final bool var1;
}

class Initialized {
  Initialized(List<dynamic> response) : version = (response[0] as BigInt);

  final BigInt version;
}

class OwnershipTransferred {
  OwnershipTransferred(List<dynamic> response)
      : previousOwner = (response[0] as _i1.EthereumAddress),
        newOwner = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress previousOwner;

  final _i1.EthereumAddress newOwner;
}
