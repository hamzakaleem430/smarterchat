import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarterchat/widgets/messagewidget.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white30,
              child: Icon(Icons.person),
            ),
            SizedBox(
              width: 10,
            ),
            Text('Username'),
          ],
        ),
        actions: [
          Icon(Icons.more_vert),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
        child: ScreenUtilInit(
          builder: () {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: .1.sh),
                  child: ListView.builder(
                    reverse: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return MessageWidget();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: .1.sh,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Write your message',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.zero),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero),
                          suffixIcon: IconButton(
                              icon: Icon(Icons.send), onPressed: () {}),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
