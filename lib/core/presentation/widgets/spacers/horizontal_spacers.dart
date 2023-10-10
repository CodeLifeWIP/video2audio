import 'package:flutter/widgets.dart';

class HorizontalSpacer1 extends StatelessWidget {
  const HorizontalSpacer1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: SizedBox(),
    );
  }
}

class HorizontalSpacer2 extends StatelessWidget {
  const HorizontalSpacer2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: SizedBox(),
    );
  }
}

class HorizontalSpacer4 extends StatelessWidget {
  const HorizontalSpacer4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(),
    );
  }
}

class HorizontalSpacer8 extends StatelessWidget {
  const HorizontalSpacer8({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .008),
      child: const SizedBox(),
    );
  }
}

class HorizontalSpacer16 extends StatelessWidget {
  const HorizontalSpacer16({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .016),
      child: const SizedBox(),
    );
  }
}

class HorizontalSpacer32 extends StatelessWidget {
  const HorizontalSpacer32({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .032),
      child: const SizedBox(),
    );
  }
}