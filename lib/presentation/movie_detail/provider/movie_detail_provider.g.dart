// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$movieDetailNotifierHash() =>
    r'fc3931e9fa5fba0a84fff632303a768380990e34';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MovieDetailNotifier
    extends BuildlessAutoDisposeNotifier<MovieDetailState> {
  late final int id;

  MovieDetailState build(
    int id,
  );
}

/// See also [MovieDetailNotifier].
@ProviderFor(MovieDetailNotifier)
const movieDetailNotifierProvider = MovieDetailNotifierFamily();

/// See also [MovieDetailNotifier].
class MovieDetailNotifierFamily extends Family<MovieDetailState> {
  /// See also [MovieDetailNotifier].
  const MovieDetailNotifierFamily();

  /// See also [MovieDetailNotifier].
  MovieDetailNotifierProvider call(
    int id,
  ) {
    return MovieDetailNotifierProvider(
      id,
    );
  }

  @override
  MovieDetailNotifierProvider getProviderOverride(
    covariant MovieDetailNotifierProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'movieDetailNotifierProvider';
}

/// See also [MovieDetailNotifier].
class MovieDetailNotifierProvider extends AutoDisposeNotifierProviderImpl<
    MovieDetailNotifier, MovieDetailState> {
  /// See also [MovieDetailNotifier].
  MovieDetailNotifierProvider(
    int id,
  ) : this._internal(
          () => MovieDetailNotifier()..id = id,
          from: movieDetailNotifierProvider,
          name: r'movieDetailNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$movieDetailNotifierHash,
          dependencies: MovieDetailNotifierFamily._dependencies,
          allTransitiveDependencies:
              MovieDetailNotifierFamily._allTransitiveDependencies,
          id: id,
        );

  MovieDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  MovieDetailState runNotifierBuild(
    covariant MovieDetailNotifier notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(MovieDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: MovieDetailNotifierProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<MovieDetailNotifier, MovieDetailState>
      createElement() {
    return _MovieDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MovieDetailNotifierProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MovieDetailNotifierRef
    on AutoDisposeNotifierProviderRef<MovieDetailState> {
  /// The parameter `id` of this provider.
  int get id;
}

class _MovieDetailNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<MovieDetailNotifier,
        MovieDetailState> with MovieDetailNotifierRef {
  _MovieDetailNotifierProviderElement(super.provider);

  @override
  int get id => (origin as MovieDetailNotifierProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
