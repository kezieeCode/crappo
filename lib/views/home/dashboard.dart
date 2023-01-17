import 'dart:math';
import 'package:crypto_tracker/views/details/detail_screen.dart';
import 'package:crypto_tracker/views/withdraw/withdraw.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart'
    as slideDialog;
import 'package:crypto_tracker/core/res/color.dart';
import 'package:crypto_tracker/core/res/particles.dart';
import 'package:crypto_tracker/models/particle.dart';
import 'package:crypto_tracker/models/spline_area.dart';
import 'package:crypto_tracker/widgets/credit_painter.dart';
import 'package:crypto_tracker/widgets/crypto_card.dart';
import 'package:crypto_tracker/widgets/custom_graph.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  List<Particle> _particlesList = [];
  final Random _random = Random(DateTime.now().millisecondsSinceEpoch);
  final maxSpeed = 2;
  final maxTheta = 2 * pi;
  final maxRadius = 10;
  AnimationController _particleAnimationController;
  Animation<double> _particleAnimation;
  List<SplineAreaData> firstChartData, secondChartData;

  @override
  initState() {
    super.initState();
    firstChartData = <SplineAreaData>[
      SplineAreaData(2010, 8.53, 3.3),
      SplineAreaData(2011, 9.5, 5.4),
      SplineAreaData(2012, 10, 2.65),
      SplineAreaData(2013, 9.4, 2.62),
      SplineAreaData(2014, 5.8, 1.99),
      SplineAreaData(2015, 4.9, 1.44),
      SplineAreaData(2016, 4.5, 2),
      SplineAreaData(2017, 3.6, 1.56),
      SplineAreaData(2018, 3.43, 2.1),
    ];
    secondChartData = <SplineAreaData>[
      SplineAreaData(2010, 4.53, 3.3),
      SplineAreaData(2011, 8.5, 5.4),
      SplineAreaData(2012, 2, 2.65),
      SplineAreaData(2013, 9.4, 2.62),
      SplineAreaData(2014, 5.8, 1.99),
      SplineAreaData(2015, 4.9, 1.44),
      SplineAreaData(2016, 4.5, 2),
      SplineAreaData(2017, 9.6, 1.56),
      SplineAreaData(2018, 12.43, 2.1),
    ];

    _particleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _particleAnimation =
        Tween<double>(begin: 0, end: 300).animate(_particleAnimationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _particleAnimationController.repeat();
            } else if (status == AnimationStatus.dismissed) {
              _particleAnimationController.forward();
            }
          });
    _particleAnimationController.forward();

    _particlesList = List.generate(5, (index) {
      final color = ParticleGenerator.getRandomColor(_random);
      return Particle(
        position: const Offset(-1, -1),
        color: color,
        speed: _random.nextDouble() * maxSpeed,
        theta: _random.nextDouble() * maxTheta,
        radius: _random.nextDouble() * maxRadius,
      );
    }).toList();
  }

  @override
  void dispose() {
    _particleAnimationController.dispose();
    super.dispose();
  }

  _navigate(Widget child) {
    Navigator.push(context,
        PageTransition(type: PageTransitionType.leftToRight, child: child));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              Container(
                width: 100.w,
                height: 180,
                decoration: BoxDecoration(
                  gradient: AppColors.getDarkLinearGradient(Colors.blue),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomPaint(
                  painter: CreditCardPainter(
                    _particleAnimation.value,
                    particlesList: _particlesList,
                    random: _random,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Deposited wallet Balance",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 1.6,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Welcome bonus +30% expired in 21 days",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 40),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(bottom: 17),
                                child: Text(
                                  "USD",
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text("\$500,000",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      _showDialog() {
                        return showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return SingleChildScrollView(
                                child: AlertDialog(
                                  backgroundColor: const Color(0xFF090D20),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  content: Container(
                                    width: 500.w,
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const DetailScreen(
                                                          bitAdress:
                                                              "3fd4kfsfkafqxtu5zpy8s3rqyzb9uk3dhq",
                                                        ))));
                                          },
                                          child: _buildCardInformation(
                                              Colors.orange,
                                              "Bitcoin",
                                              Icon(
                                                Icons.currency_bitcoin_sharp,
                                                size: 30.sp,
                                              )),
                                        ),
                                        SizedBox(height: 6.h),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const DetailScreen(
                                                          bitAdress:
                                                              "0x34774660a06b31ae21b26ec1a34bb1f17a66a037",
                                                        ))));
                                          },
                                          child: _buildCardInformation(
                                              Colors.blue,
                                              'Etherum',
                                              Image.asset(
                                                "assets/images/ethereum.png",
                                                width: 10.w,
                                              )),
                                        ),
                                        SizedBox(height: 6.h),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const DetailScreen(
                                                          bitAdress:
                                                              "0x384bcbab7463b902f39c790234e847fc623c0947",
                                                        ))));
                                          },
                                          child: _buildCardInformation(
                                              Colors.white,
                                              "BNB",
                                              Image.asset(
                                                "assets/images/bnb.png",
                                                width: 10.w,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const DetailScreen(
                                                          bitAdress:
                                                              "ddzffzcqrhsg24wp2nx8avz6wq5r1apzyvdmudsk7pu2cdhhfd1r37qctfvrprpssjxg1jrx6wtkpznfhsdodzl6anh3jvhw4zwlfqbc",
                                                        ))));
                                          },
                                          child: _buildCardInformation(
                                              Colors.white,
                                              "Cardano",
                                              Image.asset(
                                                "assets/images/cardano.png",
                                                width: 10.w,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const DetailScreen(
                                                          bitAdress:
                                                              "dsbxsk1q66yfqrtgq6dqnulzpv5hpfcwpf",
                                                        ))));
                                          },
                                          child: _buildCardInformation(
                                              Colors.white,
                                              "Dodge",
                                              Image.asset(
                                                  "assets/images/dodge.png",
                                                  width: 10.w)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }

                      _showDialog();
                    },
                    child: const Icon(
                      Icons.download,
                      color: Colors.purpleAccent,
                      size: 20,
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    _navigate(WithdrawalScreen());
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.assured_workload,
                      color: Colors.purpleAccent,
                      size: 20,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner_sharp,
                    color: Colors.purpleAccent,
                    size: 20,
                  ),
                )
                // Icons.settings,
              ]),
              const SizedBox(
                height: 20,
              ),
              const CryptoCard(),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 43.w,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "ZRX/USDT",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                              ),
                            ),
                            Text(
                              "-2.25%",
                              style: TextStyle(color: Colors.red[400]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 43.w,
                          child: _buildSplineAreaChart(
                            firstChartData,
                            borderColor: Colors.red[200],
                            gradientColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 43.w,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "BNB/USDT",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                              ),
                            ),
                            Text(
                              "+40.25%",
                              style: TextStyle(color: Colors.green[400]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 43.w,
                          child: _buildSplineAreaChart(
                            secondChartData,
                            borderColor: Colors.green[200],
                            gradientColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardInformation(
      Color circleColors, String leadingTitle, Widget iconType) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 15, 21, 52),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 45, 40, 146),
              offset: Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Color.fromARGB(255, 20, 11, 144),
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
        ),
        child: ListTile(
          leading: Container(
            decoration:
                BoxDecoration(color: circleColors, shape: BoxShape.circle),
            child: iconType,
          ),
          title: Text(leadingTitle),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  CustomGraph _buildSplineAreaChart(
    List<SplineAreaData> datas, {
    Color borderColor,
    MaterialColor gradientColor,
  }) {
    return CustomGraph(
      datas: datas,
      borderColor: borderColor,
      gradientColor: gradientColor,
    );
  }
}
