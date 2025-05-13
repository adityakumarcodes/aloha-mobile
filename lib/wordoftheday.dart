import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WordOfTheDay extends StatefulWidget {
  final String word;
  final String meaning;
  final VoidCallback onTap;

  const WordOfTheDay({
    super.key,
    required this.word,
    required this.meaning,
    required this.onTap,
  });

  @override
  State<WordOfTheDay> createState() => _WordOfTheDayState();
}

class _WordOfTheDayState extends State<WordOfTheDay> {
  int currentWordIndex = 1;
  List data = [];

  Future _fetchWords() async {
    final response = await Supabase.instance.client.from('words').select().order('id');
    setState(() => data = response);
  }

  @override
  void initState() {
    super.initState();
    _fetchWords();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => setState(
            () => currentWordIndex = (currentWordIndex + 1) % data.length,
          ),
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          image: const DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1536147116438-62679a5e01f2?auto=format&fit=crop&q=60&w=600&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGdyZWVufGVufDB8fDB8fHww',
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          data[currentWordIndex]['word'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.white
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        data[currentWordIndex]['meaning'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18,color: Colors.white),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
        ),
      ),
    );
  }
}
