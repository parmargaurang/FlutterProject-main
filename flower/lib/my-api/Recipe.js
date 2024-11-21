const mongoose = require('mongoose');

// Define the recipe schema
const recipeSchema = new mongoose.Schema({
    id: { type: String, required: true },
    name: { type: String, required: true },
    description: { type: String, required: true },
    image: { type: String },
    ingredients: { type: Array, required: true }
});

// Create a model from the schema
const Recipe = mongoose.model('Recipe', recipeSchema);

module.exports = Recipe;
