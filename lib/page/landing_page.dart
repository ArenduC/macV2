import 'package:flutter/material.dart';
import 'package:maca/common/loading_component.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/package/m_column_graph.dart';
import 'package:maca/service/api_service.dart';
import 'package:maca/store/local_store.dart';
import 'package:maca/styles/colors/app_colors.dart';
import 'package:maca/widget/app_common_widget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  dynamic expenditureDetails = [];
  bool isLoading = true;

  @override
  void initState() {
    initialization();
    borderList();
    getLoginDetails();
    super.initState();
  }

  void initialization() {
    setState(() {
      isLoading = true;
    });
  }

  Future<void> borderList() async {
    dynamic response = await ApiService().apiCallService(endpoint: GetUrl().currentExpenditureDetails, method: "GET");

    setState(() {
      expenditureDetails = AppFunction().macaApiResponsePrintAndGet(data: response)["data"];
      isLoading = false;
    });
  }

  getLoginDetails() async {
    dynamic loginDetails;
    loginDetails = await LocalStore().getStore(ListOfStoreKey.loginDetails);
    macaPrint(loginDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.themeWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Maca'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_alert),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: isLoading
                ? const LoadingComponent()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CurrentManagerView(
                        data: expenditureDetails[0]["user_type_name"],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ExpenditureTiles(data: expenditureDetails),
                      const SizedBox(
                        height: 16,
                      ),
                      MColumnGraph(data: expenditureDetails),
                    ],
                  )));
  }
}
