import { createApp } from 'vue'
import { DefaultApolloClient } from '@vue/apollo-composable'
import App from './App.vue'
import apolloClient from "./plugins/ApoloClient.js";
import vuetify from "./plugins/vuetify.js";
import router from "./router/index.js";

createApp(App)
  .use(router)
  .use(vuetify)
  .provide(DefaultApolloClient, apolloClient)
  .mount('#app')
