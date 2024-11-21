const express = require('express');
const cors = require('cors');
const mongoose = require('./database'); // Import the database connection
const User = require('./User'); // Import the User model
const Recipe = require('./Recipe'); // Import the Recipe model

const app = express();

app.use(cors());
app.use(express.json());

// POST endpoint for registration
app.post('/register', async (req, res) => {
    const { name, email, password } = req.body;
    try {
        // Check if the user already exists
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ message: 'User already exists' });
        }

        // Create a new user
        const newUser = new User({ name, email, password });
        await newUser.save();

        res.json({ message: 'User registered successfully', user: newUser });
    } catch (error) {
        res.status(500).json({ message: 'Error registering user', error: error.message });
    }
});

// POST endpoint for login
app.post('/login', async (req, res) => {
    const { email, password } = req.body;
    try {
        // Find the user with matching email
        const user = await User.findOne({ email });
        if (!user || user.password !== password) {
            return res.status(400).json({ message: 'Invalid email or password' });
        }

        res.status(200).json({ message: 'Login successful', user });
    } catch (error) {
        res.status(500).json({ message: 'Error logging in', error: error.message });
    }
});

// GET endpoint to retrieve the list of users
app.get('/userlist', async (req, res) => {
    try {
        const users = await User.find(); // Retrieve all users
        res.json(users);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching users', error: error.message });
    }
});

// POST endpoint to add a recipe
app.post('/recipes', async (req, res) => {
    const { id, name, description, image, ingredients } = req.body;
    try {
        // Create a new recipe
        const newRecipe = new Recipe({ id, name, description, image, ingredients });
        await newRecipe.save();

        res.json({ message: 'Recipe added successfully', recipe: newRecipe });
    } catch (error) {
        res.status(500).json({ message: 'Error adding recipe', error: error.message });
    }
});

// GET endpoint to retrieve recipes
app.get('/recipes', async (req, res) => {
    try {
        const recipes = await Recipe.find(); // Retrieve all recipes
        if (recipes.length === 0) {
            return res.status(404).json({ message: 'No recipes found' });
        }

        res.json(recipes);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching recipes', error: error.message });
    }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
