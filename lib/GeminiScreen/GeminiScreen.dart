import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
import 'package:your_friend/Theme/theme_model.dart';

class Geminiscreen extends StatefulWidget {
  const Geminiscreen({super.key});

  @override
  State<Geminiscreen> createState() => _GeminiscreenState();
}

class _GeminiscreenState extends State<Geminiscreen> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  List<ChatUser> typing = [];

// Two users of this App Ai 0 & User 1
// User
  ChatUser currentUser = ChatUser(
    id: "0",
    firstName: "Sharjeel",
    profileImage: "assets/Images/robo.png",
  );

// Ai
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: 'Your Friend',
    profileImage: "assets/Images/robo.png",
  );

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        // Define colors for light and dark modes
        Color backgroundColor =
            themeNotifier.isDark ? Colors.black : Colors.white;
        Color userBubbleColor =
            themeNotifier.isDark ? Colors.blueGrey : Colors.lightBlue;
        Color aiBubbleColor =
            themeNotifier.isDark ? Colors.grey[800]! : Colors.grey[100]!;
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: AppBar(
                backgroundColor: Colors.grey,
                elevation: 1,
                title: Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'Your Friend',
                        textStyle: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                        colors: [
                          Colors.purple,
                          Colors.blue,
                          Colors.yellow,
                          Colors.red,
                        ],
                        speed: const Duration(seconds: 3),
                      ),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
                leading: const Padding(
                  padding: EdgeInsets.all(7.0),
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white70,
                    backgroundImage: AssetImage('assets/Images/robo.png'),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(themeNotifier.isDark
                        ? Icons.wb_sunny
                        : Icons.nightlight_round), // Icon for light mode
                    onPressed: () {
                      themeNotifier
                              .isDark // if isdark is true then wb_sunny icon appears and vice-versa
                          ? themeNotifier.isDark = false
                          : themeNotifier.isDark = true;
                    },
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: backgroundColor,
          body: _buildUI(userBubbleColor, aiBubbleColor),
        );
      },
    );
  }

  Widget _buildUI(Color userBubbleColor, Color aiBubbleColor) {
    return DashChat(
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
      messageOptions: MessageOptions(
        currentUserContainerColor: userBubbleColor,
        containerColor: aiBubbleColor,
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                "",
                (previous, current) => "$previous ${current.text}",
              ) ??
              "";
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                "",
                (previous, current) => "$previous ${current.text}",
              ) ??
              "";
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
