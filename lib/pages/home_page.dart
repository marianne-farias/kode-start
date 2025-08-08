import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/api_service.dart';
import '../models/character_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'menu_page.dart';
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
  // Atualiza a lista de personagens (pull-to-refresh)
  Future<void> _refresh() async {
    setState(() {
      _currentPage = 1;
      _characters.clear();
      _hasMore = true;
      _errorMessage = null;
    });
    await _fetchCharacters();
  }

  // Busca personagens da API
  Future<void> _fetchCharacters() async {
    if (_isLoading || !_hasMore) return;
    setState(() => _isLoading = true);
    try {
      final newCharacters = await ApiService.fetchCharacters(page: _currentPage);
      setState(() {
        if (_currentPage == 1) {
          _characters.clear();
        }
        _characters.addAll(newCharacters);
        _hasMore = newCharacters.length == _pageSize;
        _errorMessage = null;
        _currentPage++;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _hasMore = false;
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Abre detalhes do personagem
  void _openDetails(Character character) {
    setState(() => _showBack = true);
    _navigatorKey.currentState?.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => CharacterDetailPage(character: character),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ).then((_) {
      setState(() => _showBack = false);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
  }
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final ScrollController _scrollController = ScrollController();
  final List<Character> _characters = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final int _pageSize = 20;
  bool _hasMore = true;
  String? _errorMessage;
  bool _showBack = false;
  bool _showMenu = false;
  bool _showSearch = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

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
              : _showMenu
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 31.46),
                      onPressed: () {
                        setState(() => _showMenu = false);
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    )
                  : IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white, size: 31.46),
                      onPressed: () {
                        setState(() => _showMenu = true);
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
          showSearchButton: !_showBack && !_showMenu,
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
            // Conteúdo da home sempre fixo
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
                      decoration: InputDecoration(
                        hintText: 'search_character'.tr(),
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        filled: true,
                        fillColor: AppColors.appBarColor,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder(
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
            // Menu animado por cima
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) {
                final isMenu = child.key == const ValueKey('menu');
                final offsetTween = isMenu
                    ? Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
                    : Tween<Offset>(begin: Offset.zero, end: const Offset(1, 0));
                return SlideTransition(
                  position: animation.drive(offsetTween),
                  child: child,
                );
              },
              child: _showMenu
                  ? const MenuPage(key: ValueKey('menu'))
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}