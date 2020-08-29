# Await Route

Convenience helper for awaiting route animation to finish.

This allows animating in keyboards, when a page with a form is opened, or deferring expensive animations and other work.

## Example

```dart
@override
void initState() {
  super.initState();

  // Focuses first input field and opens the keyboard, after the route has
  // finished animation.
  //
  // `postFrame` set to true, so this would be safe to call from `initState`,
  // since [AwaitRoute] has to access [ModalRoute] inherited widget.
  AwaitRoute.of(context, postFrame: true).then(
    (_) => mounted ? _handlePageChange(_storage.lastPage ?? 0) : null,
  );
}
```

See more usage in the [Flutter Firestore](https://github.com/volskaya/flutter_firestore) example app.
