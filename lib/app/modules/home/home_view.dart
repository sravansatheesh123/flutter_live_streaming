import 'package:flutter/material.dart';
import 'package:flutter_live_streaming/app/widgets/app_bottom_nav.dart';
import 'package:flutter_live_streaming/app/widgets/home_banner_slider.dart';
import 'package:flutter_live_streaming/app/widgets/recommended_live_widget.dart';
import 'package:flutter_live_streaming/app/widgets/trending_live_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F1117),

      // bottomNavigationBar: const AppBottomNav(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Good Evening 👋",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 5),

              const Text(
                "Live Streaming",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              const HomeBannerSlider(),

              const SizedBox(height: 30),

              const Text(
                " Trending",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              TrendingLiveWidget(),

              const SizedBox(height: 30),

              const Text(
                " Recommended",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              RecommendedLiveWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
