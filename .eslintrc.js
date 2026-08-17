module.exports = {
  root: true,

  env: {
    node: true,
  },

  extends: [
    'plugin:vue/vue3-essential',
    '@vue/standard',
  ],

  parserOptions: {
    parser: '@babel/eslint-parser',
  },

  rules: {
    'no-console': 'off',
    'no-debugger': 'off',
    'no-trailing-spaces': 'off',
    semi: 'off',
    quotes: 'off',
    'eol-last': 'off',
    'comma-dangle': 'off',
    'space-before-function-paren': 'off',
    'vue/no-unused-components': 'off',
    'no-multiple-empty-lines': 'off',
    'no-unused-vars': 'off',
  },
}