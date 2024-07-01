<template>
  <Toast />
  <Dialog
    v-model:visible="showModal"
    modal
    :header="props.addMode ? 'Tambah data rumah' : 'Ubah data rumah'"
    :closable="false"
  >
    <div class="flex align-items-center gap-3 mb-3">
      <label for="houseNumber" class="font-semibold w-6rem">Nomor Rumah</label>
      <InputText
        id="houseNumber"
        v-model="houseDetail.houseNumber"
        class="flex-auto"
        autocomplete="off"
      />
    </div>
    <div class="flex align-items-center gap-3 mb-3">
      <label for="isActive" class="font-semibold w-6rem">Apakah terisi</label>
      <div class="flex flex-wrap gap-3">
        <div class="flex align-items-center">
          <RadioButton
            v-model="houseDetail.isActive"
            inputId="isActive1"
            :value="false"
          />
          <label for="isActive1" class="ml-2">Tidak</label>
        </div>
        <div class="flex align-items-center">
          <RadioButton
            v-model="houseDetail.isActive"
            inputId="isActive2"
            :value="true"
          />
          <label for="isActive2" class="ml-2">Ya</label>
        </div>
      </div>
    </div>
    <div class="flex justify-content-end gap-2">
      <Button
        type="button"
        label="Batalkan"
        @click="closeModal"
        severity="secondary"
      ></Button>
      <Button
        type="button"
        :label="props.addMode ? 'Simpan' : 'Update'"
        @click="insertHouse"
      ></Button>
    </div>
  </Dialog>

  <Dialog v-model:visible="loading" header="Loading" modal :closable="false">
  </Dialog>
</template>
  
  <script setup>
import { ref, reactive, defineProps, watch, defineEmits } from "vue";
import axios from "axios";
import Toast from "primevue/toast";
import { useToast } from "primevue/usetoast";
import { useRoute } from "vue-router";

const route = useRoute();

const toast = useToast();

const showModal = ref(false);
const props = defineProps({
  showModalProps: {
    type: Boolean,
    default: false,
  },
  houseDetailProps: Object,
  addMode: Boolean,
});

const houseDetail = reactive({
  houseNumber: "",
  isActive: false,
});

watch(
  () => props.showModalProps,
  (newVal) => {
    if (newVal) {
      showModal.value = newVal;
    }
  }
);

watch(
  () => props.houseDetailProps,
  (newVal) => {
    houseDetail.houseNumber = newVal.houseNumber;
    houseDetail.isActive = newVal.isActive;
  }
);

const emit = defineEmits(["close", "insertUpdate"]);
const closeModal = () => {
  showModal.value = false;
  resetValue();
  emit("close", false);
};

const resetValue = () => {
  houseDetail.houseNumber = "";
  houseDetail.isActive = false;
};

const loading = ref(false);

const insertHouse = async () => {
  loading.value = true;
  try {
    props.addMode
      ? await axios.post(`${import.meta.env.VITE_BASE_URL}api/houses`, {
          house_number: houseDetail.houseNumber,
          is_active: houseDetail.isActive,
        })
      : await axios.patch(
          `${import.meta.env.VITE_BASE_URL}api/houses/${route.params.id}`,
          {
            house_number: houseDetail.houseNumber,
            is_active: houseDetail.isActive,
          }
        );
    resetValue();

    emit("insertUpdate");
    let detailWordToast = "";
    props.addMode
      ? (detailWordToast = "ditambahkan")
      : (detailWordToast = "diupdate");
    toast.add({
      severity: "success",
      summary: "Berhasil",
      detail: `Data rumah telah ${detailWordToast}`,
      life: 5000,
    });
  } catch (error) {
    let detailWord = `${error.response.data.house_number[0]}, ${error.response.data.is_active[0]}`;
    toast.add({
      severity: "warning",
      summary: "Gagal",
      detail: detailWord,
      life: 5000,
    });
  }
  closeModal();
  loading.value = false;
};
</script>