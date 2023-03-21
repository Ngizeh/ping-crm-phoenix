import { createApp, h } from 'vue'
import { createInertiaApp } from '@inertiajs/inertia-vue3'
import { InertiaProgress } from '@inertiajs/progress'


InertiaProgress.init(
  { showSpinner: true}
  )
  
  createInertiaApp({
    resolve: name => require(`./Pages/${name}`),
    title: title => title ? `${title} - Ping CRM` : 'Ping CRM',
    setup({ el, App, props, plugin }) {
      createApp({ render: () => h(App, props) })
      .use(plugin)
      .mount(el)
    },
  })
  