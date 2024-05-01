import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './navBar.dart';
import 'package:open_file/open_file.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isLoading = false;
  final TextEditingController _message = TextEditingController();
  final List<Map<String, String>> _messages = [
    {"entity": "assistant", "message": "How may I help you today?"}
  ];

  Future<void> sendMessage(String messg) async {
    String url = "http://34.125.55.128:3000/chat";
    if (messg.isNotEmpty) {
      var requestBody = {
        "query": "Generate me a document, based on this information with proper Title. Give blank spaces to fill necessary information and use proper indentation. $messg",
        "filename": "sample"
      };
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type' : 'application/json'},
        body : jsonEncode(requestBody)
      );
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        setState(() {
          print(data);
          _messages.add({"entity" : 'assistant', "message" : data['response'].toString()});
          print("Message working!");
        });
      }
    } else {
      print("Message is empty.");
    }
  }
  
  Future<void> downloadFile() async {
    String url = "http://34.125.55.128:3000/downloadFile";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      print("Successful response");
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/sample.pdf';

      await File(filePath).writeAsBytes(response.bodyBytes);
      await OpenFile.open(filePath);
    } else {
      print("Server Error");
    }
    return;
  }


  void addMessages(String entity, String message) {
    setState(() {
      _messages.add({"entity": entity, "message": message});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      backgroundColor:const Color.fromARGB(255, 100, 40, 225),
      body: SingleChildScrollView(
        reverse: true,
        child: SizedBox(
          // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Builder(
                    builder: (context) {
                      return IconButton(
                          onPressed: () => Scaffold.of(context).openDrawer(),
                          icon: const Icon(
                            Icons.more_horiz,
                            size: 38,
                            color: Color(0xFFE9EAFF),
                          ));
                    },
                  ),
                  const SizedBox(width: 30,),
                  Image.asset("assets/lawy-removebg-preview.png", width: 250, height: 155, fit: BoxFit.fill,)
                ],
              ),
              // const SizedBox(height: 80,),
              Expanded(
                // Chat Area container
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                      color: Color(0xFFE9EAFF)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Chatroom
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: MediaQuery.sizeOf(context).height * 0.7,
                        child: ListView.builder(
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            return _messages[index]['entity'] == 'assistant'
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 0),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(255, 100, 40, 225),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 10),
                                          ],
                                          border: Border.all(
                                              width: 1.6,
                                              color: Colors.black87),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(35))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: TextButton(
                                          onPressed: () {
                                            // onPressed function
                                            GestureDetector();
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              const Color.fromARGB(255, 100, 40, 225),
                                            ),
                                          ),
                                          child: GestureDetector(
                                            child:
                                            Text(
                                              _messages[index]['message']!,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            onTap: () {
                                              // Open the PDF file here
                                              downloadFile();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(255, 100, 40, 225),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.white30,
                                                blurRadius: 10),
                                          ],
                                          border: Border.all(
                                              width: 1.6,
                                              color: Colors.black87),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(35))),
                                      child: GestureDetector(
                                        child: Text(
                                          _messages[index]['message']!,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height*0.0003,
                      ),
                      // Message Input
                      SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 300,
                                height: 65,
                                child: TextField(
                                  textAlign: TextAlign.left,
                                  controller: _message,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    filled: true,
                                    fillColor: const Color.fromRGBO(255, 255, 255, 1),
                                    hintText: "Ask Lawy",
                                    hintStyle: const TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                  ),
                                  maxLines: null,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: () {
                                    sendMessage(_message.text);
                                    addMessages("user", _message.text);
                                    _message.clear();
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: Color.fromARGB(255, 100, 40, 225),
                                    size: 40,
                                  )),
                            ],
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
