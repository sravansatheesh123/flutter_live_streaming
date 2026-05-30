import 'package:flutter/material.dart';

class RecommendedLiveWidget extends StatelessWidget {
  RecommendedLiveWidget({super.key});

  final List<String> streamImages = [
    "https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800",
    "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800",
    "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800",
    "https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=800",
    "https://images.unsplash.com/photo-1516321497487-e288fb19713f?w=800",
  ];

  final List<String> titles = [
    "Flutter Live Coding",
    "Gaming Stream",
    "Podcast Live",
    "Tech Conference",
    "Music Live Show",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: streamImages.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: const Color(0xff1A1D29),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(20),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      streamImages[index],
                      width: 130,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          width: 130,
                          height: 90,
                          color: Colors.black26,
                          child: const Icon(
                            Icons.live_tv,
                            color: Colors.red,
                            size: 40,
                          ),
                        );
                      },
                    ),

                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "LIVE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titles[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Host ${index + 1}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${(index + 1) * 2}K Watching",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.play_circle_fill,
                  color: Colors.red,
                  size: 35,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
