var express = require('express'),
    app = express(),
    port = process.env.PORT || 3000,
    cors = require('cors');

app.use(cors())

var counter = 0;
app.get('/counter', function (req, res) {
    res.send(++counter + "");
});
app.post('/counter/:value', function (req, res) {
    counter = req.params.value;
    res.send(counter + "");
});

app.listen(port, function () {
    console.log('running on ' + port);
});