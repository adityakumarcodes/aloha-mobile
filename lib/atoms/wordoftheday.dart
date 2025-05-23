import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WordOfTheDay extends StatefulWidget {
  const WordOfTheDay({super.key});

  @override
  State<WordOfTheDay> createState() => _WordOfTheDayState();
}

class _WordOfTheDayState extends State<WordOfTheDay> {
  int currentWordIndex = 0;
  List data = [];

  Future _fetchWords() async {
    final response = await Supabase.instance.client
        .from('words')
        .select()
        .order('id', ascending: true);
    setState(() => data = response);
  }

  @override
  void initState() {
    super.initState();
    _fetchWords();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: GestureDetector(
        onTap:
            () => setState(
              () => currentWordIndex = (currentWordIndex + 1) % data.length,
            ),
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(6),
          height: 280,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: const DecorationImage(
              image: CachedNetworkImageProvider(
                'https://images.unsplash.com/photo-1536147116438-62679a5e01f2?auto=format&fit=crop&q=50&w=600',
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Color.fromRGBO(0, 0, 0, 0.5),
                BlendMode.darken,
              ),
            ),
          ),
          child: Center(
            child:
                data.isEmpty
                    ? CircularProgressIndicator.adaptive()
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          data[currentWordIndex]['word'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dancingScript(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          data[currentWordIndex]['meaning'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
