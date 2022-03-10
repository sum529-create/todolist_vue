<template>
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
      <p class="infoText" :style="{ color: isModify ? '#F7E600' : '#E95145' }">
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
</template>

<script>
export default {
  name: "TaskInput",
  data() {
    return {};
  },
};
</script>

<style>
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
</style>
