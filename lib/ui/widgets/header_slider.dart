import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';

class HeaderSlider extends StatefulWidget {
  final List<String> images;
  final List<String> titles;

  const HeaderSlider({super.key, required this.images, required this.titles});

  @override
  State<HeaderSlider> createState() => _HeaderSliderState();
}

class _HeaderSliderState extends State<HeaderSlider> {
  int _currentIndex = 0;
  Timer? _timer;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        _currentIndex = (_currentIndex + 1) % widget.images.length;
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          // Image Slider
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              // Logo için özel tasarım
              if (widget.images[index] == AppImages.logo) {
                return Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryBlue.withValues(
                                alpha: 0.3,
                              ),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              AppImages.logo,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Lapseki Belediyesi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Diğer görseller için görsel göster
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.primaryBlue),
                child: Stack(
                  children: [
                    // Görsel
                    Image.asset(
                      widget.images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        // Hata durumunda sade arka plan göster
                        return Container(color: Colors.black12);
                      },
                    ),
                    // Overlay kaldırıldı (gradient yok)
                  ],
                ),
              );
            },
          ),

          // Dots Indicator
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.images.asMap().entries.map((entry) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? Colors.white
                        : Colors.white70,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
