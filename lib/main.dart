import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "BMI Calculator",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //น้ำหนัก
  TextEditingController weightController = TextEditingController();
  //ส่วนสูง
  TextEditingController heightController = TextEditingController();
  //IMC
  String _infoText = "";
  String _infoText2 = "";
  String _infoText3 = "";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  
// ล้างข้อมูล
  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "";
      _infoText2 = "";
      _infoText3 = "";
      _formKey = GlobalKey<FormState>();
    });
  }

// คำนวณ
  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      
      if (imc < 18.5) {
        _infoText = "ค่าดัชนีมวลกายของคุณ (BMI) คือ ${imc.toStringAsPrecision(3)} \nอยู่ในเกณฑ์ น้ำหนักน้อย / ผอม";
        _infoText2 = "ข้อแนะนำ :";
        _infoText3 = "กินอาหารที่มีคุณค่าพลังงานสูงกว่าปกติและออกกำลังกายเพื่อเพิ่มน้ำหนักให้กับตัวคุณ";
      } else if (imc >= 18.5 && imc < 23) {
        _infoText = "ค่าดัชนีมวลกายของคุณ (BMI) คือ ${imc.toStringAsPrecision(3)} \nอยู่ในเกณฑ์ น้ำหนักปกติ";
        _infoText2 = "ข้อแนะนำ :";
        _infoText3 = "คุณควรกินอาหารที่มีคุณค่าพลังงานปกติและควรออกกำลังกายเพื่อเพิ่มและบรรลุรูปร่างที่คุณต้องการ";
      } else if (imc >= 23 && imc < 25) {
        _infoText = "ค่าดัชนีมวลกายของคุณ (BMI) คือ ${imc.toStringAsPrecision(3)} \nอยู่ในเกณฑ์ ท้วม / อ้วนระดับ 1";
        _infoText2 = "ข้อแนะนำ :";
        _infoText3 = "คุณควรกินอาหารที่มีคุณค่าพลังงานต่ำกว่าปกติและควรออกกำลังกายเพื่อลดน้ำหนักให้กับตัวคุณ";
      } else if (imc >= 25 && imc < 30) {
        _infoText = "ค่าดัชนีมวลกายของคุณ (BMI) คือ ${imc.toStringAsPrecision(3)} \nอยู่ในเกณฑ์ อ้วน / อ้วนระดับ 2";
        _infoText2 = "ข้อแนะนำ :";
        _infoText3 = "สุขภาพของคุณน่าเป็นห่วง คุณควรกินอาหารที่มีคุณค่าพลังงานต่ำกว่าปกติและควรออกกำลังกายเพื่อลดน้ำหนักให้กับตัวคุณ";
      } else {
        _infoText = "ค่าดัชนีมวลกายของคุณ (BMI) คือ ${imc.toStringAsPrecision(3)} \nอยู่ในเกณฑ์ อ้วนมาก / อ้วนระดับ 3";
        _infoText2 = "ข้อแนะนำ :";
        _infoText3 = "สุขภาพของคุณค่อนข้างแย่ คุณควรกินอาหารที่มีคุณค่าพลังงานต่ำกว่าปกติและควรออกกำลังกายเพื่อลดน้ำหนักให้กับตัวคุณ";
      } 

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "โปรแกรมคำนวณค่าดัชนีมวลกาย",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.green[400],
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _resetFields();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(""),
              Image.asset("assets/images/BMI.png", height: 200, fit: BoxFit.cover),
              Text(""),
              TextFormField(
                controller: heightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "กรุณากรอกส่วนสูง";
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "ส่วนสูง (เซนติเมตร)",
                  labelStyle: TextStyle(color: Colors.green[800]),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 20),
              ),
              TextFormField(
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "กรุณากรอกน้ำหนัก";
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "น้ำหนัก (กิโลกรัม)",
                  labelStyle: TextStyle(color: Colors.green[800]),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        calculate();
                      }
                    },
                    // ignore: prefer_const_constructors
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                    child: const Text(
                      'คำนวณ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              Text(""),
              Text("$_infoText ",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Text("\n$_infoText2 ",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text("$_infoText3 ",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}