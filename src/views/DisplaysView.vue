<template>
  <div :id="`${$route.name}-view`" class="w-100 p-3">
    <!-- help modal -->
    <HelpModalComponent>
      <h5>Navigating</h5>
      <p>Use the tabs to navigate between <strong>Displays, Playlists, Content</strong>.</p>
      <h5>Displays</h5>
      <p>
        Each signage device (display) can be edited (
        <Pencil />) and assigned a playlist, which contains a set of ordered images (content) to be presented.
        Online or disabled devices can also be rebooted (
        <Restart />) or previewed (
        <Eye />)
      </p>
      <h5>Display Status</h5>
      <span :class="statusBadgeClass('online')" class="badge">Online</span><small> - Display is fully operational and
        all actions can be applied.</small><br />
      <span :class="statusBadgeClass('offline')" class="badge">Offline</span><small> - Changes cannot be applied to
        display.</small><br />
      <span :class="statusBadgeClass('disabled')" class="badge">Disabled</span><small> - Display has been suspended. No
        content will be shown.</small><br /><br />
      <h5>Playlists</h5>
      <p>
        Playlists can be edited (
        <Pencil />) and assigned to a display. Playlists contain a set of ordered images (content) to be presented.
        Each playlist is created by a user with <span class="btn btn-sm btn-success small">
          <PlaylistPlay /> New Playlist
        </span>
      </p>
      <h5>Content</h5>
      <p>
        Content can be edited (
        <Pencil />) and added to a playlist. Content uploads will undergo approval before they can be added to a
        playlist.
        Upload new content with <span class="btn btn-sm btn-primary small">
          <UploadBox /> Upload Content
        </span>
      </p>
      <h5>Group Permissions</h5>
      <small>
        <strong>System</strong> - All actions allowed, with additional backend configuration options for signage
        devices<br />
        <strong>HR</strong> - Manage events, displays, playlists, content, and approvals<br />
        <strong>Supervisors</strong> - Upload content and create new playlists
      </small>
    </HelpModalComponent>

    <!--  header + toolbar  -->
    <div class="hstack align-items-center flex-wrap position-sticky mb-3">
      <!-- header -->
      <div class="fs-5 fw-semibold text-capitalize d-flex align-items-center gap-2">
        <span>{{ $route.name }}</span>
        <span>
          <HelpCircleOutline data-bs-toggle="modal" data-bs-target="#help-modal" title="Help" class="cursor-pointer" />
        </span>
      </div>
      <!-- toolbar -->
      <div class="hstack ms-auto fw-semibold gap-2 text-nowrap flex-wrap">
        <!-- add any toolbar buttons here if needed in the future -->
        <div class="btn btn-sm btn-success">
          <PlaylistPlay /> New Playlist
        </div>
        <div class="btn btn-sm btn-primary">
          <UploadBox /> Upload Content
        </div>

      </div>
    </div>
    <!-- main content -->
    <div class="card p-3">
      <!-- tabs -->
      <ul class="nav nav-tabs" id="displays-tab-list" role="tablist">
        <li v-for="endpoint in endpoints" :key="endpoint" class="nav-item" role="presentation">
          <button class="nav-link text-capitalize" :class="activeTab === endpoint ? 'active' : ''"
            @click="activeTab = endpoint" :id="`${endpoint}-tab`" type="button" role="tab">
            {{ endpoint }}
          </button>
        </li>
      </ul>
      <!-- tab views -->
      <div class="tab-content">
        <!-- tab view: displays -->
        <div class="tab-pane fade" :class="activeTab === 'displays' ? 'show active' : ''" id="displays">
          <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
            <!-- Filters -->
            <div class="d-flex align-items-center gap-2 flex-wrap">
              <small>
                <Filter class="me-1" />Filter By
              </small>
              <select class="form-select form-select-sm text-capitalize" v-model="filters.displays.location"
                style="width: 180px">
                <option value="" selected>All Locations</option>

                <option v-for="location in uniqueLocations" :key="location" :value="location">
                  {{ location }}
                </option>
              </select>

              <select class="form-select form-select-sm text-capitalize" v-model="filters.displays.status"
                style="width: 160px">
                <option value="">All Statuses</option>
                <option value="online">Online</option>
                <option value="offline">Offline</option>
                <option value="disabled">Disabled</option>
              </select>
            </div>

            <!-- search bar -->
            <input type="search" class="form-control form-control-sm col" placeholder="Search" v-model="search" />

            <!-- sort dropdown -->
            <div class="d-flex align-items-center gap-2">
              <small>
                <Sort class="me-1" />Sort By
              </small>
              <select id="status-sort" class="form-select form-select-sm text-capitalize"
                @change="sortList($event.target.value)" style="width: 180px">
                <option v-for="(sc, i) in sortableColumns.displays" :key="sc" :value="sc" :selected="i === 0">{{ sc }}
                </option>
              </select>

              <!-- view toggle for grid/list -->
              <div class="btn-group btn-group-sm" role="group">
                <button type="button" class="btn" :class="viewMode === 'list' ? 'btn-primary' : 'btn-outline-secondary'"
                  title="List view" @click="viewMode = 'list'">
                  <ViewList />
                </button>
                <button type="button" class="btn" :class="viewMode === 'grid' ? 'btn-primary' : 'btn-outline-secondary'"
                  title="Grid view" @click="viewMode = 'grid'">
                  <ViewGrid />
                </button>
              </div>

              <button :disabled="initializing" class="btn btn-sm border-0" title="Refresh"
                @click="() => refreshTabPane('displays')">
                <Refresh />
              </button>
            </div>
          </div>
          <!-- displays -->

          <!-- list view -->
          <div v-if="dataReady && viewMode === 'list'" class="table-responsive border-top border-bottom">
            <table v-if="displays && !initializing" class="table table-hover align-middle mb-0">
              <thead class="table-light sticky-top shadow-sm">
                <tr>
                  <th v-for="(sc, i) in sortableColumns.displays" class="cursor-pointer" v-bind:key="i"
                    @click="sortList(sc)">
                    {{ sc.charAt(0).toUpperCase() + sc.slice(1) }}
                    <template v-if="sc === sortColumn">
                      <TriangleSmallUp v-if="sortColumn === sc && !desc" />
                      <TriangleSmallDown v-else />
                    </template>
                  </th>
                  <th scope="col">Playlist</th>
                  <th class="text-end" scope="col">Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(d, i) in displays" :key="d" @mouseover="hoverIndex = i" @mouseleave="hoverIndex = -1">
                  <td class="fw-semibold"
                    style="max-width: 500px; overflow: hidden; text-overflow: ellipsis; text-wrap: nowrap">
                    {{ d.name }}
                  </td>
                  <td>{{ d.location }}</td>
                  <td>
                    <span class="badge text-capitalize" :class="statusBadgeClass(d.status)">{{ d.status }}</span>
                  </td>
                  <td>
                    <span>{{ getPlaylistName(d.playlist_id) }}</span>
                  </td>
                  <td class="text-end">
                    <div class="d-flex gap-3 justify-content-end" :class="{ invisible: hoverIndex !== i }">
                      <button class="btn btn-sm btn-outline-secondary cursor-pointer"><Eye /> View</button>
                      <button class="btn btn-sm btn-outline-secondary cursor-pointer"><Pencil /> Edit</button>
                      <button class="btn btn-sm btn-outline-secondary cursor-pointer"><Restart /> Restart</button>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
            <LoadingComponent v-else message="Loading displays..." />
          </div>

          <!-- grid view -->
          <div v-else-if="dataReady && viewMode === 'grid'"
            class="d-flex flex-row flex-wrap gap-3 overflow-hidden overflow-y-auto border-bottom border-top py-3"
            style="max-height: 70dvh;">
            <div v-for="(d, i) in displays" :key="d" @mouseover="hoverIndex = i" @mouseleave="hoverIndex = -1"
              class="card shadow-sm border col-2">
              <div class="card-body d-flex flex-column gap-2">
                <div class="fw-semibold" style="max-width: 500px; overflow: hidden; text-overflow: ellipsis">
                  {{ d.name }}
                </div>
                <small>
                  <PlaylistPlay /> {{ getPlaylistName(d.playlist_id) }}
                </small>
                <small class="text-muted">
                  <MapMarker /> {{ d.location }} <br /> {{ d.resolution }}
                </small>
                <small>
                  <span class="badge text-capitalize" :class="statusBadgeClass(d.status)">{{ d.status }}</span>
                </small>
              </div>
              <div class="card-footer d-flex gap-3 justify-content-end" :class="{ invisible: hoverIndex !== i }">
                <Pencil class="cursor-pointer" title="Edit" />
                <Restart class="cursor-pointer" title="Restart" />
              </div>
            </div>
          </div>

          <div v-else-if="displays.length == 0" class="text-center text-secondary py-4">
            No matches found. Please adjust your filters.
          </div>
        </div>
        <!-- tab view: playlists -->
        <div class="tab-pane fade" :class="activeTab === 'playlists' ? 'show active' : ''" id="playlists">
          <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
            <div class="me-auto hstack gap-2">
              <!-- sort dropdown -->
              <small>
                <Sort class="me-1" />Sort By
              </small>
              <select id="status-sort" class="text-capitalize form-select form-select-sm"
                @change="sortList($event.target.value)" style="width: 180px">
                <option v-for="(sc, i) in sortableColumns.playlists" :key="sc" :value="sc" :selected="i === 0">{{ sc }}
                </option>
              </select>
            </div>

            <!-- search bar -->
            <input type="search" class="form-control form-control-sm col" placeholder="Search" v-model="search" />

            <div class="ms-auto">
              <!-- view toggle for grid/list -->
              <div class="btn-group btn-group-sm" role="group">
                <button type="button" class="btn" :class="viewMode === 'list' ? 'btn-primary' : 'btn-outline-secondary'"
                  title="List view" @click="viewMode = 'list'">
                  <ViewList />
                </button>
                <button type="button" class="btn" :class="viewMode === 'grid' ? 'btn-primary' : 'btn-outline-secondary'"
                  title="Grid view" @click="viewMode = 'grid'">
                  <ViewGrid />
                </button>
              </div>

              <button :disabled="initializing" class="btn btn-sm border-0 ms-2" title="Refresh"
                @click="() => refreshTabPane('playlists')">
                <Refresh />
              </button>
            </div>
          </div>
          <!-- playlists -->

          <!-- list view -->
          <div v-if="dataReady && viewMode === 'list'" class="table-responsive border-top border-bottom">
            <table v-if="playlists && !initializing" class="table table-hover align-middle mb-0">
              <thead class="table-light sticky-top shadow-sm">
                <tr>
                  <th v-for="(sc, i) in sortableColumns.playlists" class="cursor-pointer" v-bind:key="i"
                    @click="sortList(sc)">
                    {{ sc.charAt(0).toUpperCase() + sc.slice(1) }}
                    <template v-if="sc === sortColumn">
                      <TriangleSmallUp v-if="sortColumn === sc && !desc" />
                      <TriangleSmallDown v-else />
                    </template>
                  </th>
                  <th class="text-end" scope="col">Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(d, i) in playlists" :key="d" @mouseover="hoverIndex = i" @mouseleave="hoverIndex = -1">
                  <td class="fw-semibold"
                    style="max-width: 500px; overflow: hidden; text-overflow: ellipsis; text-wrap: nowrap">
                    {{ d.name }}
                  </td>
                  <td>{{ d.description }}</td>
                  <td class="text-end">
                    <div class="d-flex gap-3 justify-content-end" :class="{ invisible: hoverIndex !== i }">
                      <button class="btn btn-sm btn-outline-secondary cursor-pointer"><Pencil /> Edit</button>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
            <LoadingComponent v-else message="Loading playlists..." />
          </div>

          <!-- grid view -->
          <div v-else-if="dataReady && viewMode === 'grid'"
            class="d-flex flex-row flex-wrap gap-3 overflow-hidden overflow-y-auto border-bottom border-top py-3"
            style="max-height: 70dvh">
            <div v-for="(d, i) in playlists" :key="d" @mouseover="hoverIndex = i" @mouseleave="hoverIndex = -1"
              class="card shadow-sm border col-2">
              <div class="card-body d-flex flex-column gap-2">
                <div class="fw-semibold" style="max-width: 500px; overflow: hidden; text-overflow: ellipsis">
                  {{ d.name }}
                </div>
                <small class="text-muted">
                  {{ d.description }}
                </small>
              </div>
              <div class="card-footer d-flex gap-3 justify-content-end" :class="{ invisible: hoverIndex !== i }">
                <Pencil class="cursor-pointer" title="Edit" />
              </div>
            </div>
          </div>

          <div v-else-if="playlists.length == 0" class="text-center text-secondary py-4">
            No matches found. Please adjust your filters.
          </div>
        </div>
        <!-- tab view: content -->
        <div class="tab-pane fade" :class="activeTab === 'content' ? 'show active' : ''" id="content">
          <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
            <!-- Filters -->
            <div class="d-flex align-items-center gap-2 flex-wrap">
              <small>
                <Filter class="me-1" />Filter By
              </small>
              <select class="form-select form-select-sm text-capitalize" v-model="filters.content.type"
                style="width: 160px">
                <option value="" selected>All Types</option>

                <option v-for="type in uniqueContentTypes" :key="type" :value="type">
                  {{ type }}
                </option>
              </select>

              <select class="form-select form-select-sm" v-model="filters.content.status" style="width: 160px">
                <option value="">All Statuses</option>
                <option value="active">Active</option>
                <option value="inactive">Inactive</option>
                <option value="archived">Archived</option>
              </select>
            </div>

            <!-- search bar -->
            <input type="search" class="form-control form-control-sm col" placeholder="Search" v-model="search" />

            <!-- sort dropdown -->
            <div class="d-flex align-items-center gap-2">
              <small>
                <Sort class="me-1" />Sort By
              </small>
              <select id="status-sort" class="form-select form-select-sm text-capitalize"
                @change="sortList($event.target.value)" style="width: 180px">
                <option v-for="(sc, i) in sortableColumns.content" :key="sc" :value="sc" :selected="i === 0">{{ sc.includes('_') ? sc.split('_').join(' ') : sc }}
                </option>
              </select>

              <!-- view toggle for grid/list -->
              <div class="btn-group btn-group-sm" role="group">
                <button type="button" class="btn" :class="viewMode === 'list' ? 'btn-primary' : 'btn-outline-secondary'"
                  title="List view" @click="viewMode = 'list'">
                  <ViewList />
                </button>
                <button type="button" class="btn" :class="viewMode === 'grid' ? 'btn-primary' : 'btn-outline-secondary'"
                  title="Grid view" @click="viewMode = 'grid'">
                  <ViewGrid />
                </button>
              </div>

              <button :disabled="initializing" class="btn btn-sm border-0" title="Refresh"
                @click="() => refreshTabPane('content')">
                <Refresh />
              </button>
            </div>
          </div>
          <!-- content -->

          <!-- list view -->
          <div v-if="dataReady && viewMode === 'list'" class="table-responsive border-top border-bottom">
            <table v-if="content && !initializing" class="table table-hover align-middle mb-0">
              <thead class="table-light sticky-top shadow-sm">
                <tr>
                  <th v-for="(sc, i) in sortableColumns.content" class="cursor-pointer" v-bind:key="i"
                    @click="sortList(sc)">
                    {{ sc.charAt(0).toUpperCase() + sc.slice(1) }}
                    <template v-if="sc === sortColumn">
                      <TriangleSmallUp v-if="sortColumn === sc && !desc" />
                      <TriangleSmallDown v-else />
                    </template>
                  </th>
                  <th scope="col">Filename</th>
                  <th class="text-end" scope="col">Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(c, i) in content" :key="c" @mouseover="hoverIndex = i" @mouseleave="hoverIndex = -1">
                  <td>
                    <span class="badge" :class="contentTypeBadgeClass(c.type)">{{ c.type }}</span>
                  </td>
                  <td class="fw-semibold"
                    style="max-width: 500px; overflow: hidden; text-overflow: ellipsis; text-wrap: nowrap">
                    {{ c.title }}
                  </td>
                  <td>
                    <span class="badge text-capitalize" :class="contentStatusBadgeClass(c.status)">{{ c.status }}</span>
                  </td>
                  <td>
                    <span class="text-muted">{{ c.filename }}</span>
                  </td>
                  <td class="text-end">
                    <div class="d-flex gap-3 justify-content-end" :class="{ invisible: hoverIndex !== i }">
                      <button class="btn btn-sm btn-outline-secondary cursor-pointer"><Pencil /> Edit</button>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
            <LoadingComponent v-else message="Loading content..." />
          </div>

          <!-- grid view -->
          <div v-else-if="dataReady && viewMode === 'grid'"
            class="d-flex flex-row flex-wrap gap-3 overflow-hidden overflow-y-auto border-bottom border-top py-3"
            style="max-height: 70dvh">
            <div v-for="(c, i) in content" :key="c" @mouseover="hoverIndex = i" @mouseleave="hoverIndex = -1"
              class="card shadow-sm border col-2 overflow-hidden">
              <!-- will provide thumbnail but for now set it as the logo of file type -->
              <!-- <img src="https://picsum.photos/400/200" class="card-img-top" alt="Thumbnail"
                style="height: 100px; object-fit: cover" /> -->
              <span v-if="c.type === 'image'"
                class="bg-success text-white justify-content-center align-items-center d-flex fs-3"
                style="height: 100px;">
                <Image />
              </span>
              <span v-else-if="c.type === 'pdf'"
                class="bg-danger text-white justify-content-center align-items-center d-flex fs-3"
                style="height: 100px;">
                <FilePdfBox />
              </span>
              <span v-else-if="c.type === 'video'"
                class="bg-primary text-white justify-content-center align-items-center d-flex fs-3"
                style="height: 100px;">
                <Video />
              </span>
              <span v-else-if="c.type === 'other'"
                class="bg-body-secondary text-muted justify-content-center align-items-center d-flex fs-3"
                style="height: 100px;">
                <FileDocument />
              </span>
              <div class="card-body d-flex flex-column gap-2">
                <div class="fw-semibold" style="max-width: 500px; overflow: hidden; text-overflow: ellipsis">
                  {{ c.title }}
                </div>
                <small class="text-muted">
                  {{ c.filename }}
                </small>
                <small>
                  <span class="badge text-capitalize" :class="contentStatusBadgeClass(c.status)">{{ c.status }}</span>
                </small>
                <small>
                  <span class="text-muted text-capitalize">Uploaded {{ new Date(c.created_at).toLocaleString() }}</span>
                </small>
              </div>
              <div class="card-footer d-flex gap-3 justify-content-end" :class="{ invisible: hoverIndex !== i }">
                <Pencil class="cursor-pointer" title="Edit" />
              </div>
            </div>
          </div>

          <div v-else-if="content.length == 0" class="text-center text-secondary py-4">
            No matches found. Please adjust your filters.
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script> // continue here: work on dashboard data integration
import Filter from "vue-material-design-icons/Filter.vue";
import Sort from "vue-material-design-icons/Sort.vue";
import Pencil from "vue-material-design-icons/Pencil.vue";
import Restart from "vue-material-design-icons/Restart.vue";
import Refresh from "vue-material-design-icons/Refresh.vue";
import TriangleSmallUp from "vue-material-design-icons/TriangleSmallUp.vue";
import TriangleSmallDown from "vue-material-design-icons/TriangleSmallDown.vue";
import ViewGrid from "vue-material-design-icons/ViewGrid.vue";
import ViewList from "vue-material-design-icons/ViewList.vue";
import HelpCircleOutline from "vue-material-design-icons/HelpCircleOutline.vue";
import PlaylistPlay from "vue-material-design-icons/PlaylistPlay.vue";
import MapMarker from "vue-material-design-icons/MapMarker.vue";
import Eye from "vue-material-design-icons/Eye.vue";
import Image from "vue-material-design-icons/Image.vue";
import FilePdfBox from "vue-material-design-icons/FilePdfBox.vue";
import Video from "vue-material-design-icons/Video.vue";
import FileDocument from "vue-material-design-icons/FileDocument.vue";
import UploadBox from "vue-material-design-icons/UploadBox.vue";

