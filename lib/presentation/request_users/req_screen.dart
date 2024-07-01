import 'package:flutter/material.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/request_users/req_controller.dart';
import 'package:get/get.dart';

class ReqScreen extends StatefulWidget {
  const ReqScreen({super.key});

  @override
  State<ReqScreen> createState() => _ReqScreenState();
}

class _ReqScreenState extends State<ReqScreen> {

  ReqController reqController = Get.put(ReqController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Requests"),
      ),
      body: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
            itemCount: reqController.reqModel.requests!.length,
            itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  ApiRepository.acepedReqest(byUserId: reqController.reqModel.requests![index].byUserId!, toUserId: reqController.reqModel.requests![index].toUserId!, notificationId: reqController.reqModel.requests![index].id!);
                },
                child: Container(
                  color: Colors.green,
                 child: Column(
                   children: [
                     Text("${reqController.reqModel.requests![index].byUser?.fullName}"),
                     Text("${reqController.reqModel.requests![index].followStatus}"),
                   ],
                 )
                ),
              ),
            );
          },)


        ],

      ),
    );
  }
}
