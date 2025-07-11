import 'package:flutter/material.dart';
import 'package:fotpulse/screens/developer_info_screen.dart';
import 'package:fotpulse/screens/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/firestore_service.dart';
import '../models/news_model.dart';
import 'news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  String selectedCategory = 'Academic';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background for modern news look
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        toolbarHeight: 70,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.menu, color: Colors.white, size: 20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProfileScreen()),
            );
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'FOTPulse',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
            Text(
              'LIVE • Breaking News',
              style: GoogleFonts.inter(
                color: Colors.redAccent,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 20),
            ),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DeveloperInfoScreen()),
                );
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.redAccent, Colors.orangeAccent],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar with modern design
          Container(
            color: const Color(0xFF1E1E1E),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[700]!, width: 0.5),
              ),
              child: TextField(
                style: GoogleFonts.inter(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search breaking news...',
                  hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[500], size: 20),
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.tune, color: Colors.white, size: 16),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),

          // Category Pills with news-style design
          Container(
            color: const Color(0xFF1E1E1E),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                _buildCategoryPill('Academic', Icons.school_outlined),
                const SizedBox(width: 12),
                _buildCategoryPill('Sport', Icons.sports_soccer_outlined),
                const SizedBox(width: 12),
                _buildCategoryPill('Event', Icons.event_outlined),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breaking News Section with modern header
                  _buildModernSectionHeader('🔥 $selectedCategory Headlines', 'Latest updates'),
                  SizedBox(
                    height: 260,
                    child: StreamBuilder<List<NewsModel>>(
                      stream: _firestoreService.getNewsByCategory(selectedCategory),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return _buildLoadingState();
                        }

                        if (snapshot.hasError) {
                          print('Breaking News Error: ${snapshot.error}');
                          return _buildErrorState('Unable to load breaking news');
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return _buildEmptyState('No ${selectedCategory.toLowerCase()} headlines available');
                        }

                        final data = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final news = data[index];
                            return _buildModernBreakingNewsCard(news, index);
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Trending News with modern design
                  _buildModernSectionHeader('📈 Trending Now', 'Most read stories'),
                  StreamBuilder<List<NewsModel>>(
                    stream: _firestoreService.getAllNews(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildLoadingList();
                      }

                      if (snapshot.hasError) {
                        print('Trending News Error: ${snapshot.error}');
                        return _buildErrorState('Unable to load trending news');
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return _buildEmptyState('No trending stories available');
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final news = snapshot.data![index];
                          return _buildModernTrendingCard(news, index);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          border: Border(top: BorderSide(color: Colors.grey[800]!, width: 0.5)),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF1E1E1E),
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.grey[600],
          currentIndex: 2,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.bookmark_border, size: 24), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.flash_on_outlined, size: 24), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 24), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.explore_outlined, size: 24), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 24), label: ''),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryPill(String title, IconData icon) {
    final isSelected = selectedCategory == title;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = title;
          });
          print('Selected category: $title');
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: isSelected 
              ? const LinearGradient(colors: [Colors.redAccent, Colors.orangeAccent])
              : null,
            color: isSelected ? null : const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey[700]!,
              width: 0.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : Colors.grey[400],
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.white : Colors.grey[400],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernSectionHeader(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[700]!, width: 0.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View All',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward_ios, color: Colors.redAccent, size: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernBreakingNewsCard(NewsModel news, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsScreen(news: news)),
        );
      },
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[800]!, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                children: [
                  Container(
                    height: 160,
                    width: double.infinity,
                    child: news.imageUrl.isNotEmpty
                        ? Image.network(
                            news.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return _buildImagePlaceholder();
                            },
                          )
                        : _buildImagePlaceholder(),
                  ),
                  // Live indicator for first item
                  if (index == 0)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'LIVE',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  // Category badge
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        news.category.toUpperCase(),
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(Icons.schedule, color: Colors.grey[500], size: 12),
                        const SizedBox(width: 4),
                        Text(
                          '2 min read',
                          style: GoogleFonts.inter(
                            color: Colors.grey[500],
                            fontSize: 11,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.bookmark_border, color: Colors.grey[500], size: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernTrendingCard(NewsModel news, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsScreen(news: news)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[800]!, width: 0.5),
        ),
        child: Row(
          children: [
            // Rank number
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: index < 3 
                  ? const LinearGradient(colors: [Colors.redAccent, Colors.orangeAccent])
                  : null,
                color: index < 3 ? null : const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 80,
                height: 80,
                child: news.imageUrl.isNotEmpty
                    ? Image.network(
                        news.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => _buildSmallImagePlaceholder(),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return _buildSmallImagePlaceholder();
                        },
                      )
                    : _buildSmallImagePlaceholder(),
              ),
            ),
            const SizedBox(width: 16),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      news.category.toUpperCase(),
                      style: GoogleFonts.inter(
                        color: Colors.redAccent,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    news.title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    news.description,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey[500],
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      height: 160,
      color: const Color(0xFF2A2A2A),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, color: Colors.grey[600], size: 32),
          const SizedBox(height: 8),
          Text(
            'Image unavailable',
            style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallImagePlaceholder() {
    return Container(
      width: 80,
      height: 80,
      color: const Color(0xFF2A2A2A),
      child: Icon(Icons.image_outlined, color: Colors.grey[600], size: 24),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.redAccent),
    );
  }

  Widget _buildLoadingList() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: CircularProgressIndicator(color: Colors.redAccent),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.grey[600], size: 48),
          const SizedBox(height: 8),
          Text(
            message,
            style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.article_outlined, color: Colors.grey[600], size: 48),
          const SizedBox(height: 8),
          Text(
            message,
            style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }
}