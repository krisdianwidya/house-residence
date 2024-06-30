<template>
  <div class="card">
    <Toolbar class="mb-4">
      <template #start>
        <Button
          label="Tambah data rumah baru"
          icon="pi pi-plus"
          severity="success"
          class="mr-2"
        />
      </template>
    </Toolbar>
    <DataTable :value="houses" tableStyle="min-width: 50rem">
      <Column header="Rumah">
        <template #body="slotProps">
          {{ slotProps.data.first_name }} {{ slotProps.data.last_name }}
        </template>
      </Column>
      <Column header="Action">
        <template>
          <div class="flex">
            <Button icon="pi pi-pencil" outlined rounded class="mr-2" />
            <Button icon="pi pi-trash" outlined rounded severity="danger" />
          </div>
        </template>
      </Column>
    </DataTable>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";

const houses = ref([]);

onMounted(() => {
  fetchAllHouse();
});

const fetchAllHouse = async () => {
  const { data } = await axios.get(
    `${import.meta.env.VITE_BASE_URL}api/houses`
  );
  houses.value = [...data.data.data];
  console.log(data);
};
</script>