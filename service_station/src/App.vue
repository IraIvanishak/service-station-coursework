<script setup>
import Stations from './components/Stations.vue';
import Navigation from './components/Navigation.vue';

</script>

<template>
  <header>
  </header>
  <div class="container">
    <div class="left-nav">
      <RouterView />
    </div>
    <div class="right-nav">
      <Navigation />
    </div>
  </div>
</template>
<style scoped>
.container {
  align-items: flex-start; /* Замість центрування по вертикалі */
  height: 100vh; /* Висота на весь екран */
}

.left-nav, .right-nav {
  flex: 1;
}

.left-nav {
  width: 100%;
  overflow: auto; /* Дозволяє прокрутку всередині лівої панелі */
}

.right-nav {

  position: fixed; /* Фіксує позицію відносно viewport */
  top: 90px; /* Положення зверху на 50% від висоти */
  right: 0; /* Правий край */
  width: 200px; /* Фіксована ширина навігації */
  height: auto; /* Автоматична висота в залежності від контенту */
  padding-right:    20px;
}

</style>

