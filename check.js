const express = require('express');
const app = express();
app.use = (express.json());

app.get("/", (req, res) => {
    console.log("hello world");
});

app.listen(3000);