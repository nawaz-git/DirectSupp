import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var value = ''.obs;
    var message = ''.obs;
    // ignore: unnecessary_new
    TextEditingController phoneNumber = new TextEditingController();
    TextEditingController messageController = new TextEditingController();

    return Scaffold(
      body: Column(children: [
        // ignore: avoid_unnecessary_containers
        const SizedBox(
          height: 90,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Whats',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan),
            ),
            Text(
              'Direct ',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Phone Number',
              suffixIcon: IconButton(
                  onPressed: () {
                    Clipboard.getData(Clipboard.kTextPlain).then((value) {
                      phoneNumber.text = value!.text.toString();
                      //print(value!.text); //value is clipbarod data
                    });
                  },
                  icon: const Icon(Icons.content_paste)),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              //prefixText: '+91 ',
              isDense: true,
              prefixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                    child: Text(
                      "+91 ",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              contentPadding: const EdgeInsets.all(20),
            ),
            controller: phoneNumber,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            minLines: 8,
            maxLines: 10,
            decoration: const InputDecoration(
              hintText: 'Type your Message',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              isDense: true,
              contentPadding: EdgeInsets.all(20),
            ),
            controller: messageController,
          ),
        ),
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(Colors.cyan),
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.fromLTRB(20, 15, 20, 15)),
          ),
          onPressed: () async {
            value.value = phoneNumber.text.toString();
            message.value = messageController.text.toString();
            openWhatsapp('91' + value.value, message.value);
            //FlutterOpenWhatsapp.sendSingleMessage("918179015345", "Hello");
          },
          child: const Text('OPEN WHATSAPP'),
        ),
        /*  Obx(() => Text(value.toString())), */
      ]),
    );
  }

  //Method to Open WhatsApp with Given Number
  openWhatsapp(value, msg) async {
    FocusManager.instance.primaryFocus?.unfocus();
    var whatsappUrl = "whatsapp://send?phone=$value&text=$msg";
    print(whatsappUrl);
    await launch(whatsappUrl);
  }
}
