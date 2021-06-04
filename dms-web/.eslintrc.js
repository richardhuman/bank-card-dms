module.exports = {
  root: true,
  extends: ["airbnb", "prettier"],
  rules: {
    "no-unused-vars": [
      "error",
      { vars: "all", args: "after-used", ignoreRestSiblings: false },
    ],
    "no-console": "error",
    "no-undef": "error",
    "prettier/prettier": "error",
  },
  plugins: ["prettier"],
};
