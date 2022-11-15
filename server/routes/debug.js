// Ideally, this should be password protected
import express from 'express';
import { sortBy } from 'lodash-es';
import { getConnectionConfig } from '../app-config.js';

let router = express.Router();

router.get('/environment', (req, res) => {
  let env = {};
  for (let key of sortBy(Object.keys(process.env), k => k.toLowerCase())) {
    env[key] = process.env[key];
  }

  res.render('environment.pug', {
    title: 'App Server Environment',
    env,
  });
});

router.get('/database', (req, res) => {
  let env = getConnectionConfig();
  res.render('environment.pug', {
    title: 'Database config',
    env,
  });
});

export default router;
