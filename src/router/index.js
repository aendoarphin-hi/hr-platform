import { createRouter, createWebHistory } from "vue-router";
import { markRaw, nextTick } from "vue";
import { config } from "@/common/config.js";
import { store } from "@/common/store.js";
import axios from "axios";

// views
import DashboardView from "@/views/DashboardView.vue";
import ScreensView from "@/views/ScreensView.vue";
import CalendarView from "@/views/CalendarView.vue";
import Approvals from "@/views/Approvals.vue";
import ProfileView from "@/views/ProfileView.vue";
import AuthView from "@/views/AuthView.vue";
import UnauthorizedView from "@/views/UnauthorizedView.vue";
import TestView from "@/views/TestView.vue";
import ConfigureView from "@/views/ConfigureView.vue";

// icons
import ViewDashboard from "vue-material-design-icons/ViewDashboard.vue";
import Television from "vue-material-design-icons/Television.vue";
import CalendarMonth from "vue-material-design-icons/CalendarMonth.vue";
import AccountClock from "vue-material-design-icons/AccountClock.vue";
import AccountCircle from "vue-material-design-icons/AccountCircle.vue";
import { inSystemGroup } from "@/common/helpers";

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
    path: "/screens",
    name: "Screens",
    component: <ScreensView />,
    active: true,
    icon: markRaw(Television),
  },
  {
    path: "/calendar",
    name: "Calendar",
    component: <CalendarView />,
    active: true,
    icon: markRaw(CalendarMonth),
  },
  {
    path: "/approvals",
    name: "Approvals",
    component: <Approvals />,
    active: true,
    icon: markRaw(AccountClock),
  },
  {
    path: "/profile",
    name: "Profile",
    component: <ProfileView />,
    active: false,
    icon: markRaw(AccountCircle),
  },
  {
    path: "/configuration",
    name: "Screen Configuration",
    component: <ConfigureView />,
    active: false,
  },
  {
    path: "/auth",
    name: "Auth",
    component: <AuthView />,
    active: false,
  },
  {
    path: "/unauthorized",
    name: "Unauthorized",
    component: <UnauthorizedView />,
    active: false,
  },
  {
    path: "/test",
    name: "Test",
    component: <TestView />,
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
    const authRes = await axios.get(config.api + "?auth");
    store.authenticated = authRes.data;

    // restrict configuration page if not in system group
    if (to.name === "Screen Configuration" && !inSystemGroup()) {
      return { name: "Unauthorized" };
    }
  } catch (error) {
    store.authenticated = false;
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
