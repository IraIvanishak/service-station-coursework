import { createRouter, createWebHistory } from 'vue-router'
import StationDetail from '../components/StationDetail.vue'
import Stations from '../components/Stations.vue'
import Repairs from '../components/Repairs.vue'
import Supply from '../components/Supply.vue'
import Meta from '../components/Meta.vue'
import CubeService from '../components/CubeService.vue'
import CubeSupply from '../components/CubeSupply.vue'
import DashBoard from '../components/DashBoard.vue'
import Clients from '../components/Clients.vue'
import Employee from '../components/Employee.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/stations',
      component: Stations,
      name: 'Stations'
    },
    {
      path: '/stations/:id',
      name: 'StationDetail',
      component: StationDetail,
      props: true 
    },
    {
      path: '/repairs',
      name: 'Repairs',
      component: Repairs
    },
    {
      path: '/supply',
      name: 'Supply',
      component: Supply
    },
    {
      path: '/meta',
      name: 'Meta',
      component: Meta
    },
    {
      path: '/',
      redirect: '/stations'
    },
    {
      path: '/:pathMatch(.*)*',
      redirect: '/stations'
    },
    {
      path: '/cube/service',
      name: 'CubeService',
      component: CubeService
    }, 
    {
      path: '/cube/supply',
      name: 'CubeSupply',
      component: CubeSupply
    },
    {
      path: '/dashboard',
      name: 'DashBoard',
      component: DashBoard
    },
    {
      path: '/Client',
      name: 'Client',
      component: Clients
    },
    {
      path: '/Employee',
      name: 'Employee',
      component: Employee
    }
    
  ]
  
})

export default router
