import 'package:desafiogigaservices/controllers/home_controller.dart';
import 'package:desafiogigaservices/models/user_model.dart';
import 'package:desafiogigaservices/views/user_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = HomeController();
  late final ScrollController scrollController;
  bool isLoadingMore = false, male = true, female = true;

  void infiniteScrolling() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoadingMore) {
      loadMoreUsers();
    }
  }

  void loadMoreUsers() async {
    isLoadingMore = true;

    await homeController.fetchUsers(
        filter: (female == male)
            ? "all"
            : (female)
                ? "female"
                : "male");

    isLoadingMore = false;
  }

  Future<void> refresh() async {
    await homeController.fetchUsers(
        isRefresh: true,
        filter: (female == male)
            ? "all"
            : (female)
                ? "female"
                : "male");
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(infiniteScrolling);
    homeController.fetchUsers();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Desafio GigaServices"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: RefreshIndicator(
              onRefresh: () async => await refresh(),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: homeController.error,
                      builder: (context, value, child) {
                        return (homeController.error.value.isEmpty)
                            ? const SizedBox.shrink()
                            : GestureDetector(
                                onTap: () async {
                                  await refresh();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.orange,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      homeController.error.value,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: homeController.users,
                      builder: (context, value, child) {
                        return (homeController.users.value.isEmpty)
                            ? const CircularProgressIndicator()
                            : const SizedBox.shrink();
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: homeController.users,
                      builder: (context, value, child) {
                        return (homeController.users.value.isEmpty)
                            ? const SizedBox.shrink()
                            : buildFiltersWidget();
                      },
                    ),
                    AnimatedBuilder(
                      animation: Listenable.merge([
                        homeController.users,
                      ]),
                      builder: (_, __) => Stack(
                        children: [
                          buildListView(),
                          buildLoadingWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // WIDGETS
  Widget buildTile(User user) {
    return ListTile(
      title: Text(
        "${user.name!.first} ${user.name!.last}",
      ),
      subtitle: Text(
        "${user.name!.title}",
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.picture!.medium!),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => UserPage(user: user)));
      },
    );
  }

  Widget buildListView() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: homeController.users.value.length,
      itemBuilder: (_, index) => buildTile(homeController.users.value[index]),
    );
  }

  Widget buildLoadingWidget() {
    return ValueListenableBuilder(
      valueListenable: homeController.isLoading,
      builder: (context, value, child) {
        return (value)
            ? Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 20,
                bottom: 24,
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircleAvatar(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }

  Widget buildFiltersWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FilterChip(
            label: const Text("Masculino"),
            selected: male,
            onSelected: (value) async {
              if (!mounted) return;
              setState(() {
                male = female ? value : male;
              });

              await refresh();
            },
          ),
          const SizedBox(width: 10),
          FilterChip(
            label: const Text("Feminino"),
            selected: female,
            onSelected: (value) async {
              if (!mounted) return;
              setState(() {
                female = male ? value : female;
              });

              await refresh();
            },
          ),
        ],
      ),
    );
  }
}
