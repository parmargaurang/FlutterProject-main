import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Recipe {
  final int id;
  final String name;
  final List<String> ingredients;
  final String image;
  final String description;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.image,
    required this.description,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] is String ? int.parse(json['id']) : json['id'], // Handle string to int conversion
      name: json['name'],
      ingredients: List<String>.from(json['ingredients']),
      image: json['image'],
      description: json['description'],
    );
  }
}

class RecipeListScreen extends StatelessWidget {
  Future<List<Recipe>> fetchRecipes() async {
    final response = await http.get(Uri.parse('http://192.168.63.155:3000/recipes'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((recipeJson) => Recipe.fromJson(recipeJson)).toList().cast<Recipe>();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flowers'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Recipe>>(
        future: fetchRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final recipes = snapshot.data!;
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 4, // Adds shadow effect
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                        child: Image.network(
                          recipe.image,
                          width: double.infinity,
                          height: 200, // Fixed height for uniformity
                          fit: BoxFit.cover, // Crops the image if needed
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recipe.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8), // Adds spacing after name
                            Text(
                              recipe.description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                              maxLines: 2, // Limits the description lines
                              overflow: TextOverflow.ellipsis, // Adds ellipsis for overflow
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
