var express = require('express');
var app = express();

app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

/* GET home page. */
app.get('/express', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

app.get('/express/secret', (req, res) => {
  res.json({ secret: process.env.MY_SECRET })
})

app.get('/express/add', (req, res) => {
  var operationResult = parseInt(req.query.num1) + parseInt(req.query.num2);
  res.json({ result: operationResult});
})

app.get('/express/subtract', (req, res) => {
  var operationResult = parseInt(req.query.num1) - parseInt(req.query.num2);
  res.json({ result: operationResult});
})

app.get('/express/healthz', (req, res) => {
  res.end()
})

app.listen(3000, () => {
  console.log(`Example app listening at http://localhost:${3000}`)
})
