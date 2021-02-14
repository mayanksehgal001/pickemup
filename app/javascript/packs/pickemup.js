// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import 'core-js/stable'
import 'regenerator-runtime/runtime'

require("@rails/ujs").start()
require("channels")

import Vue from 'vue';
import store from 'store/index.js';
import router from 'router/index.js';
import { BootstrapVue } from 'bootstrap-vue';
import VueLodash from 'vue-lodash';
import lodash from 'lodash';
import JQuery from 'jquery';
import Unicon from 'vue-unicons';
import * as unicons from 'vue-unicons/src/icons';
import 'stylesheets/admin/application.scss';
import Snackbar from 'vuejs-snackbar';
import VueMoment from 'vue-moment'
import VueDragDrop from 'vue-drag-drop';
import vSelect from 'vue-select';

Unicon.add(Object.values({ ...unicons }), {
  fill: '#050038'
})
let $ = JQuery
Vue.component('snackbar', Snackbar);
Vue.use(BootstrapVue);
Vue.use(Unicon);
Vue.use(VueLodash, { lodash: lodash });
Vue.use(VueMoment);
Vue.use(VueDragDrop);
Vue.component('v-select', vSelect)


document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    router,
    store
  }).$mount('#pickemup')
})
