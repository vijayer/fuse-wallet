import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/constans/exchangable_tokens.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/jobs/swap_token_job.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/models/pro/views/pro_wallet.dart';
import 'package:fusecash/screens/pro_mode/swap_tile.dart';
import 'package:fusecash/screens/pro_mode/token_tile.dart';
import 'package:fusecash/utils/addresses.dart';

String getTokenUrl(tokenAddress) {
  return tokenAddress == zeroAddress
      ? 'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/info/logo.png'
      : "https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/assets/$tokenAddress/logo.png";
}

class AssetsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ProWalletViewModel>(
        distinct: true,
        converter: ProWalletViewModel.fromStore,
        builder: (_, viewModel) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 15, top: 27, bottom: 8),
                      child: Text(I18n.of(context).assets_and_contracts,
                          style: TextStyle(
                              color: Color(0xFF979797),
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal))),
                  ListView(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      children: [
                        viewModel.hasTrasnferdToForeign
                            ? _TokenPendingRow(
                                token: daiToken,
                              )
                            : SizedBox.shrink(),
                        ...viewModel.swapActions
                            .map((SwapTokenJob swapToken) => SwapTokenTile(
                                  swapToken: swapToken,
                                ))
                            .toList(),
                        ...viewModel.tokens
                            .map((Token token) => TokenTile(
                                  token: token,
                                ))
                            .toList()
                      ])
                ]));
  }
}

class _TokenPendingRow extends StatelessWidget {
  _TokenPendingRow({this.token});
  final Token token;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          border: Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
      child: ListTile(
          contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 0),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  flex: 12,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Hero(
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFE0E0E0),
                                radius: 27,
                                backgroundImage: token.imageUrl != null &&
                                        token.imageUrl.isNotEmpty
                                    ? NetworkImage(token.imageUrl)
                                    : NetworkImage(
                                        getTokenUrl(checksumEthereumAddress(
                                            token.address)),
                                      ),
                              ),
                              tag: token.name,
                            ),
                            Container(
                                width: 55,
                                height: 55,
                                child: CircularProgressIndicator(
                                  backgroundColor:
                                      Color(0xFF49D88D).withOpacity(0),
                                  strokeWidth: 3,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Color(0xFF49D88D).withOpacity(1)),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Flexible(
                        flex: 10,
                        child: Text(token.name,
                            style: TextStyle(
                                color: Color(0xFF333333), fontSize: 15)),
                      ),
                    ],
                  )),
              Flexible(
                  flex: 4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              overflow: Overflow.visible,
                              alignment: AlignmentDirectional.bottomEnd,
                              children: <Widget>[
                                new RichText(
                                    text: new TextSpan(children: <TextSpan>[
                                  new TextSpan(
                                      text: I18n.of(context).pending,
                                      style: new TextStyle(
                                          fontSize: 13.0,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ]))
                              ],
                            )
                          ],
                        )
                      ]))
            ],
          )),
    );
  }
}
