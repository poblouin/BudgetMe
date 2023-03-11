import { defineConfig } from 'vite'
import eslint from 'vite-plugin-eslint'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [
      eslint({ fix: true}),
      vue()
  ],
  resolve: {
      alias: {
          '~': '/src',
      },
  },
  server: {
    host: true,
    port: 8000,
  }
})
