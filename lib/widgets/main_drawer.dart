import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.selectScreen});

  final Function(String identifier) selectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1,
      child: Center(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.5)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.fastfood,
                    size: 45,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Cooking Up',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  )
                ],
              ),
            ),
            ListTile(
              onTap: () {
                selectScreen('meals');
              },
              leading: Icon(
                Icons.restaurant,
                size: 26,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              title: Text(
                'Meals',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 25),
              ),
            ),
            ListTile(
              onTap: () {
                selectScreen('settings');
              },
              leading: Icon(
                Icons.settings,
                size: 26,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              title: Text(
                'Settings',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 25),
              ),
            ),
            ListTile(
              onTap: () {
                selectScreen('filters');
              },
              leading: Icon(
                Icons.sort,
                size: 26,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              title: Text(
                'Filters',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}
