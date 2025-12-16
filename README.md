# singing_portfolio

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

From your Flutter project root:

flutter build web --release --base-href /singingPortfolio/


Example:

flutter build web --release --base-href /singingPortfolio/


Important: <repo-name> must match your GitHub repository name exactly.

Step 2: Create and Switch to gh-pages Branch
git checkout --orphan gh-pages
git rm -rf .

Step 3: Copy Build Output to Root
cp -r build/web/* .
