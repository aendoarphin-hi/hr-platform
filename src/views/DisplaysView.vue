<template>
  <div v-if="dataReady" :id="`${$route.name}-view`" class="w-100 p-3">
    <!-- help modal -->
    <HelpModalComponent>
      <h5>Navigating</h5>
      <p>Use the tabs to navigate between <strong>Displays, Playlists, Content</strong>.</p>
      <h5>Displays</h5>
      <p>
        Each screen device (display) can be edited (
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
        <strong>System</strong> - All actions allowed, with additional backend configuration options for screen
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
            @click="activeTab = endpoint; search = ''" :id="`${endpoint}-tab`" type="button" role="tab">
            {{ endpoint }}
          </button>
        </li>
      </ul>
      <!-- tab views -->
      <div class="tab-content">
        <!-- tab view: displays -->
        <div v-if="dataReady" class="tab-pane fade" :class="activeTab === 'displays' ? 'show active' : ''"
          id="displays">
          <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
            <!-- Filters -->
            <div class="d-flex align-items-center gap-2 flex-wrap">
              <small>
                <Filter class="me-1" />Filter By
              </small>
              <select class="form-select form-select-sm text-capitalize" v-model="filters.displays.location"
                style="width: 180px">
                <option value="" selected>All Locations</option>

                <option v-for="l in locations" :key="l.id" :value="l.name">
                  {{ l.name }}
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
              <select id="status-sort-displays" class="form-select form-select-sm text-capitalize"
                :value="sortColumns.displays" @change="sortList($event.target.value)" style="width: 180px">

                <option v-for="sc in sortableColumns.displays" :key="sc" :value="sc">{{ sc }}
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
                <tr class="small text-uppercase">
                  <th v-for="(sc, i) in sortableColumns.displays" class="cursor-pointer" v-bind:key="i"
                    @click="sortList(sc)">
                    {{ columnLabel(sc) }}
                    <template v-if="sc === sortColumns.displays">
                      <TriangleSmallUp v-if="!sortDesc.displays" />
                      <TriangleSmallDown v-else />
                    </template>
                  </th>
                  <th scope="col">Playlist</th>
                  <th class="text-end" scope="col">Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(d, i) in displays" :key="d.id" @mouseover="hoverIndex = i" @mouseleave="hoverIndex = -1">
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
                      <button class="btn btn-sm btn-outline-secondary cursor-pointer">
                        <Eye /> View
                      </button>
                      <button class="btn btn-sm btn-outline-secondary cursor-pointer">
                        <Pencil /> Edit
                      </button>
                      <button class="btn btn-sm btn-outline-secondary cursor-pointer">
                        <Restart /> Restart
                      </button>
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
            <div v-for="(d, i) in displays" :key="d.id" @mouseover="hoverIndex = i" @mouseleave="hoverIndex = -1"
              class="card shadow-sm border col-2">
              <div class="card-body d-flex flex-column gap-2">
                <div class="fw-semibold" style="max-width: 500px; overflow: hidden; text-overflow: ellipsis">
                  {{ d.name }}
                </div>
                <small>
                  <span class="badge text-capitalize" :class="statusBadgeClass(d.status)">{{ d.status }}</span>
                </small>
                <small>
                  <PlaylistPlay /> {{ getPlaylistName(d.playlist_id) }}
                </small>
                <small v-if="d.location" class="text-muted">
                  <MapMarker /> {{ d.location }}
                </small>
              </div>
              <div class="card-footer d-flex gap-3 justify-content-end" :class="{ invisible: hoverIndex !== i }">
                <Pencil class="cursor-pointer" title="Edit" />
                <Restart class="cursor-pointer" title="Restart" />
              </div>
            </div>
          </div>
        </div>
        <div v-else>
          <LoadingComponent message="Loading displays..." />
        </div>
        <!-- tab view: playlists -->
        <div v-if="dataReady" class="tab-pane fade" :class="activeTab === 'playlists' ? 'show active' : ''"
          id="playlists">
          <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
            <div class="me-auto hstack gap-2">
              <!-- sort dropdown -->
              <small>
                <Sort class="me-1" />Sort By
              </small>
              <select id="status-sort-playlists" class="form-select form-select-sm text-capitalize"
                :value="sortColumns.playlists" @change="sortList($event.target.value)" style="width: 180px">

                <option v-for="sc in sortableColumns.playlists" :key="sc" :value="sc">{{ sc }}
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
                <tr class="small text-uppercase">
                  <th v-for="(sc, i) in sortableColumns.playlists" class="cursor-pointer" v-bind:key="i"
                    @click="sortList(sc)">
                    {{ columnLabel(sc) }}
                    <template v-if="sc === sortColumns.playlists">
                      <TriangleSmallUp v-if="!sortDesc.playlists" />
                      <TriangleSmallDown v-else />
                    </template>
                  </th>
                  <th class="text-end" scope="col">Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(d, i) in playlists" :key="d.id" @mouseover="hoverIndex = i" @mouseleave="hoverIndex = -1">
                  <td class="fw-semibold"
                    style="max-width: 500px; overflow: hidden; text-overflow: ellipsis; text-wrap: nowrap">
                    {{ d.name }}
                  </td>
                  <td>{{ d.description }}</td>
                  <td class="text-end">
                    <div class="d-flex gap-3 justify-content-end" :class="{ invisible: hoverIndex !== i }">
                      <button class="btn btn-sm btn-outline-secondary cursor-pointer">
                        <Pencil /> Edit
                      </button>
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
            <div v-for="(d, i) in playlists" :key="d.id" @mouseover="hoverIndex = i" @mouseleave="hoverIndex = -1"
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
        </div>
        <div v-else>
          <LoadingComponent message="Loading playlists..." />
        </div>
        <!-- tab view: content -->
        <div v-if="dataReady" class="tab-pane fade" :class="activeTab === 'content' ? 'show active' : ''" id="content">
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
              <select id="status-sort-content" class="form-select form-select-sm text-capitalize"
                :value="sortColumns.content" @change="sortList($event.target.value)" style="width: 180px">

                <option v-for="sc in sortableColumns.content" :key="sc" :value="sc">{{
                  sc.includes('_')
                    ? sc.split('_').join(' ') : sc }}
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
                <tr class="small text-uppercase">
                  <th v-for="(sc, i) in sortableColumns.content" class="cursor-pointer" v-bind:key="i"
                    @click="sortList(sc)">
                    {{ columnLabel(sc) }}
                    <template v-if="sc === sortColumns.content">
                      <TriangleSmallUp v-if="!sortDesc.content" />
                      <TriangleSmallDown v-else />
                    </template>
                  </th>
                  <th class="text-end" scope="col"></th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(c, i) in content" :key="c.id" @mouseover="hoverIndex = i" @mouseleave="hoverIndex = -1">
                  <td>
                    <span class="badge" :class="contentTypeBadgeClass(c.type)">{{ c.type }}</span>
                  </td>
                  <td class="fw-semibold"
                    style="max-width: 500px; overflow: hidden; text-overflow: ellipsis; text-wrap: nowrap">
                    {{ c.title }}
                  </td>
                  <td>
                    <span class="badge text-capitalize my-0" :class="contentStatusBadgeClass(c.status)">{{ c.status
                    }}</span>
                  </td>
                  <td>
                    <span class="text-muted text-capitalize small">{{ new Date(c.created_at).toLocaleString() }}</span>
                  </td>
                  <td>
                    <span class="text-muted small">{{ c.filename }}</span>
                  </td>
                  <td class="text-end">
                    <div class="text-nowrap d-flex gap-3 justify-content-end" :class="{ invisible: hoverIndex !== i }">
                      <button class="btn btn-sm btn-outline-secondary cursor-pointer">
                        <Pencil /> Edit
                      </button>
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
            <div v-for="(c, i) in content" :key="c.id" @mouseover="hoverIndex = i" @mouseleave="hoverIndex = -1"
              class="card shadow-sm border col-2 overflow-hidden">
              <!-- will provide thumbnail but for now set it as the logo of file type -->
              <!-- <img src="https://picsum.photos/400/200" class="card-img-top" alt="Thumbnail"
                style="height: 100px; object-fit: cover" /> -->
              <span :class="getContentThumbnail(c).class" class="justify-content-center align-items-center d-flex fs-3"
                style="height: 100px;">
                <span v-if="hoverIndex === i" style="background-color: rgba(0,0,0,0.5);"
                  class="w-100 h-100 d-flex justify-content-center fs-5">
                  <Pencil />
                </span>
                <component v-else style="filter: drop-shadow(0 5px 3px rgba(0,0,0,0.5));"
                  :is="getContentThumbnail(c).icon" />
              </span>
              <div class="card-body d-flex flex-column gap-2">
                <div class="fw-semibold" style="max-width: 500px; overflow: hidden; text-overflow: ellipsis">
                  {{ c.title }}
                </div>
                <small>
                  <span class="badge text-capitalize" :class="contentStatusBadgeClass(c.status)">{{ c.status }}</span>
                </small>
              </div>
            </div>
          </div>
        </div>
        <div v-else>
          <LoadingComponent message="Loading content..." />
        </div>
      </div>
    </div>
  </div>
  <div v-else>
    <LoadingComponent message="Loading displays..." />
  </div>
</template>

<script>
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

import { filterByField, searchByText, sortByField } from "@/common/helpers";

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
      endpoints: ["displays", "playlists", "content"],
      rawDisplays: [],
      rawPlaylists: [],
      rawContent: [],
      locations: [],
      dataReady: false,
      search: "",
      filters: {
        displays: {
          location: "",
          status: "",
        },
        content: {
          type: "",
          status: "",
        },
      },
      sortColumns: {
        displays: "name",
        playlists: "name",
        content: "type",
      },
      sortableColumns: {
        displays: ["name", "location", "status"],
        playlists: ["name", "description"],
        content: ["type", "title", "status", "created_at", "filename"],
      },
      sortDesc: {
        displays: false,
        playlists: false,
        content: false,
      },
      hoverIndex: -1, // for hover effect on tab actions
      viewMode: "grid", // grid or list
      activeTab: "displays", // active tab
    };
  },
  computed: {
    uniqueContentTypes() {
      // distinct options for content type filter
      return [...new Set(this.rawContent.map((c) => c.type))].sort();
    },

    displays() {
      const locationNameById = Object.fromEntries(
        this.locations.map((l) => [l.id, l.name])
      );
      let result = this.rawDisplays.map((d) => ({
        ...d,
        location: locationNameById[d.location_id] ?? "",
      }));
      result = filterByField(result, "location", this.filters.displays.location);
      result = filterByField(result, "status", this.filters.displays.status);
      if (this.search.trim().length > 0) {
        result = searchByText(result, this.search);
      }
      return sortByField(result, this.sortColumns.displays, this.sortDesc.displays);
    },

    playlists() {
      let result = [...this.rawPlaylists];
      if (this.search.trim().length > 0) {
        result = searchByText(result, this.search);
      }
      return sortByField(result, this.sortColumns.playlists, this.sortDesc.playlists);
    },

    content() {
      let result = [...this.rawContent];
      result = filterByField(result, "type", this.filters.content.type);
      result = filterByField(result, "status", this.filters.content.status);
      if (this.search.trim().length > 0) {
        result = searchByText(result, this.search);
      }
      return sortByField(result, this.sortColumns.content, this.sortDesc.content);
    },
  },
  methods: {
    getContentThumbnail(c) {
      switch (c.type) {
        case "image":
          return { class: "bg-success text-white", icon: Image };
        case "video":
          return { class: "bg-primary text-white", icon: Video };
        case "pdf":
          return { class: "bg-danger text-white", icon: FilePdfBox };
        default:
          return { class: "bg-body-secondary text-muted", icon: FileDocument };
      }
    },
    getPlaylistName(pid) {
      const p = this.rawPlaylists.find((p) => p.id === pid);
      return p ? p.name : "";
    },
    sortList(column) {
      const tab = this.activeTab;
      if (this.sortColumns[tab] === column) {
        this.sortDesc[tab] = !this.sortDesc[tab];
      } else {
        this.sortColumns[tab] = column;
        this.sortDesc[tab] = false;
      }
    },

    columnLabel(l) {
      // remove underscore and capitalize
      return l.replace(/_/g, " ");
    },
    async fetchEndpoint(endpoint) {
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
    },
    async refreshTabPane(endpoint) {
      this.initializing = true;
      try {
        await this.fetchEndpoint(endpoint);
      } catch (error) {
        console.log(error + " at " + this.name);
      } finally {
        this.initializing = false;
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

      // get all locations
      this.locations = (await this.$axios.get(this.$api + "locations?all=1")).data;

      await Promise.all(this.endpoints.map((endpoint) => this.fetchEndpoint(endpoint)));

      this.dataReady = true;
      this.initializing = false;
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
