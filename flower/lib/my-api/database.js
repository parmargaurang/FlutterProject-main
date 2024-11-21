const mongoose = require('mongoose');

// Connection string for MongoDB (replace 'mydatabase' with your preferred name)
const DB_URL = 'mongodb://localhost:27017/recipepro';

// Connect to MongoDB
mongoose.connect(DB_URL, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('MongoDB connected successfully'))
    .catch(err => console.error('MongoDB connection error:', err));

module.exports = mongoose;
