const express = require('express');
const helmet = require('helmet');
const morgan = require('morgan');
const cors = require('cors');
const dotenv = require('dotenv');

dotenv.config();

const { normalizePort } = require('./utils/validate-utils');

const contratoRoute = require('./routes/contracts-route');

const port = normalizePort(process.env.PORT) || 3000;

const app = express();

app.use(helmet());
app.use(cors());
app.use(morgan('combined'));

app.use('/contratos', contratoRoute);

app.use('/', (req, res) => res.json({ header: req.header, body: req.body }).end());

app.listen(port, () => console.log(`Example app listening at http://localhost:${port}`));