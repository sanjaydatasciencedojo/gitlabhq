import Vue from 'vue';
import VueRouter from 'vue-router';
import { joinPaths } from '../lib/utils/url_utility';
import IndexPage from './pages/index.vue';
import TreePage from './pages/tree.vue';

Vue.use(VueRouter);

export default function createRouter(base, baseRef) {
  return new VueRouter({
    mode: 'history',
    base: joinPaths(gon.relative_url_root || '', base),
    routes: [
      {
        path: `/tree/${baseRef}(/.*)?`,
        name: 'treePath',
        component: TreePage,
        props: route => ({
          path: route.params.pathMatch.replace(/^\//, ''),
        }),
        beforeEnter(to, from, next) {
          document
            .querySelectorAll('.js-hide-on-navigation')
            .forEach(el => el.classList.add('hidden'));

          next();
        },
      },
      {
        path: '/',
        name: 'projectRoot',
        component: IndexPage,
      },
    ],
  });
}
