<script lang="ts" setup>
const { $e } = useNuxtApp()

const openLink = (url: string) => {
  $e('c:branding:click')
  window.open(url, '_blank', 'noopener,noreferrer')
}
</script>

<template>
  <div
    class="flex items-center gap-3 cursor-pointer text-gray-700 dark:text-slate-300"
    @click="openLink('https://nupixl.com')"
  >
    <img src="/img/brand/nupixl-color.png" class="w-7 h-7 -my-0.5" alt="Nupixl" />

    <div class="text-sm">Nupixl Forms</div>
  </div>
</template>
