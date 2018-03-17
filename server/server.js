var express = require('express'),
    app = express(),
    port = process.env.PORT || 3000;

var counter = 0;
app.route('/counter').get(function (req, res) {
    res.json({
            'counter': counter
        }
    );
});
app.route('/counter/:value').put(function (req, res) {
    counter = parseInt(req.params.value);
    res.status(200).send();
});

app.listen(port);