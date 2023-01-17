import 'package:crypto_tracker/views/home/crypto_coin.dart';
import 'package:crypto_tracker/widgets/crypto_tile.dart';
import 'package:flutter/material.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  final _listItems = <Widget>[];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  Widget getListTile(CryptoCoin coin) {
    return CryptoTile(
      coin: coin,
    );
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    var future = Future(() {});
    for (var i = 0; i < CryptoCoin.datas.length; i++) {
      future = future.then((_) {
        return Future.delayed(const Duration(milliseconds: 100), () {
          _listItems.add(getListTile(CryptoCoin.datas[i]));
          _listKey.currentState?.insertItem(i);
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
        child: Text("Transaction history"),
      ),
      _buildHistory("John Doe", "26-12-2022", "\$100"),
      _buildHistory("Jeff Martins", "20-10-2022", "\$5000"),
      _buildHistory("Chikezie Smart", "25-10-2022", "\$4000"),
      _buildHistory("Chikezie Smart", "25-10-2022", "\$4000"),
      _buildHistory("Chikezie Smart", "25-10-2022", "\$4000"),
      _buildHistory("Chikezie Smart", "25-10-2022", "\$4000"),
      _buildHistory("Chikezie Smart", "25-10-2022", "\$4000")
    ]));
  }

  Widget _buildHistory(
      String titleText, String subtitleText, String trailingText) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.purple,
        radius: 20,
        child: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.person,
            color: Color.fromARGB(255, 8, 15, 59),
          ),
        ),
      ),
      title: Text(titleText, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitleText),
      trailing: Text(trailingText),
    );
  }
}
