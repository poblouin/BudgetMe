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
          :active="currentRoute === 'Budget'"
          title="Budget"
          value="budget"
          to="/budget"
        />
        <v-list-item
          :active="currentRoute === 'Transactions'"
          title="Transactions"
          value="transactions"
          to="/transactions"
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
      <v-card width="80vw">
        <router-view />
      </v-card>
    </v-main>
  </v-layout>
</template>
