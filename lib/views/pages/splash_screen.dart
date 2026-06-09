part of pages;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color afGold = Color(0xFFFBC02D); 
    
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/pastor_doug.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  const Color(0xFF5D0000).withOpacity(0.7), 
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 160,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.auto_stories, size: 70, color: afGold),
                ),
                const SizedBox(height: 12), 
                const Text(
                  "Pekabaran Allah Adalah Misi Kami",
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white70, letterSpacing: 1.2),
                ),
                const SizedBox(height: 60), 
                const CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(afGold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}