<template>
  <div class="h-screen bg-gray-800 fixed top-0 left-0 w-2">
    <span class="font-semibold text-2xl px-6 py-5 block text-400 w-full"
      >Menu</span
    >
    <ul class="list-none p-0 m-0 overflow-hidden">
      <li>
        <router-link
          to="/"
          class="flex align-items-center cursor-pointer px-6 py-3 text-400 hover:text-100 hover:bg-gray-600 transition-duration-150 transition-colors w-full no-underline"
        >
          <i class="pi pi-lightbulb mr-2"></i>
          <span class="font-medium">List Rumah</span>
        </router-link>
      </li>
      <li>
        <router-link
          to="/people"
          class="flex align-items-center cursor-pointer px-6 py-3 text-400 hover:text-100 hover:bg-gray-600 transition-duration-150 transition-colors w-full no-underline"
        >
          <i class="pi pi-address-book mr-2"></i>
          <span class="font-medium">List Penghuni</span>
        </router-link>
      </li>
    </ul>
  </div>
</template>