import 'package:ASmartApp/models/fund_loan_model.dart';
import 'package:ASmartApp/models/funddetail_model.dart';
import 'package:ASmartApp/services/rest_api.dart';
import 'package:ASmartApp/utils/my_style.dart';
import 'package:flutter/material.dart';

class FundLoanScreen extends StatefulWidget {
  FundLoanScreen({Key key}) : super(key: key);

  @override
  _FundLoanScreenState createState() => _FundLoanScreenState();
}

class _FundLoanScreenState extends State<FundLoanScreen> {
  Map<String, dynamic> data = Map();
  List<FundDetailModel> fundDetailModels = List();
  List<Widget> fundDetailContracNos = List();
  List<Widget> fundLoanWidgets = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    data['IMEI'] = 'baac1234';
    data['pass'] = 'baac';

    readFundDetail();
    readFundLoan();
  }

  Future<Null> readFundLoan() async {
    var result = await CallAPI().postData(data, 'FundLoan/');
    for (var json in result) {
      FundLoanModel model = FundLoanModel.fromJson(json);
      setState(() {
        fundLoanWidgets.add(createFundLoanWidget(model));
      });
    }
  }

  Widget createFundLoanWidget(FundLoanModel model) => ListTile(
        leading: Icon(Icons.article, color: Colors.white,),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('เลขที่สัญญา', style: MyStyle().whiteStyle(),),
            Text(model.contractNo, style: MyStyle().whiteStyle(),),
          ],
        ),
        subtitle: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('วงเงินกู้ :', style: MyStyle().whiteStyle(),),
                Text('${model.loanAmount} บาท', style: MyStyle().whiteStyle(),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('สถานะสัญญา :', style: MyStyle().whiteStyle(),),
                Text(model.stateName, style: MyStyle().whiteStyle(),),
              ],
            ),
          ],
        ),
      );

  Future<Null> readFundDetail() async {
    var result = await CallAPI().postData(data, 'FundDetail/');
    // print('########## result FundDetail ==>> $result');
    for (var json in result) {
      FundDetailModel model = FundDetailModel.fromJson(json);
      setState(() {
        fundDetailModels.add(model);
        fundDetailContracNos.add(createFundDeailContractNo(model));
      });
    }
  }

  Widget createDetailContractNo(FundDetailModel model) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text('เลขที่สัญญา :'),
                ),
                Expanded(
                  flex: 1,
                  child: Text(model.contractNo),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text('วงเงินกู้ :'),
                ),
                Expanded(
                  flex: 1,
                  child: Text(model.loanAmount),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text('งวดชำระ :'),
                ),
                Expanded(
                  flex: 1,
                  child: Text(model.receiveMaxtime),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text('ยอดชำระต่องวด :'),
                ),
                Expanded(
                  flex: 1,
                  child: Text(model.payPerPeriod),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text('ยอดคงเหลือ :'),
                ),
                Expanded(
                  flex: 1,
                  child: Text(model.debtBalance),
                ),
              ],
            ),
          ),
        ],
      );

  Widget createFundDeailContractNo(FundDetailModel model) => ExpansionTile(
        leading: Icon(Icons.account_balance),
        title: Text('เลขที่สัญญา : ${model.contractNo}'),
        subtitle: Text('หนี้คงเหลือ : ${model.debtBalance} บาท'),
        children: [createDetailContractNo(model)],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (fundDetailContracNos.length == 0) || (fundLoanWidgets.length == 0)
          ? MyStyle().showProgress()
          : SingleChildScrollView(
                      child: Column(
                children: [
                  Card(
                    color: MyStyle().weakColor,
                    child: ExpansionTile(
                      title: Text('ข้อมูลสัญญา'),
                      children: fundDetailContracNos,
                    ),
                  ),
                  Card(
                    color: MyStyle().primaryColor,
                    child: ExpansionTile(
                      title: Text('ข้อมูลสถานะสัญญา'),
                      children: fundLoanWidgets,
                    ),
                  ),
                ],
              ),
          ),
    );
  }
}
