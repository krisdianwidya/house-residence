<template>
  <h1>House Listing</h1>
  <Message v-if="isError" severity="error" :sticky="sticky" :life="4000">{{
    errorMessage
  }}</Message>
  <div class="card">
    <Toolbar class="mb-4">
      <template #start>
        <Button
          label="Tambah data rumah baru"
          icon="pi pi-plus"
          severity="success"
          class="mr-2"
          @click="toggleModal(true, 'insertUpdate', null)"
        />
      </template>
    </Toolbar>
    <DataTable
      :value="houses"
      dataKey="id"
      tableStyle="min-width: 50rem"
      lazy
      :loading="isLoading"
      paginator
      :rows="params.rows"
      :rowsPerPageOptions="[5, 10, 15]"
      :first="params.first"
      :totalRecords="housesCount"
      :sortField="params.sortField"
      :sortOrder="params.sortOrder"
      @page="onPage($event)"
      @sort="onSort($event)"
    >
      <Column header="Nomor Rumah" sortable field="house_number">
        <template #body="slotProps">
          {{ slotProps.data.house_number }}
        </template>
      </Column>
      <Column header="Status" field="is_active" sortable>
        <template #body="{ data }">
          <Tag
            :value="data.is_active ? 'Terisi' : 'Kosong'"
            :severity="data.is_active ? 'success' : 'warning'"
          />
        </template>
      </Column>
      <Column header="Jumlah penghuni" sortable field="persons_count">
        <template #body="slotProps">
          {{ slotProps.data.persons_count }}
        </template>
      </Column>
      <Column
        header="Action"
        headerStyle="width: 5rem; text-align: center"
        bodyStyle="text-align: center; overflow: visible"
      >
        <template #body="slotProps">
          <router-link :to="`/house/detail/${slotProps.data.id}`">
            <Button type="button" icon="pi pi-cog" rounded />
          </router-link>
        </template>
      </Column>
    </DataTable>
    <InsertUpdateHouseModal
      :showModalProps="showModal"
      @close="toggleModal"
      @insertUpdate="fetchAllHouse"
      :addMode="addMode"
    />
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, watch } from "vue";
import axios from "axios";

import InsertUpdateHouseModal from "../Components/InsertUpdateHouseModal.vue";

const houses = ref([]);
const housesCount = ref(0);
const isLoading = ref(false);
const params = reactive({
  first: 0,
  rows: 10,
  sortField: "house_number",
  sortOrder: 1, // 1 -> asc; -1 -> desc
  page: 0,
});
const isError = ref(false);
const errorMessage = ref("");

const showModal = ref(false);
const addMode = ref(true);

onMounted(() => {
  fetchAllHouse();
});

const fetchAllHouse = async () => {
  isLoading.value = true;
  try {
    const { data } = await axios.get(
      `${import.meta.env.VITE_BASE_URL}api/houses?page=${
        params.page + 1
      }&limit=${params.rows}&sort=${params.sortField}&order=${
        params.sortOrder === 1 ? "asc" : "desc"
      }`
    );
    houses.value = [...data.data.data];
    housesCount.value = data.data.total;
  } catch (error) {
    isError.value = true;
    errorMessage.value = error.response.data.message;
  }
  isLoading.value = false;
};

const onPage = ({ first, page, rows, sortField, sortOrder }) => {
  params.first = first;
  params.page = page;
  params.rows = rows;
  params.sortField = sortField;
  params.sortOrder = sortOrder;
};

const onSort = ({ first, rows, sortField, sortOrder }) => {
  params.first = first;
  params.rows = rows;
  params.sortField = sortField;
  params.sortOrder = sortOrder;
};

watch(params, () => {
  fetchAllHouse();
});

const toggleModal = (value, type, data) => {
  if (type === "insertUpdate") {
    showModal.value = value;
    if (data) {
      // employeeData.value = { ...data };
      addMode.value = false;
    } else {
      addMode.value = true;
    }
  } else {
    showModal.value = false;
  }
};
</script>