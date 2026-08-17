import { createRouter, createWebHistory } from "vue-router";
import { markRaw, nextTick } from "vue";
import { config } from "@/common/config.js";

// views
import DashboardView from "../views/DashboardView.vue";

// icons
import ViewDashboard from "vue-material-design-icons/ViewDashboard.vue";
import Television from "vue-material-design-icons/Television.vue";
import CalendarMonth from "vue-material-design-icons/CalendarMonth.vue";
import Cog from "vue-material-design-icons/Cog.vue";
import AccountCircle from "vue-material-design-icons/AccountCircle.vue";
import axios from "axios";
import { globalStore } from "@/common/store.js";

const publicPages = ["Auth", "Unauthorized"];

const routes = [
  {
    path: "/",
    redirect: { name: "Dashboard" },
    active: false,
  },
  {
    path: "/dashboard",
    name: "Dashboard" || "", // using for tab name
    component: DashboardView,
    active: true, // set false to hide from sidebar
    icon: markRaw(ViewDashboard),
  },
  {
    path: "/displays",
    name: "Displays",
    component: () => import("../views/DisplaysView.vue"),
    active: true,
    icon: markRaw(Television),
  },
  {
    path: "/calendar",
    name: "Calendar",
    component: () => import("../views/CalendarView.vue"),
    active: true,
    icon: markRaw(CalendarMonth),
  },
  {
    path: "/settings",
    name: "Settings",
    component: () => import("../views/SettingsView.vue"),
    active: true,
    icon: markRaw(Cog),
  },
  {
    path: "/profile",
    name: "Profile",
    component: () => import("../views/ProfileView.vue"),
    active: false,
    icon: markRaw(AccountCircle),
  },
  {
    path: "/auth",
    name: "Auth",
    component: () => import("../views/AuthView.vue"),
    active: false,
  },
  {
    path: "/unauthorized",
    name: "Unauthorized",
    component: () => import("../views/NotAllowedView.vue"),
    active: false,
  },
  {
    path: "/:pathMatch(.*)*",
    redirect: { name: "Dashboard" },
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

// do stuff before route change
router.beforeEach(async (to) => {
  try {
    // redirect to login page if not logged in and trying to access a restricted page
    const authRes = await axios.get(config.api + "employees?auth"); // check if ttprod auth session is set
    globalStore.authenticated = authRes.data;
    // user not logged in
  } catch (error) {  
    if (!publicPages.includes(to.name)) {
      return { name: "Auth" };
    }
  }
});

// do stuff after route change and dom has loaded;
router.afterEach((to) => {
  nextTick(async () => {
    // Update document title
    document.title = `${config.appName || ""} | ${to.name}`;
  });
});

export default router;
