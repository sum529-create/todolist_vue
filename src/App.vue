<template>
  <div class="todolist-template">
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
/* body {
  background: rgb(44, 44, 44);
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto", "Oxygen",
    "Ubuntu", "Cantarell", "Fira Sans", "Droid Sans", "Helvetica Neue",
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.todolist-template {
  width: 512px;
  height: 768px;
  position: relative;
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 0 8px rgb(0 0 0 / 4%);
  margin: 0 auto;
  margin-top: 96px;
  margin-bottom: 32px;
  display: flex;
  flex-direction: column;
}
.add-icon {
  border-radius: 50%;
  border: none;
  box-shadow: 1px 2px 3px gray;
  position: absolute;
  background: rgb(190, 56, 56);
  cursor: pointer;
  width: 80px;
  height: 80px;
  display: block;
  align-items: center;
  justify-content: center;
  left: 43%;
  bottom: -34px;
  outline: none;
  color: #fff;
  font-size: 60px;
} */
</style>
