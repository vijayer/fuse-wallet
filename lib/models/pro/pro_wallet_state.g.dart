// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pro_wallet_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProWalletState _$ProWalletStateFromJson(Map<String, dynamic> json) {
  return ProWalletState(
    blockNumber: json['blockNumber'] as num,
    erc20Tokens: (json['erc20Tokens'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Token.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$ProWalletStateToJson(ProWalletState instance) =>
    <String, dynamic>{
      'blockNumber': instance.blockNumber,
      'erc20Tokens':
          instance.erc20Tokens?.map((k, e) => MapEntry(k, e?.toJson())),
    };
