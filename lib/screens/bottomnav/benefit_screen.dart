import 'package:ASmartApp/models/benefit_model.dart';
import 'package:ASmartApp/models/emp_value_model.dart';
import 'package:ASmartApp/models/pf_policy_model.dart';
import 'package:ASmartApp/services/rest_api.dart';
import 'package:ASmartApp/utils/my_style.dart';
import 'package:flutter/material.dart';

class BenefitScreen extends StatefulWidget {
  BenefitScreen({Key key}) : super(key: key);

  @override
  _BenefitScreenState createState() => _BenefitScreenState();
}

class _BenefitScreenState extends State<BenefitScreen> {
  List<BenefitModel> benefitModels = List();
  List<Widget> widgets = List();
  Map<String, dynamic> map = Map();
  PfPolicyModel pfPolicyModel;
  EmpPFValueModel empPFValueModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    map['IMEI'] = 'baac1234';
    map['pass'] = 'baac';

    readBenefit();
    readEmpPFPolicy();
    readEmpPFValue();
  }

  Future<Null> readEmpPFValue() async {
    String url = 'EmpPFValue';
    var result = await CallAPI().postData(map, url);
    for (var json in result) {
      setState(() {
        empPFValueModel = EmpPFValueModel.fromJson(json);
      });
    }
  }

  Future<Null> readEmpPFPolicy() async {
    String url = 'EmpPFPolicy';
    var result = await CallAPI().postData(map, url);
    for (var json in result) {
      setState(() {
        pfPolicyModel = PfPolicyModel.fromJson(json);
      });
    }
  }

  List<Widget> policyWidgets() {
    return <Widget>[
      Row(
        children: [
          Text('รหัสพนักงาน :'),
          Text(pfPolicyModel.eMPLOYEEID),
        ],
      ),
      Row(
        children: [
          Text('ลำดับที่นโยบาย :'),
          Text(pfPolicyModel.pOLICY),
        ],
      ),
      Row(
        children: [
          Text('จำนวนกองทุนตราสารหนี :'),
          Text(pfPolicyModel.iNSTRUMENTPERCENT),
        ],
      ),
      Row(
        children: [
          Text('จำนวนกองทุดตราสารทุน :'),
          Text(pfPolicyModel.eQUITYPERCENT),
        ],
      ),
      Row(
        children: [
          Text('อัดตราสมทบลูกจ่้าง :'),
          Text(pfPolicyModel.eMPCONTRIBUTEPERCENT),
        ],
      ),
      Row(
        children: [
          Text('อัดตราสมทบนายจ้าง :'),
          Text(pfPolicyModel.cOMPANYCONTRIBUTEPERCENT),
        ],
      ),
    ].toList();
  }

  Future<Null> readBenefit() async {
    String url = 'benefits';

    var result = await CallAPI().postData(map, url);
    print('######### result --->>> $result');

    for (var json in result) {
      BenefitModel model = BenefitModel.fromJson(json);
      Widget myWidget = createWidget(model);
      setState(() {
        benefitModels.add(model);
        widgets.add(myWidget);
      });
    }
  }

  Widget createWidget(BenefitModel model) => Card(
        child: ListTile(
          leading: Icon(Icons.pets),
          title: Text(model.listName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(MyStyle().formatAmount(model.amount)),
              Text(model.postDate),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (widgets.length == 0) ||
              (pfPolicyModel == null) ||
              (empPFValueModel == null)
          ? MyStyle().showProgress()
          : SingleChildScrollView(
              child: Column(
                children: [
                  buildCardBenefit(),
                  buildCardPolicy(),
                  buildCardEmpValue()
                ],
              ),
            ),
    );
  }

  Card buildCardEmpValue() {
    return Card(
      color: Color(0xff4b830d),
      child: ExpansionTile(
        title: Text(
          'ผลตอบแทนการลงทุน :',
          style: TextStyle(color: Colors.white),
        ),
        children: [
          Row(
            children: [
              Text(
                'รหัสพนักงาน :',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                empPFValueModel.eMPLOYEEID,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'ข้อมูล ณ วันที่ :',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                empPFValueModel.nAVDATE,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'นโยบาย :',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                empPFValueModel.pLANCODE,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ชื่อบริษัทจัดการ'),
                    Text('มูลค่าหน่วยลงทุน'),
                    Text('ส่วนของสมาชิกเงินสะสม'),
                    Text('ส่วนของสมาชิกผลประโยชน์'),
                    Text('ส่วนของนายจ้างเงินสมทบ'),
                    Text('ส่วนของนายจ้างผลประโยชน์'),
                    Text('จำนวนเงินรวม'),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(empPFValueModel.cOMPANYFUND1),
                    Text(empPFValueModel.nUNITFUND1),
                    Text(empPFValueModel.cONTEFUND1),
                    Text(empPFValueModel.eARNEFUND1),
                    Text(empPFValueModel.cONTCFUND1),
                    Text(empPFValueModel.eARNCFUND1),
                    Text(empPFValueModel.tOTALFUND1),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(empPFValueModel.cOMPANYFUND2),
                    Text(empPFValueModel.nUNITFUND2),
                    Text(empPFValueModel.cONTEFUND2),
                    Text(empPFValueModel.eARNEFUND2),
                    Text(empPFValueModel.cONTCFUND2),
                    Text(empPFValueModel.eARNCFUND2),
                    Text(empPFValueModel.tOTALFUND2),
                  ],
                ),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('ผลประโยชน์ การลงทุน'),
              Text(empPFValueModel.tOTALFUND1FUND2)
            ],
          ),
        ],
      ),
    );
  }

  Card buildCardPolicy() {
    return Card(
      color: Color(0xff7cb342),
      child: ExpansionTile(
        title: Text('นโยบายการลงทุน :'),
        children: policyWidgets(),
      ),
    );
  }

  Card buildCardBenefit() {
    return Card(
      color: Color(0xffaee571),
      child: ExpansionTile(
        title: Text('สวัสดิการ :'),
        children: widgets,
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: benefitModels.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: Icon(Icons.pets),
          title: Text(benefitModels[index].listName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${MyStyle().formatAmount(benefitModels[index].amount)} บาท'),
              Text(benefitModels[index].postDate),
            ],
          ),
        ),
      ),
    );
  }
}
