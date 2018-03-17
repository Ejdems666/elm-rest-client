var express = require('express'),
    app = express(),
    port = process.env.PORT || 3000;

var counter = "0";
app.get('/counter', function (req, res) {
    res.send(counter);
});
app.put('/counter/:value', function (req, res) {
    counter = req.params.value;
});

app.listen(port, function () {
    console.log('running on ' + port);
});