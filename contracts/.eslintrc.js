module.exports = {
  env: {
    commonjs: true,
    es2021: true,
    node: true,
  },
  extends: 'eslint:recommended',
  overrides: [
    {
      files: ['**/*.test.js', '**/*.spec.jsx'],
      env: {
        jest: true,
      },
    },
  ],
  parserOptions: {
    ecmaVersion: 'latest',
  },
  rules: {},
};
