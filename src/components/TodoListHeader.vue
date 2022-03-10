<template>
  <div class="todolist-header" @click="getTime()">
    <h1>{{ this.today }} 일정</h1>
    <div class="day">오늘은 {{ this.week }}</div>
    <div class="tasks-left">
      오늘 할 일 {{ totalCheckedNum.length }}개 남았음
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";
export default {
  name: "TodolistHeader",
  data() {
    return {
      today: "",
      week: "",
    };
  },
  created() {
    this.getTime();
  },
  computed: {
    ...mapState(["todoData"]),
    totalCheckedNum() {
      return this.todoData.filter((e) => e.checked == false);
    },
  },
  methods: {
    getTime() {
      const moment = require("moment");
      this.today = moment().format("YYYY년 MM월 DD일");
      this.week = moment().locale("ko").format("dddd");
    },
  },
};
</script>

<style>
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
</style>
