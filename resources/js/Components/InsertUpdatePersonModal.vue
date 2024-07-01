<template>
  <Toast />
  <Dialog
    v-model:visible="showModal"
    modal
    :header="props.addMode ? 'Tambah data penghuni' : 'Ubah data penghuni'"
    :closable="false"
  >
    <div class="flex align-items-center gap-3 mb-3">
      <label for="fullName" class="font-semibold w-6rem">Nama Lengkap</label>
      <InputText
        id="fullName"
        v-model="personDetail.fullName"
        class="flex-auto"
        autocomplete="off"
      />
    </div>
    <div class="flex align-items-center gap-3 mb-3">
      <label for="phoneNumber" class="font-semibold w-6rem">Nomor HP</label>
      <InputText
        id="phoneNumber"
        v-model="personDetail.phoneNumber"
        class="flex-auto"
        autocomplete="off"
      />
    </div>
    <div class="flex align-items-center gap-3 mb-3">
      <label for="marriedStatus" class="font-semibold w-6rem"
        >Status pernikahan</label
      >
      <InputText
        id="marriedStatus"
        v-model="personDetail.marriedStatus"
        class="flex-auto"
        autocomplete="off"
      />
    </div>
    <div class="flex align-items-center gap-3 mb-3">
      <label class="font-semibold w-6rem">Anggota Rumah:</label>
      <AutoComplete
        optionLabel="house_number"
        :suggestions="houses"
        @complete="search"
        v-model="selectedHouse"
        placeholder="Cari nomor rumah"
      >
        <template #option="slotProps">
          <div class="flex align-options-center">
            <div>{{ slotProps.option.house_number }}</div>
          </div>
        </template>
      </AutoComplete>
    </div>
    <div class="flex align-items-center gap-3 mb-3">
      <label for="isFull" class="font-semibold w-6rem"
        >Apakah penghuni tetap</label
      >
      <div class="flex flex-wrap gap-3">
        <div class="flex align-items-center">
          <RadioButton
            v-model="personDetail.isFull"
            inputId="isFull1"
            :value="0"
          />
          <label for="isFull1" class="ml-2">Tidak</label>
        </div>
        <div class="flex align-items-center">
          <RadioButton
            v-model="personDetail.isFull"
            inputId="isFull2"
            :value="1"
          />
          <label for="isFull2" class="ml-2">Ya</label>
        </div>
      </div>
    </div>
    <div class="flex align-items-center gap-3 mb-4">
      <label class="font-semibold w-6rem">Foto KTP</label>
      <FileUpload
        mode="basic"
        chooseLabel="Pilih foto ktp"
        name="id_card_photo"
        accept="image/*"
        :maxFileSize="1000000"
        :showUploadButton="false"
        @select="fileSelected"
      />
      <img
        v-if="personDetail.idCardPhoto"
        role="presentation"
        :alt="personDetail.idCardPhoto.name"
        :src="personDetail.idCardPhoto.objectURL"
        width="70"
      />
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
        @click="insertPerson"
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
  personDetailProps: Object,
  addMode: Boolean,
});

const personDetail = reactive({
  fullName: "",
  isFull: 0,
  phoneNumber: 0,
  marriedStatus: "",
  idCardPhoto: null,
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
  () => props.personDetailProps,
  (newVal) => {
    personDetail.fullName = newVal.fullName;
    personDetail.isFull = newVal.isFull;
    personDetail.phoneNumber = newVal.phoneNumber;
    personDetail.marriedStatus = newVal.marriedStatus;
    selectedHouse.value = newVal.selectedHouse;
  }
);

const houses = ref([]);
const selectedHouse = ref({});

const searchHouse = async (query) => {
  loading.value = true;
  try {
    const { data } = await axios.get(
      `${import.meta.env.VITE_BASE_URL}api/houses?house-number=${query}`
    );
    houses.value = [...data.data.data];
  } catch (error) {
    console.log(error);
  }
  loading.value = false;
};

const search = (event) => {
  searchHouse(event.query);
};

const emit = defineEmits(["close", "insertUpdate"]);
const closeModal = () => {
  showModal.value = false;
  resetValue();
  emit("close", false);
};

const resetValue = () => {
  personDetail.fullName = "";
  personDetail.isFull = 0;
  personDetail.phoneNumber = 0;
  personDetail.marriedStatus = "";
  personDetail.idCardPhoto = null;
  selectedHouse.value = {};
};

const fileSelected = (event) => {
  personDetail.idCardPhoto = event.files[0];
};

const loading = ref(false);

const insertPerson = async () => {
  loading.value = true;
  try {
    let formdata = new FormData();
    formdata.append("full_name", personDetail.fullName);
    formdata.append("is_full", personDetail.isFull.toString());
    formdata.append("phone_number", personDetail.phoneNumber);
    formdata.append("married_status", personDetail.marriedStatus);
    formdata.append("house_id", selectedHouse.value.id);
    formdata.append("id_card_photo", personDetail.idCardPhoto);
    props.addMode
      ? await axios.post(
          `${import.meta.env.VITE_BASE_URL}api/persons`,
          formdata
        )
      : await axios.patch(
          `${import.meta.env.VITE_BASE_URL}api/persons/${route.params.id}`,
          formdata
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
    let detailWord = `${error.response.data.person_number[0]}, ${error.response.data.is_active[0]}`;
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