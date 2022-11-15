/** @type {import('jest').Config} */
const config = {
  transformIgnorePatterns: ['/node_modules/(?!(lodash-es)/)'],
};

module.exports = config;
