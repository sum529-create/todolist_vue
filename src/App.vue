<template>
  <div class="todolist-template">
    <div class="todolist-header" @click="getTime()">
      <h1>{{ this.today }} 일정</h1>
      <div class="day">오늘은 {{ this.week }}</div>
      <div class="tasks-left">오늘 할 일 {{ checked.length }}개 남았음</div>
    </div>
    <div class="todolist-body">
      <task-list @checkednum="checkednum" :isOpen="isOpen" @modify="modify" />
    </div>
    <div class="tasks-input" :style="{ display: isOpen ? 'block' : 'none' }">
      <form action="" class="text-area">
        <input
          type="text"
          placeholder="오늘 할일을 입력하여 enter하세요"
          @keydown.enter.prevent="chooseMode"
          v-model="todayData"
        />
      </form>
    </div>
    <button class="add-icon" @click="inputArea()">+</button>
  </div>
</template>

<script>
import { mapState } from "vuex";
import taskList from "./components/TasksLists.vue";
export default {
  name: "App",
  components: {
    taskList,
  },
  data() {
    return {
      checked: "",
      isOpen: false,
      today: "",
      week: "",
      todayData: "",
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
  created() {
    this.checked = this.todoData.filter((e) => e.checked == true);
    this.getTime();
  },
  methods: {
    getTime() {
      const moment = require("moment");
      this.today = moment().format("YYYY년 MM월 DD일");
      this.week = moment().locale("ko").format("dddd");
    },
    inputArea() {
      this.isOpen = !this.isOpen;
    },
    checkednum(d) {
      this.checked = d;
    },
    addList(e) {
      //eslint-disable-next-line
      var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
      if (e.target.value === "") {
        alert("오늘 할일을 입력하여 주세요");
      } else if (regExp.test(e.target.value)) {
        alert("특수문자가 포함되어 있습니다.");
      } else {
        this.sendData.id = 0;
        this.sendData.content = e.target.value;
        for (let i in this.todoData) {
          this.todoData[i].id += 1;
          if (this.todoData[i].content == e.target.value) {
            alert("이미 입력하신 항목이 있습니다.");
            return false;
          }
        }
        this.todoData.unshift(this.sendData);
        e.target.value = "";
      }
    },
    modify(d, m) {
      this.isModify = m;
      this.isOpen = true;
      this.todayData = d.content;
      this.myData = d;
    },
    nowModify(e) {
      //eslint-disable-next-line
      var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
      if (e.target.value === "") {
        alert("오늘 할일을 입력하여 주세요");
      } else if (regExp.test(e.target.value)) {
        alert("특수문자가 포함되어 있습니다.");
      } else {
        this.sendData.id = this.myData.id;
        this.sendData.content = e.target.value;
        for (let i in this.todoData) {
          if (this.todoData[i].content == e.target.value) {
            alert("이미 입력하신 항목이 있습니다.");
            return false;
          }
        }
        let newLists = this.todoData.filter((e) => e.id !== this.myData.id);

        newLists.splice(this.myData.id, 0, this.sendData);
        this.$store.commit("changeLists", newLists);
        e.target.value = "";
      }
    },
    chooseMode(e) {
      if (this.isModify) {
        this.nowModify(e);
      } else {
        this.addList(e);
      }
    },
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
.todolist-header {
  padding: 24px 32px;
  border-bottom: 1px solid #eee;
}
.todolist-header > h1 {
  color: #000000;
  margin: 0;
}
.todolist-header > .day {
  color: rgb(35, 32, 36);
  margin-top: 8px;
  font-size: 20px;
}
.todolist-header > .tasks-left {
  margin-top: 22px;
}
.todolist-body {
  flex: 1;
  padding-top: 20px;
  padding-left: 32px;
  padding-right: 15px;
  padding-bottom: 48px;
  overflow-y: auto;
}
.tasks-input {
  position: absolute;
  left: 0;
  bottom: 0;
  width: 100%;
}
.tasks-input > .text-area {
  padding: 40px 20px 100px 20px;
  border-bottom-left-radius: 16px;
  border-bottom-right-radius: 16px;
  background: lightgrey;
}
.tasks-input > .text-area input {
  width: 100%;
  box-sizing: border-box;
  outline: none;
  padding: 10px 5px;
  border: 1px solid gray;
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
