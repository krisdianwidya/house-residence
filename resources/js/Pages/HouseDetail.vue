<template>
  <Message v-if="isError" severity="error" :sticky="sticky" :life="4000">{{
    errorMessage
  }}</Message>
  <h1>House Detail</h1>
  <h1 v-if="isLoading">Loading</h1>
  <Card v-else>
    <template #title>
      <div class="flex justify-content-between align-content-center">
        <span> House Number: {{ houseDetail.house_number }} </span>
        <div class="flex gap-2">
          <Button
            type="button"
            label="Ubah data rumah"
            @click="toggleModal(true, 'insertUpdate', null)"
          ></Button>
          <Button
            type="button"
            label="Hapus Data Rumah"
            severity="secondary"
          ></Button>
        </div>
      </div>
    </template>
    <template #content>
      <Tag
        :severity="houseDetail.is_active ? 'success' : 'warning'"
        :value="houseDetail.is_active ? 'Terisi' : 'Kosong'"
        rounded
      ></Tag>
      <h3>Penghuni</h3>
      <div class="card">
        <DataTable :value="houseDetail.persons" tableStyle="min-width: 50rem">
          <Column field="full_name" header="Nama"></Column>
          <Column field="phone_number" header="Nomor HP"></Column>
          <Column field="is_full" header="Tetap/Kontrak">
            <template #body="{ data }">
              <Tag
                :value="data.is_full ? 'Tetap' : 'Kontrak'"
                :severity="data.is_full ? 'success' : 'secondary'"
              />
            </template>
          </Column>
          <Column field="married_status" header="Status Pernikahan"></Column>
        </DataTable>
      </div>
      <h3>Iuran-iuran</h3>
      <DataTable :value="houseDetail.payments" tableStyle="min-width: 50rem">
        <Column field="type" header="Iuran"></Column>
        <Column field="bill_for" header="Untuk bulan/tahun">
          <template #body="{ data }">
            {{ new Date(data.bill_for).getMonth() + 1 }}/{{
              new Date(data.bill_for).getFullYear()
            }}
          </template>
        </Column>
        <Column field="amount" header="Jumlah">
          <template #body="{ data }"> Rp {{ data.amount }} </template>
        </Column>
        <Column field="paid_at" header="Dibayar pada">
          <template #body="{ data }">
            {{ new Date(data.paid_at).toLocaleString() }}
          </template>
        </Column>
      </DataTable>
    </template>
  </Card>
</template>

<script setup>
import axios from "axios";
import { ref, reactive, onMounted } from "vue";
import { useRoute } from "vue-router";

const route = useRoute();
onMounted(() => {
  fetchDetailHouse();
});

const isLoading = ref(false);
const isError = ref(false);
const errorMessage = ref("");

const houseDetail = reactive({});

const fetchDetailHouse = async () => {
  isLoading.value = true;
  try {
    const { data } = await axios.get(
      `${import.meta.env.VITE_BASE_URL}api/houses/${route.params.id}`
    );
    Object.assign(houseDetail, data.data);
    // houseDetail.se = { ...data.data };
    // console.log({ ...data.data });
    console.log(houseDetail);
    // houses.value = [...data.data.data];
    // housesCount.value = data.data.total;
  } catch (error) {
    console.log(error);
    // isError.value = true;
    // errorMessage.value = error.response.data.message;
  }
  isLoading.value = false;
};

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