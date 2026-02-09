import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetChecker {
  // Private constructor
  InternetChecker._privateConstructor() {
    _initialize();
  }

  // Singleton instance
  static final InternetChecker _instance = InternetChecker._privateConstructor();

  // Factory constructor to return the same instance
  factory InternetChecker() {
    return _instance;
  }

  // Getter for singleton instance
  static InternetChecker get instance => _instance;

  final Connectivity _connectivity = Connectivity();
  final InternetConnectionChecker _connectionChecker = InternetConnectionChecker();

  // Synchronous isConnected parameter
  bool _isConnected = false;
  bool get isConnected => _isConnected;

  // Stream controller for listening to changes
  final StreamController<bool> _connectionChangeController = StreamController<bool>.broadcast();
  Stream<bool> get onConnectionChange => _connectionChangeController.stream;

  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  StreamSubscription<InternetConnectionStatus>? _internetSubscription;

  void _initialize() {
    // Initial check
    _checkConnection();

    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((results) {
      _checkConnection();
    });

    // Listen to internet connection status
    _internetSubscription = _connectionChecker.onStatusChange.listen((status) {
      _updateConnectionStatus(status == InternetConnectionStatus.connected);
    });
  }

  Future<void> _checkConnection() async {
    bool hasConnection = await _connectionChecker.hasConnection;
    _updateConnectionStatus(hasConnection);
  }

  void _updateConnectionStatus(bool connected) {
    if (_isConnected != connected) {
      _isConnected = connected;
      _connectionChangeController.add(_isConnected);
    }
  }

  // Manual check method (returns Future if needed)
  Future<bool> checkConnection() async {
    bool hasConnection = await _connectionChecker.hasConnection;
    _updateConnectionStatus(hasConnection);
    return hasConnection;
  }

  void dispose() {
    _connectivitySubscription?.cancel();
    _internetSubscription?.cancel();
    _connectionChangeController.close();
  }
}