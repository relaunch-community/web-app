const defaultTheme = require('tailwindcss/defaultTheme')
const plugin = require('tailwindcss/plugin')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {

      boxShadow: {
        'solid-l-sm': '-3px 3px 0 0 rgb(59, 130, 246)',
        'solid-l-md': '-6px 6px 0 0 rgb(59, 130, 246)',
        'solid-l-lg': '-9px 9px 0 0 rgb(59, 130, 246)',
        'solid-r-sm': '3px 3px 0 0 rgb(59, 130, 246)',
        'solid-r-md': '6px 6px 0 0 rgb(59, 130, 246)',
        'solid-r-lg': '9px 9px 0 0 rgb(59, 130, 246)',

        'full-sm': '0 0 3px 3px rgb(59, 130, 246)',
        'full-md': '0 0 5px 5px rgb(59, 130, 246)',
        'full-lg': '0 0 7px 7px rgb(59, 130, 246)',
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        theme: {
          light: "#fcf0d8",
          dark: "#11011a"
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
