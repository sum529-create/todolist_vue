<template>
  <div class="todolist-template">
    <div>업데이트 작동 테스트</div>
    <todo-list-header />
    <task-list :isOpen="isOpen" @modify="modify" />
    <task-input
      :isOpen="isOpen"
      :isModify="isModify"
      :myData="myData"
      @close="close"
      ref="taskInput"
    />
    <button class="add-icon" @click="inputArea()">+</button>
  </div>
</template>

<script>
import { mapState } from "vuex";
import TaskInput from "./components/TaskInput.vue";
import taskList from "./components/TasksLists.vue";
import TodoListHeader from "./components/TodoListHeader.vue";
export default {
  name: "App",
  components: {
    taskList,
    TodoListHeader,
    TaskInput,
  },
  data() {
    return {
      myData: {},
      isModify: false,
      isOpen: false,
    };
  },
  computed: {
    ...mapState(["todoData"]),
  },
  methods: {
    inputArea() {
      this.isModify = false;
      this.isOpen = !this.isOpen;
    },
    modify(d, m) {
      if (confirm(d.content + "을(를) 수정하시겠습니까?")) {
        this.isModify = m;
        this.isOpen = true;
        this.$refs.taskInput.newTodoItem = d.content;
        this.myData = d;
      }
    },
    close(d) {
      this.isOpen = d;
    },
  },
};
</script>

<style>
@import "./assets/css/common.css";
</style>
