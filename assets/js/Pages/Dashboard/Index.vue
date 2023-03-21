<template>
  <div>
    <Head title="Dashboard" />
    <flash-messages :flash="flash"/>
    <h1 class="mb-8 text-3xl font-bold">Dashboard We are here</h1>
    <p class="mb-8 leading-normal">Hey {{ $attrs.auth.user.first_name }}! Welcome to Ping CRM, a demo app designed to help illustrate how 
      <a class="text-indigo-500 hover:text-orange-600 underline" href="https://inertiajs.com">Inertia.js </a> works with Phoenix Framework as backend.
    </p>
  </div>
</template>

<script>
import { Head } from '@inertiajs/inertia-vue3'
import Layout from '@/Shared/Layout'
import FlashMessages from '@/Shared/FlashMessages'

export default {
  components: {
    Head,
    FlashMessages
  },
  data() {
    return {
       flash: this.$attrs.flash
    }
  },
  layout: Layout,
}
</script>
