import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

// 1. Binding - Dependency Injection
class CounterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CounterController());
  }
}

// 2. GetxController - With Status Management
class CounterController extends GetxController {
  var count = 0.obs;
  var status = 'idle'.obs;

  void increment() {
    count++;
    status.value = 'incremented';
    _showFeedback('Incremented to ${count.value}');
  }

  void decrement() {
    count--;
    status.value = 'decremented';
    _showFeedback('Decremented to ${count.value}');
  }

  void reset() {
    count.value = 0;
    status.value = 'reset';
    _showFeedback('Counter Reset');
  }

  // 3. Get.snackbar() - User Feedback Utility
  void _showFeedback(String message) {
    Get.snackbar(
      'Counter Update',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blueAccent,
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
    );
  }
}

// App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const Homepage(),
      initialBinding: CounterBinding(), // 4. Binding - Inject dependencies
    );
  }
}

// 5. GetView - Extends GetView instead of StatelessWidget (cleaner approach)
class Homepage extends GetView<CounterController> {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // 6. Get.isRegistered() - Check if controller is registered
    if (!Get.isRegistered<CounterController>()) {
      Get.put(CounterController());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter App"),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 7. GetBuilder - Alternative reactive builder (state management)
          GetBuilder<CounterController>(
            builder: (counterCtrl) => Text(
              'Status: ${counterCtrl.status.value}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: controller.increment,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 20),
              FloatingActionButton(
                onPressed: controller.decrement,
                tooltip: 'Decrement',
                child: const Icon(Icons.remove),
              ),
            ],
          ),
          const SizedBox(height: 30),
          // Obx - Reactive value display (already in use)
          Center(
            child: Obx(() => Text(
              "Count: ${controller.count.value}",
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            )),
          ),
          const SizedBox(height: 30),
          // 8. Get.find() - Get controller instance without Put
          ElevatedButton(
            onPressed: () {
              final counterCtrl = Get.find<CounterController>();
              Get.snackbar(
                'Current Count',
                'Value: ${counterCtrl.count.value}',
                duration: const Duration(seconds: 2),
              );
            },
            child: const Text('Show Count via Get.find()'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.reset,
        tooltip: 'Reset',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}