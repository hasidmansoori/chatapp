import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController c = Get.find();
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.person_add_alt, size: 80, color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    'Register',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Email
                  TextField(
                    controller: c.emailCtl,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.email, color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password
                  TextField(
                    controller: c.passwordCtl,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Country
                  DropdownButtonFormField<String>(
                    value: c.selectedCountryCode.value.isEmpty ? null : c.selectedCountryCode.value,
                    decoration: InputDecoration(
                      labelText: 'Country',
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    dropdownColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    items: c.countries
                        .map((country) => DropdownMenuItem<String>(
                      value: country.code,
                      child: Text(country.name),
                    ))
                        .toList(),
                    onChanged: (val) => c.selectedCountryCode.value = val!,
                  ),
                  const SizedBox(height: 32),

                  // Register Button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: c.register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue.shade800,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Get.toNamed('/login'),
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
