import 'package:alternance_flutter/main.dart';
import 'package:alternance_flutter/utils/OnboardingUtils.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPagePresenter(pages: [
        OnboardingPageModel(
          title: 'Search for Jobs, Internships, and Work/Study Programs',
          description:
              'Discover a world of career opportunities right at your fingertips.',
          imagePath: 'images/student.png',
          bgColor: const Color(0xff43a687),
        ),
        OnboardingPageModel(
          title: 'Searching for Talent and Motivated People',
          description:
              'Find and engage with driven individuals ready to contribute and excel.',
          imagePath: 'images/hr_male.png',
          bgColor: const Color(0xff0d152c),
        ),
        OnboardingPageModel(
            title: 'Enroll in Your First Step in Your Professional Career',
            description: 'AlternanceTn is Your Best Way to Start',
            imagePath: 'images/alternance_logo.png',
            bgColor: const Color(0xfff5f5f5),
            textColor: const Color(0xff0d152c)),
      ]),
    );
  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<OnboardingPageModel> pages;
  final VoidCallback? onSkip;
  final VoidCallback? onFinish;

  const OnboardingPagePresenter(
      {super.key, required this.pages, this.onSkip, this.onFinish});

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  // Store the currently visible page
  int _currentPage = 0;
  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  void _onNextPressed() async {
    // _currentPage == widget.pages.length - 1;
    _pageController.animateToPage(_currentPage + 1,
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 250));

    if (_currentPage == widget.pages.length - 1) {
      // This is the last page
      await OnboardingUtils.setOnboardingDone(true);
      // Navigate to the next screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MyHomePage(
                title: "hello",
              )));
    } else {
      // Move to the next page
      setState(() {
        _currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: widget.pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // Pageview to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    // Change current page when pageview changes
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Image.asset(
                              item.imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: item.textColor,
                                        )),
                              ),
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(item.description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: item.textColor,
                                        )),
                              )
                            ]))
                      ],
                    );
                  },
                ),
              ),

              // Current page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages
                    .map((item) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: _currentPage == widget.pages.indexOf(item)
                              ? 30
                              : 8,
                          height: 8,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              color: _currentPage == widget.pages.length - 1
                                  ? const Color(0xff0d152c)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                        ))
                    .toList(),
              ),

              // Bottom buttons
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            visualDensity: VisualDensity.comfortable,
                            foregroundColor:
                                _currentPage == widget.pages.length - 1
                                    ? const Color(0xff0d152c)
                                    : Colors.white,
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          widget.onSkip?.call();
                          OnboardingUtils.setOnboardingDone(true);
                          _pageController.animateToPage(widget.pages.length - 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250));
                        },
                        child: const Text("Skip")),
                    TextButton(
                      style: TextButton.styleFrom(
                          visualDensity: VisualDensity.comfortable,
                          foregroundColor:
                              _currentPage == widget.pages.length - 1
                                  ? const Color(0xff0d152c)
                                  : Colors.white,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        _onNextPressed();
                      },
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _onNextPressed();
                            },
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                              _currentPage == widget.pages.length - 1
                                  ? const Color(0xff0d152c)
                                  : Colors.white,
                            )),
                            child: Text(
                              _currentPage == widget.pages.length - 1
                                  ? "Finish"
                                  : "Next",
                              style: TextStyle(
                                  color: _currentPage == widget.pages.length - 1
                                      ? Colors.white
                                      : const Color(0xff0d152c)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _currentPage == widget.pages.length - 1
                                ? Icons.done
                                : Icons.arrow_forward,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final String imagePath;
  final Color bgColor;
  final Color textColor;

  OnboardingPageModel(
      {required this.title,
      required this.description,
      required this.imagePath,
      this.bgColor = Colors.blue,
      this.textColor = Colors.white});
}
