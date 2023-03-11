/** @type {import('tailwindcss').Config} */

module.exports = {
  content: ["assets/js/**/*.js", "lib/*_web.ex", "lib/*_web/**/*.*ex"],
  darkMode: "class",
  plugins: [require("daisyui")],
};
