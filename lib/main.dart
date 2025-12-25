import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import 'app_constants.dart';

void main() {
  runApp(const GitaApp());
}

class GitaApp extends StatelessWidget {
  const GitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConstants.primaryColor,
          brightness: Brightness.light,
        ).copyWith(primary: AppConstants.primaryColor),
        scaffoldBackgroundColor: AppConstants.lightScaffoldBackgroundColor,
        textTheme: GoogleFonts.latoTextTheme(),
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConstants.primaryColor,
          brightness: Brightness.dark,
        ).copyWith(primary: AppConstants.primaryColor),
        scaffoldBackgroundColor: AppConstants.darkScaffoldBackgroundColor,
        textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme),
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(AppConstants.bannerVideoPath)
      ..initialize().then((_) {
        _controller.setVolume(0);
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Video Background
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          // Dark Overlay
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Content
          Center(
            child: LayoutBuilder(builder: (context, constraints) {
              final bool isMobile =
                  constraints.maxWidth < AppConstants.mobileBreakpoint;
              final double titleSize =
                  isMobile ? AppConstants.titleMobile : AppConstants.titleDesktop;
              final double subtitleSize = isMobile
                  ? AppConstants.subtitleMobile
                  : AppConstants.subtitleDesktop;
              final double buttonFontSize = isMobile
                  ? AppConstants.buttonMobile
                  : AppConstants.buttonDesktop;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppConstants.appTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.bangers(
                      fontSize: titleSize,
                      color: AppConstants.primaryColor,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.7),
                          offset: const Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppConstants.homePageSubtitle,
                    style: GoogleFonts.lato(
                      fontSize: subtitleSize,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 50),
                  ComicButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SlokaViewer()),
                      );
                    },
                    text: AppConstants.homePageButtonText,
                    fontSize: buttonFontSize,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class ComicButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final double fontSize;

  const ComicButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.fontSize = AppConstants.buttonDesktop,
  });

  @override
  _ComicButtonState createState() => _ComicButtonState();
}

class _ComicButtonState extends State<ComicButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          color: _isPressed
              ? AppConstants.primaryColor.withOpacity(0.8)
              : AppConstants.primaryColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: const Offset(6, 6),
                    blurRadius: 0,
                  )
                ],
        ),
        transform: _isPressed
            ? Matrix4.translationValues(4, 4, 0)
            : Matrix4.identity(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: GoogleFonts.bangers(
                fontSize: widget.fontSize,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class GlassmorphicAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const GlassmorphicAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final isMobile = !kIsWeb;
    final ThemeData theme = Theme.of(context);

    final TextStyle? defaultTitleStyle =
        theme.appBarTheme.titleTextStyle ?? theme.primaryTextTheme.titleLarge;

    final TextStyle titleStyle = GoogleFonts.bangers(
      fontSize:
          isMobile ? AppConstants.appBarMobile : AppConstants.appBarDesktop,
      letterSpacing: 1,
      color: defaultTitleStyle?.color, // Inherit color from the theme
    );

    // Manually break the title for mobile view if needed
    String displayTitle = title;
    if (isMobile && title.contains(' - ')) {
      displayTitle = title.replaceFirst(' - ', '\n- ');
    }

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AppBar(
          title: RichText(
            text: TextSpan(
              text: displayTitle,
              style: titleStyle,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor:
              Theme.of(context).appBarTheme.backgroundColor?.withOpacity(0.3),
          elevation: 0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    final isMobile = !kIsWeb;
    return Size.fromHeight(
        isMobile ? AppConstants.mobileAppBarHeight : kToolbarHeight);
  }
}

class SlokaViewer extends StatefulWidget {
  const SlokaViewer({super.key});

  @override
  _SlokaViewerState createState() => _SlokaViewerState();
}

class _SlokaViewerState extends State<SlokaViewer> {
  late Future<Map<String, dynamic>> _slokaData;
  late PageController _pageController;
  double _pageOffset = 0;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _slokaData = _loadSlokas();
    _pageController = PageController();
    _pageController.addListener(() {
    setState(() {
        _pageOffset = _pageController.page ?? 0;
        if (_pageController.page?.round() != _currentPage) {
          _currentPage = _pageController.page!.round();
        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> _loadSlokas() async {
    final String jsonString =
        await rootBundle.loadString(AppConstants.slokaDataPath);
    return json.decode(jsonString);
  }

  void _previousPage() {
    if (_pageController.hasClients) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextPage(int totalSlokas) {
    if (_pageController.hasClients && _currentPage < totalSlokas - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _slokaData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        if (!snapshot.hasData || snapshot.data!['slokas'] == null) {
          return const Scaffold(
            body: Center(child: Text('No slokas found.')),
          );
        }

        final chapterData = snapshot.data!;
        final List<dynamic> slokas = chapterData['slokas'];

    return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: GlassmorphicAppBar(title: chapterData['title']),
          body: PageView.builder(
            controller: _pageController,
            itemCount: slokas.length,
            itemBuilder: (context, index) {
              return SlokaPage(
                slokaData: slokas[index],
                index: index,
                pageOffset: _pageOffset,
              );
            },
          ),
          bottomNavigationBar: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: BottomAppBar(
                color: Theme.of(context)
                    .bottomAppBarTheme
                    .color
                    ?.withOpacity(0.3),
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_left),
                      onPressed: _currentPage > 0 ? _previousPage : null,
                      iconSize: 30,
                      color: _currentPage > 0
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                    ),
                    DotsIndicator(
                      dotsCount: slokas.length,
                      position: _currentPage,
                      decorator: DotsDecorator(
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_right),
                      onPressed: _currentPage < slokas.length - 1
                          ? () => _nextPage(slokas.length)
                          : null,
                      iconSize: 30,
                      color: _currentPage < slokas.length - 1
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DotsIndicator extends AnimatedWidget {
   DotsIndicator({
    super.key,
    required this.dotsCount,
    required this.position,
    required this.decorator,
  }) : super(listenable:  PageController());

  final int dotsCount;
  final int position;
  final DotsDecorator decorator;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(dotsCount, _buildDot),
    );
  }

  Widget _buildDot(int index) {
    final color =
        (position == index) ? decorator.activeColor : decorator.color;
    final size =
        (position == index) ? decorator.activeSize : decorator.size;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size.width / 2),
      ),
    );
  }
}

class DotsDecorator {
  final Color color;
  final Color activeColor;
  final Size size;
  final Size activeSize;

  const DotsDecorator({
    this.color = Colors.grey,
    this.activeColor = Colors.blue,
    this.size = const Size(8, 8),
    this.activeSize = const Size(10, 10),
  });
}

class _AnimatedStaggeredList extends StatelessWidget {
  const _AnimatedStaggeredList({
    required this.animationController,
    required this.children,
  });

  final AnimationController animationController;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: children.length,
      itemBuilder: (context, index) {
        final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(
              0.1 * index,
              0.5 + 0.1 * index,
              curve: Curves.easeOut,
            ),
          ),
        );

        final translationAnimation =
            Tween<Offset>(begin: const Offset(0, 30), end: Offset.zero)
                .animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(
              0.1 * index,
              0.5 + 0.1 * index,
              curve: Curves.easeInOut,
            ),
          ),
        );

        return AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: animation,
              child: Transform.translate(
                offset: translationAnimation.value,
                child: child,
              ),
            );
          },
          child: children[index],
        );
      },
    );
  }
}

