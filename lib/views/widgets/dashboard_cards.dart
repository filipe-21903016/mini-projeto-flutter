import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:i_que_peso/blocs/entry_bloc.dart';
import 'package:i_que_peso/services/data_service.dart';

import '../screens/list_screen.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({Key? key}) : super(key: key);

  double getBigBoxWidth(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.86;
  }

  double getBigBoxHeight(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.23;
  }

  double getSmallBoxWidth(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.42;
  }

  double getSmallBoxHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.16;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        const Center(
          child: PersonalInfo(),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        Center(
          child: MyGradientCard(
            //graph
            height: MediaQuery.of(context).size.height * 0.23,
            width: MediaQuery.of(context).size.width * 0.86,
            child: Container(),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyGradientCard(
              height: MediaQuery.of(context).size.width * 0.3,
              width: getSmallBoxWidth(context),
              child: BlocBuilder<EntryBloc, EntryState>(
                builder: (context, state) {
                  double currentWeight = 0;
                  double inicialWeight = 0;
                  if (state is LoadEntriesState) {
                    currentWeight = DataService.getLastWeight();
                    inicialWeight = DataService.getFirstWeight();
                  }
                  return PercursoWidget(
                    inicialWeight: inicialWeight,
                    currentWeight: currentWeight,
                  );
                },
              ),
            ),
            BlocBuilder<EntryBloc, EntryState>(
              builder: (context, state) {
                double mean = 0;
                if (state is LoadEntriesState) {
                  mean = DataService.get7DayWeightMean();
                }
                return MyGradientCard(
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: getSmallBoxWidth(context),
                  child: MediasWidget(media: mean),
                );
              },
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        BlocBuilder<EntryBloc, EntryState>(
          builder: (context, state) {
            double feelMean = 0;
            if (state is LoadEntriesState) {
              feelMean = DataService.get7DayFeelMean();
            }
            return MyGradientCard(
              height: MediaQuery.of(context).size.height * 0.06,
              width: getBigBoxWidth(context),
              child: InformationWidget(
                icon: const Icon(
                  Icons.sentiment_satisfied_alt_outlined,
                  size: 28,
                  color: Color(0XFFF4F9FF),
                ),
                text: "Satisfação 7 Dias",
                value: "${feelMean.toString()}",
              ),
            );
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
        BlocBuilder<EntryBloc, EntryState>(
          builder: (context, state) {
            double variationPerc = 0;
            if (state is LoadEntriesState) {
              variationPerc = DataService.getWeightVariationPercentage();
            }
            return MyGradientCard(
              height: MediaQuery.of(context).size.height * 0.06,
              width: getBigBoxWidth(context),
              child: InformationWidget(
                icon: Icon(
                  Icons.timeline_outlined,
                  size: 28,
                  color: Color(0XFFF4F9FF),
                ),
                text: "Variação do Peso 7 Dias",
                value: "${variationPerc.toString()}%",
              ),
            );
          },
        ),
      ],
    );
  }
}

class MyGradientCard extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const MyGradientCard(
      {Key? key,
      required this.height,
      required this.width,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      gradient: const LinearGradient(
          colors: <Color>[Color(0xFF6FB1FF), Color(0xFF93A4FF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
      elevation: 0,
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.437,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.height * 0.11,
            height: MediaQuery.of(context).size.height * 0.11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              image: const DecorationImage(
                image: AssetImage("lib/assets/avatar.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Text(
            "Filipe Coutinho",
            style: TextStyle(
              color: Color(0xFF021327),
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class PercursoWidget extends StatelessWidget {
  final double inicialWeight;
  final double currentWeight;

  const PercursoWidget(
      {Key? key, required this.inicialWeight, required this.currentWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 6.0),
            child: Icon(
              Icons.monitor_weight_outlined,
              color: Color(0XFFF4F9FF),
              size: 65,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Column(
                  children: [
                    Text(
                      "Peso Inicial",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Color(0XFFF4F9FF),
                      ),
                    ),
                    Text(
                      "${inicialWeight.toString()}kg",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: Color(0XFFF4F9FF),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Column(
                  children: [
                    Text(
                      "Peso Atual",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Color(0XFFF4F9FF),
                      ),
                    ),
                    Text(
                      "${currentWeight.toString()}kg",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: Color(0XFFF4F9FF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MediasWidget extends StatelessWidget {
  final double media;

  const MediasWidget({Key? key, required this.media}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 6.0),
            child: Icon(
              Icons.assessment_outlined,
              color: Color(0XFFF4F9FF),
              size: 65,
            ),
          ),
          Text(
            "Média 7 Dias",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Color(0XFFF4F9FF),
            ),
          ),
          Text(
            "${media.toString()} kg",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: Color(0XFFF4F9FF),
            ),
          ),
        ],
      ),
    );
  }
}

class InformationWidget extends StatelessWidget {
  final String text;
  final Icon icon;
  final String value;

  const InformationWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0XFFF4F9FF),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0XFFF4F9FF),
            ),
          ),
        ],
      ),
    );
  }
}
