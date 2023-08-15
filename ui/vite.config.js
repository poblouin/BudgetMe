import {defineConfig} from 'vite'
import eslint from 'vite-plugin-eslint'
import vue from '@vitejs/plugin-vue'
import vuetify from "vite-plugin-vuetify";

export default defineConfig({
  plugins: [
    eslint({fix: true}),
    vue(),
    vuetify({ autoImport: true }),
  ],
  resolve: {
    alias: {
      '~': '/src',
      '@components': '/src/components'
    },
  },
  server: {
    host: true,
    port: 8000,
  }
})