class SlokaPage extends StatefulWidget {
  final Map<String, dynamic> slokaData;
  final double pageOffset;
  final int index;

  const SlokaPage({
    super.key,
    required this.slokaData,
    required this.pageOffset,
    required this.index,
  });

  @override
  _SlokaPageState createState() => _SlokaPageState();
}

class _SlokaPageState extends State<SlokaPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void didUpdateWidget(covariant SlokaPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the page is scrolled to, reset and play the animation
    if (widget.index == widget.pageOffset.round()) {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Play animation only for the visible page
    if (widget.index == widget.pageOffset.round()) {
      _animationController.forward();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > AppConstants.wideLayoutBreakpoint) {
          return _buildWideLayout(context);
        } else {
          return _buildNarrowLayout(context);
        }
      },
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    double parallaxOffset = (widget.pageOffset - widget.index) * 200;

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ClipRect(
            child: OverflowBox(
              maxWidth: double.infinity,
              child: Transform.translate(
                offset: Offset(parallaxOffset, 0),
                child: Image.asset(
                  widget.slokaData['illustration'],
                  fit: BoxFit.cover,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: _AnimatedStaggeredList(
            animationController: _animationController,
            children: [_buildScrollableContent(context)],
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment(
              (widget.pageOffset - widget.index) * -1,
              0,
            ),
            child: Image.asset(
              widget.slokaData['illustration'],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: _AnimatedStaggeredList(
            animationController: _animationController,
            children: [_buildScrollableContent(context)],
          ),
        ),
      ],
    );
  }

  Widget _buildScrollableContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSanskritText(context),
          const SizedBox(height: 20),
          _buildTranslationCard(
            context,
            'English Translation',
            widget.slokaData['english_translation'],
          ),
          const SizedBox(height: 20),
          _buildTranslationCard(
            context,
            'Telugu Translation',
            widget.slokaData['telugu_translation'],
          ),
          const SizedBox(height: 20),
          _buildSoftwareExplanationCard(context),
        ],
      ),
    );
  }

  Widget _buildSanskritText(BuildContext context) {
    return Center(
      child: Text(
        widget.slokaData['sanskrit'],
        textAlign: TextAlign.center,
        style: GoogleFonts.tiroDevanagariSanskrit(
          fontSize: AppConstants.sanskritTextSize,
          fontWeight: FontWeight.bold,
          height: 1.8,
        ),
      ),
    );
  }

  Widget _buildTranslationCard(
      BuildContext context, String title, String content) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(
                  fontSize: AppConstants.translationTextSize,
                  height: 1.5,
                  color: Theme.of(context).textTheme.bodyLarge?.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSoftwareExplanationCard(BuildContext context) {
    if (widget.slokaData['software_explanation'] == null) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Theme.of(context).brightness == Brightness.dark
          ? AppConstants.darkCardColor
          : AppConstants.lightCardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.softwareIndustryTitle,
              style: TextStyle(
                fontSize: AppConstants.softwareCardTitleSize,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              widget.slokaData['software_explanation'],
              style: TextStyle(
                  fontSize: AppConstants.softwareCardBodySize,
                  height: 1.5,
                  color: Theme.of(context).textTheme.bodyLarge?.color),
            ),
            const SizedBox(height: 15),
            _buildHighlightBox(
              context,
              AppConstants.keyLessonTitle,
              widget.slokaData['key_lesson'],
              Colors.green,
            ),
            const SizedBox(height: 10),
            _buildHighlightBox(
              context,
              AppConstants.modernApplicationTitle,
              widget.slokaData['modern_application'],
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightBox(
      BuildContext context, String title, String content, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: TextStyle(
                height: 1.5,
                color: Theme.of(context).textTheme.bodyLarge?.color),
          ),
        ],
      ),
    );
  }
}
