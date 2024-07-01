<template>
  <Message v-if="isError" severity="error" :sticky="sticky" :life="4000">{{
    errorMessage
  }}</Message>
  <Toast />
  <ConfirmDialog></ConfirmDialog>
  <h1>Person Detail</h1>
  <h1 v-if="isLoading">Loading</h1>
  <Card v-else>
    <template #title>
      <div class="flex justify-content-between align-content-center">
        <span> Nama penghuni: {{ personDetail.full_name }} </span>
        <div class="flex gap-2">
          <Button
            type="button"
            label="Ubah data penghuni"
            @click="toggleModal(true, 'update')"
          ></Button>
          <Button
            type="button"
            label="Hapus Data penghuni"
            severity="secondary"
            @click="deletePerson()"
          ></Button>
        </div>
      </div>
    </template>
    <template #content>
      <Tag
        :severity="personDetail.is_full ? 'success' : 'warning'"
        :value="personDetail.is_full ? 'Penghuni tetap' : 'Penghuni kontrak'"
        rounded
      ></Tag>
      <h3>Iuran-iuran</h3>
      <DataTable :value="personDetail.payments" tableStyle="min-width: 50rem">
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
  <InsertUpdatePersonModal
    :showModalProps="showModal"
    @close="toggleModal"
    @insertUpdate="fetchDetailPerson"
    :addMode="false"
    :personDetailProps="{
      fullName: personDetail.full_name,
      isFull: personDetail.is_full,
      phoneNumber: personDetail.phone_number,
      marriedStatus: personDetail.married_status,
      selectedHouse: personDetail.house,
    }"
  />
</template>

<script setup>
import axios from "axios";
import { ref, reactive, onMounted } from "vue";
import { useRoute, useRouter } from "vue-router";

import Toast from "primevue/toast";
import ConfirmDialog from "primevue/confirmdialog";
import { useConfirm } from "primevue/useconfirm";
import { useToast } from "primevue/usetoast";

import InsertUpdatePersonModal from "../Components/InsertUpdatePersonModal.vue";

const confirm = useConfirm();
const toast = useToast();

const route = useRoute();
const router = useRouter();
onMounted(() => {
  fetchDetailPerson();
});

const isLoading = ref(false);
const isError = ref(false);
const errorMessage = ref("");

const personDetail = reactive({});

const fetchDetailPerson = async () => {
  isLoading.value = true;
  try {
    const { data } = await axios.get(
      `${import.meta.env.VITE_BASE_URL}api/persons/${route.params.id}`
    );
    Object.assign(personDetail, data.data);
  } catch (error) {
    isError.value = true;
    errorMessage.value = error.response.data.message;
  }
  isLoading.value = false;
};

const showModal = ref(false);

const toggleModal = (value, type) => {
  if (type === "update") {
    showModal.value = value;
  } else {
    showModal.value = false;
  }
};

const processDeletePerson = async () => {
  isLoading.value = true;
  try {
    await axios.delete(
      `${import.meta.env.VITE_BASE_URL}api/persons/${route.params.id}`
    );
    toast.add({
      severity: "info",
      summary: "Confirmed",
      detail: "Record deleted",
      life: 3000,
    });
    router.push("/");
  } catch (error) {
    isError.value = true;
    errorMessage.value = error.response.data.message;
  }
  isLoading.value = false;
};

const deletePerson = () => {
  confirm.require({
    message: "Apakah yakin untuk menghapus data?",
    header: "Hati-hati",
    icon: "pi pi-info-circle",
    rejectLabel: "Batalkan",
    acceptLabel: "Lanjut Hapus",
    rejectClass: "p-button-secondary p-button-outlined",
    acceptClass: "p-button-danger",
    accept: () => {
      processDeletePerson();
    },
  });
};
</script>