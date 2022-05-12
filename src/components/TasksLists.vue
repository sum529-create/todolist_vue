<template>
  <div class="todolist-body">
    <div class="task-list" :style="{ height: isOpen ? '270px' : '465px' }">
      <div class="tasks" v-for="(data, i) in todoData" :key="i">
        <i
          v-if="data.checked"
          @click="checking(i)"
          class="material-icons tasks-check checked"
        >
          check_circle_outline
        </i>
        <i v-else class="material-icons tasks-check" @click="checking(i)">
          radio_button_unchecked
        </i>
        <div
          class="tasks-item"
          :class="data.checked === true ? 'tasks-done' : false"
          @click="
            data.checked === true
              ? notModify()
              : $emit('modify', data, isModify)
          "
        >
          {{ data.content }}
        </div>
        <div class="tasks-delete" @click="deleteList(data)">X</div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";
export default {
  name: "TasksLists",
  data() {
    return {
      isModify: true,
    };
  },
  props: {
    isOpen: Boolean,
  },
  computed: {
    ...mapState(["todoData"]),
  },
  methods: {
    notModify() {
      alert("이미 완료된 일정은 수정할 수 없습니다.");
    },
    checking(i) {
      this.todoData[i].checked = !this.todoData[i].checked;
    },
    deleteList(d) {
      if (confirm(d.content + "을(를) 삭제하시겠습니까?")) {
        let newLists = this.todoData.filter((e) => e.id !== d.id);
        for (let i in newLists) {
          newLists[i].id = i;
        }
        this.$store.commit("changeLists", newLists);
      }
    },
  },
};
</script>