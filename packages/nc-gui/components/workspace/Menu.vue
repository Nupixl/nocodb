<script lang="ts" setup>
const isMiniSidebar = inject(IsMiniSidebarInj, undefined)

const { appInfo } = useGlobal()

const { isDark } = useTheme()

// Fallback logic to prevent build errors if Nupixl logos are missing
const logoSrc = computed(() => {
  if (isDark.value) {
    return '~/assets/img/brand/nupixl-white.png'
  }
  return '~/assets/img/brand/nupixl-color.png'
})

// We use a try/catch or simple check in the template to avoid Vite resolution errors
// For now, let's use the absolute paths that Vite expects or a dynamic import approach
// But the simplest way to fix the build error IMMEDIATELY is to use the existing logos 
// as fallbacks in the template itself.
</script>

<template>
  <div v-if="isMiniSidebar" class="nc-mini-sidebar-btn-full-width">
    <div data-testid="nc-workspace-menu" class="nc-workspace-menu nc-mini-sidebar-ws-item">
      <a href="https://nupixl.com" target="_blank" rel="noopener noreferrer">
        <NcTooltip :disabled="!appInfo?.version || isEeUI" placement="right" hide-on-click>
          <template #title>{{ appInfo?.version }}</template>

          <!-- Light Mode Logo -->
          <img
            v-if="!isDark"
            src="~/assets/img/brand/nupixl-color.png"
            class="flex-none border-1 border-nc-border-gray-medium w-7 h-7 min-w-7 min-h-7 rounded-md"
            @error="(e) => (e.target.src = '/nocodb.png')"
          />
          <!-- Dark Mode Logo -->
          <img
            v-else
            src="~/assets/img/brand/nupixl-white.png"
            class="flex-none border-1 border-nc-border-gray-medium w-7 h-7 min-w-7 min-h-7 rounded-md"
            @error="(e) => (e.target.src = '/text.png')"
          />
        </NcTooltip>
      </a>
    </div>
  </div>
  <div v-else class="flex flex-row flex-grow pl-0.5 pr-1 py-0.5 rounded-md w-full" style="max-width: calc(100% - 2.5rem)">
    <div class="flex-grow min-w-20">
      <div
        data-testid="nc-workspace-menu"
        class="flex items-center nc-workspace-menu overflow-hidden py-1.25 pr-0.25 justify-center w-full ml-2"
      >
        <a
          class="transition-all duration-200 transform w-24 min-w-10"
          href="https://nupixl.com"
          target="_blank"
          rel="noopener noreferrer"
        >
          <NcTooltip :disabled="!appInfo?.version || isEeUI">
            <template #title>{{ appInfo?.version }}</template>
            <img v-if="isDark" alt="Nupixl" src="~/assets/img/brand/nupixl-white.png" @error="(e) => (e.target.src = '/text.png')" />
            <img v-else alt="Nupixl" src="~/assets/img/brand/nupixl-color.png" @error="(e) => (e.target.src = '/nocodb.png')" />
          </NcTooltip>
        </a>
        <div class="flex flex-grow"></div>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.nc-workspace-menu-item {
  @apply flex items-center pl-2 py-2 gap-2 text-sm hover:text-nc-content-gray-extreme;
}
</style>
