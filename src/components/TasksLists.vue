<template>
  <div class="task-list" :style="{ height: isOpen ? '325px' : '500px' }">
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
        @click="$emit('modify', data, isModify)"
      >
        {{ data.content }}
      </div>
      <div
        class="tasks-delete"
        :style="{ display: data.checked === true ? 'block' : 'none' }"
        @click="deleteList(data)"
      >
        X
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
      checkednum: "",
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
    checking(i) {
      this.todoData[i].checked = !this.todoData[i].checked;
      this.checkednum = this.todoData.filter((e) => e.checked == true);
      this.$emit("checkednum", this.checkednum);
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

<style>
.task-list {
  overflow-y: scroll;
  height: 325px;
}
.tasks {
  display: flex;
  align-items: center;
  padding-top: 12px;
  padding-bottom: 12px;
}
.tasks > .tasks-check {
  width: 32px;
  height: 32px;
  font-size: 32px;
  display: flex;
  margin-right: 10px;
  cursor: pointer;
  align-items: center;
  justify-content: center;
}
.tasks > .tasks-check.checked {
  color: rgb(219, 102, 119);
}
.tasks > .tasks-item {
  flex: 1;
  cursor: pointer;
}
.tasks > .tasks-delete {
  cursor: pointer;
  padding: 0 10px;
}
.tasks > .tasks-done {
  text-decoration: line-through;
  color: #cecece;
}
</style>
