<template>
  <div class="todolist-header" @click="getTime()">
    <h1>{{ this.today }} 일정</h1>
    <div class="day">오늘은 {{ this.week }}</div>
    <div class="tasks-left">
      오늘 할 일 {{ totalCheckedNum.length }}개 남았음
    </div>
    <p class="infoText">※ 수정 시 해당 리스트 항목을 클릭해주세요.</p>
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
