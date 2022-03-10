<template>
  <div class="todolist-template">
    <todo-list-header />
    <task-list :isOpen="isOpen" @modify="modify" />
    <div class="tasks-input" :style="{ display: isOpen ? 'block' : 'none' }">
      <form
        action="#"
        class="text-area"
        :style="{ background: isModify ? 'grey' : 'lightgrey' }"
      >
        <p :style="{ color: isModify ? '#FFF' : '#000' }">
          {{
            this.isModify
              ? "✔ 등록된 일정을 수정합니다."
              : "✔ 새로운 일정을 추가합니다."
          }}
        </p>
        <p
          class="infoText"
          :style="{ color: isModify ? '#F7E600' : '#E95145' }"
        >
          ※ 특수문자는 사용이 불가합니다.
        </p>
        <input
          type="text"
          placeholder="오늘 할일을 입력하여 enter하세요"
          @keydown.enter.prevent="addTodoList"
          v-model="newTodoItem"
        />
      </form>
    </div>
    <button class="add-icon" @click="inputArea()">+</button>
  </div>
</template>

<script>
import { mapState } from "vuex";
import taskList from "./components/TasksLists.vue";
import TodoListHeader from "./components/TodoListHeader.vue";
export default {
  name: "App",
  components: {
    taskList,
    TodoListHeader,
  },
  data() {
    return {
      isOpen: false,
      newTodoItem: "",
      isModify: false,
      sendData: {
        id: "",
        content: "",
        checked: false,
      },
      myData: {},
    };
  },
  computed: {
    ...mapState(["todoData"]),
  },
  methods: {
    inputArea() {
      this.isModify = false;
      this.newTodoItem = "";
      this.isOpen = !this.isOpen;
    },
    clearInput() {
      this.newTodoItem = "";
    },
    addTodoList() {
      this.sendData = {};
      //eslint-disable-next-line
      var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
      if (this.newTodoItem === "") {
        alert("오늘 할일을 입력하여 주세요");
        this.isOpen = true;
        return false;
      } else if (regExp.test(this.newTodoItem)) {
        alert("특수문자가 포함되어 있습니다.");
        this.isOpen = true;
        return false;
      } else {
        for (let i in this.todoData) {
          if (!this.isModify) this.todoData[i].id += 1;
          if (this.todoData[i].content == this.newTodoItem) {
            alert("이미 입력하신 항목이 있습니다.");
            return false;
          }
        }
        this.sendData.content = this.newTodoItem;
        this.sendData.checked = false;
        if (!this.isModify) {
          this.sendData.id = 0;
          this.todoData.unshift(this.sendData);
          this.$store.commit("changeLists", this.todoData);
          this.clearInput();
        } else {
          this.sendData.id = this.myData.id;
          let newLists = this.todoData.filter((e) => e.id !== this.myData.id);
          newLists.splice(this.myData.id, 0, this.sendData);
          this.$store.commit("changeLists", newLists);
        }
      }
      this.isOpen = false;
    },
    modify(d, m) {
      if (confirm(d.content + "을(를) 수정하시겠습니까?")) {
        this.isModify = m;
        this.isOpen = true;
        this.newTodoItem = d.content;
        this.myData = d;
      }
    },
    /*
    addTodoList() {
      this.sendData = {};
      //eslint-disable-next-line
      var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
      if (this.newTodoItem === "") {
        alert("오늘 할일을 입력하여 주세요");
        this.isOpen = true;
        return false;
      } else if (regExp.test(this.newTodoItem)) {
        alert("특수문자가 포함되어 있습니다.");
        this.isOpen = true;
        return false;
      } else {
        for (let i in this.todoData) {
          this.todoData[i].id += 1;
          if (this.todoData[i].content == this.newTodoItem) {
            alert("이미 입력하신 항목이 있습니다.");
            return false;
          }
        }
        this.sendData.id = 0;
        this.sendData.content = this.newTodoItem;
        this.todoData.unshift(this.sendData);
        this.$store.commit("changeLists", this.todoData);
        this.clearInput();
      }
      this.isOpen = false;
     },
    },
    nowModify() {
      this.sendData = {};
      //eslint-disable-next-line
      var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
      if (this.newTodoItem === "") {
        alert("오늘 할일을 입력하여 주세요");
        this.isOpen = true;
        return false;
      } else if (regExp.test(this.newTodoItem)) {
        alert("특수문자가 포함되어 있습니다.");
        this.isOpen = true;
        return false;
      } else {
        this.sendData.id = this.myData.id;
        this.sendData.content = this.newTodoItem;
        for (let i in this.todoData) {
          if (this.todoData[i].content == this.newTodoItem) {
            alert("이미 입력하신 항목이 있습니다.");
            return false;
          }
        }
        let newLists = this.todoData.filter((e) => e.id !== this.myData.id);
        newLists.splice(this.myData.id, 0, this.sendData);
        this.$store.commit("changeLists", newLists);
      }
      this.isOpen = false;
    },
    chooseMode(e) {
      if (this.isModify) {
        this.nowModify(e);
      } else {
        this.addTodoList(e);
      }
    },
    */
  },
};
</script>

<style>
body {
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
.tasks-input {
  position: absolute;
  left: 0;
  bottom: 0;
  width: 100%;
}
.tasks-input > .text-area {
  padding: 20px 20px 100px 20px;
  border-bottom-left-radius: 16px;
  border-bottom-right-radius: 16px;
  background: lightgrey;
  font-weight: bold;
}
.tasks-input > .text-area input {
  width: 100%;
  box-sizing: border-box;
  outline: none;
  padding: 10px 5px;
  border: 1px solid gray;
}
.tasks-input > .text-area > .infoText {
  font-size: 12px;
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
}
</style>
