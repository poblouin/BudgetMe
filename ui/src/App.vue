<script setup>
import {computed, ref} from 'vue'
import {useRouter} from "vue-router";

const router = useRouter()

const drawer = ref(false)

const currentRoute = computed(() => {
  return router.currentRoute.value.name
})
</script>

<template>
  <v-layout class="rounded rounded-md">
    <v-app-bar>
      <template #prepend>
        <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      </template>

      <v-app-bar-title>Budget Me</v-app-bar-title>
    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      location="left"
    >
      <v-list
        density="compact"
        nav
      >
        <v-list-item
          :active="currentRoute === 'Home'"
          title="Home"
          value="home"
          to="/"
        />
        <v-list-item
          :active="currentRoute === 'Transaction Categories'"
          title="Transaction Categories"
          value="transaction-categories"
          to="/transaction-categories"
        />
      </v-list>
    </v-navigation-drawer>

    <v-main
      class="d-flex align-center justify-center"
      style="min-height: 300px;"
    >
      <router-view />
    </v-main>
  </v-layout>
</template>
