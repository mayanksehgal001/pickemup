import Vue from 'vue'
import VueRouter from 'vue-router'
import store from 'store'
import PickemupRoutes from './pickemup_routes.js'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  base: __dirname,
  linkActiveClass: "is-active",
  linkExactActiveClass: "is-active",
  routes: PickemupRoutes
})

router.beforeEach((to, _from, next) => {
  store.dispatch("refreshData", to.path);
  next();
})

export default router
