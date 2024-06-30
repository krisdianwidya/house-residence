<template>
  <div class="grid">
    <div class="col-2 p-0">
      <Sidebar />
    </div>
    <div class="col-10 px-3">
      <router-view v-slot="{ Component, route }">
        <div :key="route.name">
          <Component :is="Component" />
        </div>
      </router-view>
    </div>
  </div>
</template>

<script setup>
import Sidebar from "./Components/Sidebar.vue";
</script>