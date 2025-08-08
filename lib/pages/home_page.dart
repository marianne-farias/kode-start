import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/api_service.dart';
import '../models/character_model.dart';
import '../widgets/character_card.dart';
import '../widgets/app_bar.dart';
import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';
import 'character_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final ScrollController _scrollController = ScrollController();
  final List<Character> _characters = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final int _pageSize = 20;
  bool _hasMore = true;
  String? _errorMessage;
  bool _showBack = false;
  bool _showSearch = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCharacters();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 300 &&
          !_isLoading &&
          _hasMore) {
        _fetchCharacters();
      }
    });
  }

  Future<void> _fetchCharacters() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final newCharacters = await ApiService.fetchCharacters(page: _currentPage);
      setState(() {
        _characters.addAll(newCharacters);
        _currentPage++;
        if (newCharacters.length < _pageSize) _hasMore = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao carregar personagens: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _characters.clear();
      _currentPage = 1;
      _hasMore = true;
      _errorMessage = null;
    });
    await _fetchCharacters();
  }

  void _openDetails(Character character) {
    setState(() => _showBack = true);
    _navigatorKey.currentState?.push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            CharacterDetailPage(character: character),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    ).then((_) => setState(() => _showBack = false));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCharacters = _searchQuery.isEmpty
        ? _characters
        : _characters.where((c) =>
            c.name.toLowerCase().contains(_searchQuery.toLowerCase())
          ).toList();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.appBarColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: CustomAppBar(
          leading: _showBack
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 31.46),
                  onPressed: () {
                    _navigatorKey.currentState?.pop();
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                )
              : IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white, size: 31.46),
                  onPressed: () {
                    // seu menu aqui
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
          showSearchButton: !_showBack,
          onSearch: () {
            setState(() {
              if (_showSearch) {
                _searchQuery = '';
                _searchController.clear();
              }
              _showSearch = !_showSearch;
            });
          },
        ),
        body: Stack(
          children: [
            Navigator(
              key: _navigatorKey,
              onPopPage: (route, result) {
                setState(() => _showBack = false);
                return route.didPop(result);
              },
              pages: [
                MaterialPage(
                  child: RefreshIndicator(
                    onRefresh: _refresh,
                    child: _errorMessage != null && _characters.isEmpty
                        ? Center(child: Text(_errorMessage!, style: AppFonts.cardInfo.copyWith(color: Colors.red)))
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            controller: _scrollController,
                            itemCount: filteredCharacters.length + (_hasMore ? 2 : 1),
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return const SizedBox(height: 8);
                              }
                              final characterIndex = index - 1;
                              if (characterIndex < filteredCharacters.length) {
                                return CharacterCard(
                                  character: filteredCharacters[characterIndex],
                                  onTap: () => _openDetails(filteredCharacters[characterIndex]),
                                );
                              } else {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Center(child: CircularProgressIndicator()),
                                );
                              }
                            },
                          ),
                  ),
                ),
              ],
            ),
            if (_showSearch && !_showBack)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      style: AppFonts.cardInfo.copyWith(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                          hintText: 'Search character...',
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          filled: true,
                          fillColor: AppColors.appBarColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)), // bordas arredondadas
                            borderSide: BorderSide.none, // remove a linha branca
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
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
