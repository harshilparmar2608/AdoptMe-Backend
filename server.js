const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json()); // Middleware for parsing JSON requests

// Basic route
app.get('/', (req, res) => {
    res.send('Welcome to the AdoptMe backend!');
});

// For additional routes, you can add more here

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});