import LoadingComponent from "@/components/LoadingComponent.vue";
import HelpModalComponent from "@/components/HelpModalComponent.vue";

import { filterByField, sortByField } from "@/common/helpers";

export default {
  name: "DisplayView",
  components: {
    Filter,
    Sort,
    Pencil,
    Restart,
    Refresh,
    TriangleSmallUp,
    TriangleSmallDown,
    ViewGrid,
    ViewList,
    HelpCircleOutline,
    PlaylistPlay,
    MapMarker,
    Eye,
    Image,
    FilePdfBox,
    Video,
    FileDocument,
    UploadBox,

    LoadingComponent,
    HelpModalComponent,
  },
  data() {
    return {
      initializing: true, // loading state
      endpoints: ["displays", "playlists", "content"], // tabs/api endpoints
      rawDisplays: [],
      rawPlaylists: [],
      rawContent: [],
      dataReady: false,
      search: "",
      filters: {
        displays: {
          location: "",
          status: "",
        },
        playlists: {
          name: "",
        },
        content: {
          type: "",
          status: "",
        },
      },
      sortColumn: "name",
      sortableColumns: {
        displays: ["name", "location", "status"],
        playlists: ["name", "description"],
        content: ["type", "title", "status", "created_at"],
      },
      desc: false, // sort direction
      hoverIndex: -1, // for hover effect on tab actions
      viewMode: "grid", // grid or list
      activeTab: "displays", // active tab
    };
  },
  computed: {
    uniqueLocations() {
      // disctinct options for location filter
      return [...new Set(this.rawDisplays.map((d) => d.location))].sort();
    },

    uniqueContentTypes() {
      // distinct options for content type filter
      return [...new Set(this.rawContent.map((c) => c.type))].sort();
    },

    displays() {
      let result = [...this.rawDisplays];
      result = filterByField(result, "location", this.filters.displays.location);
      result = filterByField(result, "status", this.filters.displays.status);
      if (this.search.trim().length > 0) {
        // parse the object values into one string and use that as the search reference (for the object)
        result = result.filter((d) => JSON.stringify(d).toLowerCase().includes(this.search.toLowerCase()));
      }
      return sortByField(result, this.sortColumn, this.desc);
    },

    playlists() {
      let result = [...this.rawPlaylists];
      result = filterByField(result, "name", this.filters.playlists.name, "includes");
      result = filterByField(result, "description", this.filters.playlists.description, "includes");
      if (this.search.trim().length > 0) {
        result = result.filter((d) => JSON.stringify(d).toLowerCase().includes(this.search.toLowerCase()));
      }
      return sortByField(result, this.sortColumn, this.desc);
    },

    content() {
      let result = [...this.rawContent];
      result = filterByField(result, "type", this.filters.content.type);
      result = filterByField(result, "status", this.filters.content.status);
      if (this.search.trim().length > 0) {
        result = result.filter((d) => JSON.stringify(d).toLowerCase().includes(this.search.toLowerCase()));
      }
      return sortByField(result, this.sortColumn, this.desc);
    },
  },
  methods: {
    getPlaylistName(pid) {
      const p = this.rawPlaylists.find((p) => p.id === pid);
      return p ? p.name : "";
    },
    sortList(column) {
      if (this.sortColumn === column) {
        this.desc = !this.desc;
      } else {
        this.sortColumn = column;
        this.desc = false;
      }
    },
    async refreshTabPane(endpoint) {
      try {
        // refetch data of current tab view
        this.initializing = true;
        const res = await this.$axios.get(this.$api + endpoint + "?all=1");
        switch (endpoint) {
          case "displays":
            this.rawDisplays = res.data;
            break;
          case "playlists":
            this.rawPlaylists = res.data;
            break;
          case "content":
            this.rawContent = res.data;
            break;
        }
        this.initializing = false;
      } catch (error) {
        console.log(error + " at " + this.name);
      }
    },
    statusBadgeClass(status) {
      const map = {
        online: "bg-success-subtle text-success-emphasis",
        offline: "bg-danger-subtle text-danger-emphasis",
        disabled: "bg-secondary-subtle text-secondary-emphasis",
      };
      return map[status?.toLowerCase()] || "bg-secondary";
    },
    contentTypeBadgeClass(type) {
      const map = {
        image: "bg-success-subtle text-success-emphasis text-uppercase",
        video: "bg-primary-subtle text-primary-emphasis text-uppercase",
        other: "bg-body-secondary text-muted text-uppercase",
        pdf: "bg-warning-subtle text-warning-emphasis text-uppercase",
      };
      return map[type?.toLowerCase()] || "bg-secondary";
    },
    contentStatusBadgeClass(status) {
      const map = {
        active: "bg-success-subtle text-success-emphasis",
        inactive: "bg-secondary-subtle text-secondary-emphasis",
        archived: "bg-dark-subtle text-dark-emphasis",
      };
      return map[status?.toLowerCase()] || "bg-secondary";
    },
  },
  async mounted() {
    try {
      this.initializing = true;

      // set active tab from query param if valid
      const tab = this.$route.query.tab;
      if (this.endpoints.includes(tab)) {
        this.activeTab = tab;
      }

      this.endpoints.forEach(async (endpoint) => {
        const res = await this.$axios.get(this.$api + endpoint + "?all=1");
        switch (endpoint) {
          case "displays":
            this.rawDisplays = res.data;
            break;
          case "playlists":
            this.rawPlaylists = res.data;
            break;
          case "content":
            this.rawContent = res.data;
            break;
        }
      })

      this.dataReady = true;
      this.initializing = false;
      console.log(this.stringDisplays)
    } catch (error) {
      console.log(error + " at " + this.name);
    }
  },
  watch: {
    "$route.query.tab"(tab) {
      if (this.endpoints.includes(tab)) {
        this.activeTab = tab;
      }
    },
    "search"() {
      console.log(this.search)
    },
  },
};
</script>

<style>
.nav-item.active {
  background-color: var(--bs-primary);
}

.tab-pane {
  padding: 1rem;
}

.table-responsive {
  max-height: 70dvh;
  overflow-y: auto;
}

.table> :not(caption)>*>* {
  vertical-align: middle;
}

.table tbody tr:nth-child(even) {
  background-color: var(--bs-primary);
}

.table tbody tr:first-of-type {
  border-top: none;
}

.table tbody tr:last-child td {
  border-bottom: none;
}
</style>
