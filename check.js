const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello, this is your Node.js application running on port 3000!');
});
app.get('/check',(req, res) => {
  res.send("inside check"); 
})
app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});