import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

// Controller
class CounterController extends GetxController {
  var count = 0.obs;

  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }

  void reset() {
    count.value = 0;
  }
}

// App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Homepage()
    );
  }
}

class Homepage extends StatelessWidget {
  final CounterController controller = Get.put(CounterController());

  // const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: 
                  FloatingActionButton(
                    onPressed: controller.increment,
                    child: Icon(Icons.add)
                  ),
              ),
              SizedBox(width: 20),
              SizedBox(
                child: 
                  FloatingActionButton(
                    onPressed: controller.decrement,
                    child: Icon(Icons.remove),
                  ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: Obx(() => Text("Nilai: ${controller.count.value}")),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.reset,
        child: Icon(Icons.refresh),
      ),
    );
  }
}