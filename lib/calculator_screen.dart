import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Calculator",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    output == '' ? 0.toString() : output,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
              Container(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  btn(
                    text: 'C',
                    onTap: () {
                      setState(() {
                        output = '';
                      });
                    },
                    btnWidth: 70,
                    btnColor: Colors.grey.shade300,
                    textColor: Colors.black,
                  ),
                  btn(
                    btnWidth: 70,
                    text: '<-',
                    onTap: () {
                      setState(() {
                        output = output.substring(0, output.length - 1);
                      });
                    },
                    btnColor: Colors.grey.shade300,
                    textColor: Colors.black,
                  ),
                  btn(
                    btnWidth: 70,
                    text: '%',
                    onTap: () {
                      if (output.isEmpty ||
                          (output[output.length - 1] == '*' ||
                              output[output.length - 1] == '/' ||
                              output[output.length - 1] == '+' ||
                              output[output.length - 1] == '-')) {
                      } else {
                        setState(() {
                          output += '%';
                        });
                      }
                    },
                    btnColor: Colors.grey.shade300,
                    textColor: Colors.black,
                  ),
                  btn(
                    btnWidth: 70,
                    text: '/',
                    onTap: () {
                      if (output.isEmpty ||
                          (output[output.length - 1] == '*' ||
                              output[output.length - 1] == '/' ||
                              output[output.length - 1] == '+' ||
                              output[output.length - 1] == '-')) {
                      } else {
                        setState(() {
                          output += '/';
                        });
                      }
                    },
                    btnColor: Colors.grey.shade300,
                    textColor: Colors.black,
                  ),
                ],
              ),
              Container(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  btn(
                    btnWidth: 70,
                    text: '7',
                    onTap: () {
                      setState(() {
                        output += '7';
                      });
                    },
                    btnColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  btn(
                    text: '8',
                    onTap: () {
                      setState(() {
                        output += '8';
                      });
                    },
                    btnWidth: 70,
                    btnColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  btn(
                    btnWidth: 70,
                    text: '9',
                    onTap: () {
                      setState(() {
                        output += '9';
                      });
                    },
                    btnColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  btn(
                    btnWidth: 70,
                    text: 'x',
                    onTap: () {
                      if (output.isEmpty ||
                          (output[output.length - 1] == '*' ||
                              output[output.length - 1] == '/' ||
                              output[output.length - 1] == '+' ||
                              output[output.length - 1] == '-')) {
                      } else {
                        setState(() {
                          output += 'x';
                        });
                      }
                    },
                    btnColor: Colors.grey.shade300,
                    textColor: Colors.black,
                  ),
                ],
              ),
              Container(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  btn(
                    text: '4',
                    onTap: () {
                      setState(() {
                        output += '4';
                      });
                    },
                    btnWidth: 70,
                    btnColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  btn(
                    text: '5',
                    onTap: () {
                      setState(() {
                        output += '5';
                      });
                    },
                    btnWidth: 70,
                    btnColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  btn(
                    text: '6',
                    onTap: () {
                      setState(() {
                        output += '6';
                      });
                    },
                    btnWidth: 70,
                    btnColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  btn(
                    btnWidth: 70,
                    text: '-',
                    onTap: () {
                      if (output.isEmpty ||
                          (output[output.length - 1] == '*' ||
                              output[output.length - 1] == '/' ||
                              output[output.length - 1] == '+' ||
                              output[output.length - 1] == '-')) {
                      } else {
                        setState(() {
                          output += '-';
                        });
                      }
                    },
                    btnColor: Colors.grey.shade300,
                    textColor: Colors.black,
                  ),
                ],
              ),
              Container(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  btn(
                    btnWidth: 70,
                    text: '1',
                    onTap: () {
                      setState(() {
                        output += '1';
                      });
                    },
                    btnColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  btn(
                    text: '2',
                    onTap: () {
                      setState(() {
                        output += '2';
                      });
                    },
                    btnWidth: 70,
                    btnColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  btn(
                    btnWidth: 70,
                    text: '3',
                    onTap: () {
                      setState(() {
                        output += '3';
                      });
                    },
                    btnColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  btn(
                    btnWidth: 70,
                    text: '+',
                    onTap: () {
                      if (output.isEmpty ||
                          (output[output.length - 1] == '*' ||
                              output[output.length - 1] == '/' ||
                              output[output.length - 1] == '+' ||
                              output[output.length - 1] == '-')) {
                      } else {
                        setState(() {
                          output += '+';
                        });
                      }
                    },
                    btnColor: Colors.grey.shade300,
                    textColor: Colors.black,
                  ),
                ],
              ),
              Container(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  btn(
                    btnWidth: 70,
                    text: '0',
                    onTap: () {
                      setState(() {
                        output += '0';
                      });
                    },
                    btnColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  btn(
                    btnWidth: 70,
                    text: '.',
                    onTap: () {
                      setState(() {
                        output += '.';
                      });
                    },
                    btnColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  btn(
                    btnWidth: 170,
                    text: '=',
                    onTap: () {
                      try {
                        output = output.replaceAll('x', '*');
                        Parser p = Parser();
                        Expression exp = p.parse(output);
                        String result = exp
                            .evaluate(
                              EvaluationType.REAL,
                              ContextModel(),
                            )
                            .toString();
                        setState(() {
                          output = result;
                        });
                      } catch (e) {
                        //print(e.toString());
                        setState(() {
                          e.toString() ==
                                  'RangeError (index): Invalid value: Valid value range is empty: -1'
                              ? output = 'Syntax Error'
                              : '';
                        });
                      }
                    },
                    btnColor: Colors.orange.shade300,
                    textColor: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget btn({
    required String text,
    required Function() onTap,
    required Color btnColor,
    required Color textColor,
    required double btnWidth,
  }) {
    return AnimatedButton(
      onPressed: onTap,
      color: btnColor,
      width: btnWidth,
      height: 70,
      shadowDegree: ShadowDegree.dark,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
