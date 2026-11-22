import 'package:flutter/cupertino.dart';

class OnboardingItem {
  final IconData icon;
  final String title;
  final String description;

  const OnboardingItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class CupertinoOnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const CupertinoOnboardingScreen({super.key, required this.onComplete});

  @override
  State<CupertinoOnboardingScreen> createState() =>
      _CupertinoOnboardingScreenState();
}

class _CupertinoOnboardingScreenState extends State<CupertinoOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingItem> _pages = const [
    OnboardingItem(
      icon: CupertinoIcons.sparkles,
      title: 'Welcome to The Catholic Faith',
      description: 'Strengthen your faith and explore the beauty of Catholicism.',
    ),
    OnboardingItem(
      icon: CupertinoIcons.shield_lefthalf_fill,
      title: 'Learn Doctrines and Prayers',
      description: 'Read and understand the core beliefs and prayers of the Catholic Church.',
    ),
    OnboardingItem(
      icon: CupertinoIcons.rocket_fill,
      title: 'Level up Your Faith',
      description: 'Learn Theology, History, and the Authority of the Church',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentIndex == _pages.length - 1;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground,
      child: SafeArea(
        child: Column(
          children: [
            // Top Skip Button
            Align(
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                onPressed: widget.onComplete,
                child: Text(
                  isLastPage ? '' : 'Skip',
                  style: const TextStyle(color: CupertinoColors.secondaryLabel),
                ),
              ),
            ),

            // Swipeable Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) {
                  final item = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          size: 110,
                          color: CupertinoColors.activeBlue,
                        ),
                        const SizedBox(height: 40),
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: CupertinoTheme.of(context)
                              .textTheme
                              .navLargeTitleTextStyle,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            color: CupertinoColors.secondaryLabel.resolveFrom(context),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Animated Page Indicator Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentIndex == index ? 22 : 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? CupertinoColors.activeBlue
                        : CupertinoColors.systemGrey4.resolveFrom(context),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Primary Action Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  borderRadius: BorderRadius.circular(14),
                  onPressed: _nextPage,
                  child: Text(
                    isLastPage ? 'Get Started' : 'Continue',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}