const express = require('express');
const bodyParser = require('body-parser');
const helmet = require('helmet');
const morgan = require('morgan');
const cors = require('cors');

require('dotenv').config();

const { normalizePort } = require('./utils/validate-utils');

const contratoRoute = require('./routes/contract-routes');

const port = normalizePort(process.env.PORT) || 3000;

const app = express();

app.use(helmet());
app.use(cors());
app.use(morgan('combined'));
app.use(bodyParser.json());

app.use('/api/v1/contratos?', contratoRoute);

app.use((err, req, res, next) => {//next to handler error
    console.error(err);
    return res
        .status(500)
        .json({
            status: 500,
            statusText: "Internal Server Error",
            error: err.message
        })
        .end();
});

app.use((req, res) => {
    return res
        .status(404)
        .json({
            status: 404,
            statusText: "Not Found"
        })
        .end();
});

app.listen(port, () => console.log(`Example app listening at ${port}`));