<template>
  <h1>Person Listing</h1>
  <Message v-if="isError" severity="error" :sticky="sticky" :life="4000">{{
    errorMessage
  }}</Message>
  <div class="card">
    <Toolbar class="mb-4">
      <template #start>
        <Button
          label="Tambah data penghuni baru"
          icon="pi pi-plus"
          severity="success"
          class="mr-2"
          @click="toggleModal(true, 'insert')"
        />
      </template>
    </Toolbar>
    <DataTable
      :value="persons"
      dataKey="id"
      tableStyle="min-width: 50rem"
      lazy
      :loading="isLoading"
      paginator
      :rows="params.rows"
      :rowsPerPageOptions="[5, 10, 15]"
      :first="params.first"
      :totalRecords="personsCount"
      :sortField="params.sortField"
      :sortOrder="params.sortOrder"
      @page="onPage($event)"
      @sort="onSort($event)"
    >
      <Column header="Nama" sortable field="full_name"> </Column>
      <Column field="phone_number" header="Nomor HP"></Column>
      <Column header="Tetap/Kontrak" field="is_full" sortable>
        <template #body="{ data }">
          <Tag
            :value="data.is_full ? 'Tetap' : 'Kontrak'"
            :severity="data.is_full ? 'success' : 'secondary'"
          />
        </template>
      </Column>
      <Column
        field="married_status"
        header="Status Pernikahan"
        sortable=""
      ></Column>
      <Column field="house_id" header="Anggota Rumah di" sortable>
        <template #body="slotProps">
          {{ slotProps.data.house.house_number }}
        </template>
      </Column>
      <Column header="Foto ktp">
        <template #body="slotProps">
          <img
            :src="slotProps.data.id_card_photo"
            class="border-round"
            style="width: 70px"
          />
        </template>
      </Column>
      <Column
        header="Action"
        headerStyle="width: 5rem; text-align: center"
        bodyStyle="text-align: center; overflow: visible"
      >
        <template #body="slotProps">
          <router-link :to="`/person/detail/${slotProps.data.id}`">
            <Button type="button" icon="pi pi-cog" rounded />
          </router-link>
        </template>
      </Column>
    </DataTable>
    <InsertUpdatePersonModal
      :showModalProps="showModal"
      @close="toggleModal"
      @insertUpdate="fetchAllPersons"
      :addMode="addMode"
    />
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, watch } from "vue";
import axios from "axios";

import InsertUpdatePersonModal from "../Components/InsertUpdatePersonModal.vue";

const persons = ref([]);
const personsCount = ref(0);
const isLoading = ref(false);
const params = reactive({
  first: 0,
  rows: 10,
  sortField: "created_at",
  sortOrder: 1, // 1 -> asc; -1 -> desc
  page: 0,
});

const isError = ref(false);
const errorMessage = ref("");

const showModal = ref(false);
const addMode = ref(true);

onMounted(() => {
  fetchAllPersons();
});

const fetchAllPersons = async () => {
  isLoading.value = true;
  try {
    const { data } = await axios.get(
      `${import.meta.env.VITE_BASE_URL}api/persons?page=${
        params.page + 1
      }&limit=${params.rows}&sort=${params.sortField}&order=${
        params.sortOrder === 1 ? "asc" : "desc"
      }`
    );
    persons.value = [...data.data.data];
    personsCount.value = data.data.total;
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
  fetchAllPersons();
});

const toggleModal = (value, type) => {
  if (type === "insert") {
    showModal.value = value;
  } else {
    showModal.value = false;
  }
};
</script>