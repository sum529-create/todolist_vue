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
import { mapState } from "vuex";
export default {
  name: "TaskInput",
  data() {
    return {
      newTodoItem: "",
      sendData: {
        id: "",
        content: "",
        checked: false,
      },
    };
  },
  props: {
    myData: Object,
    isOpen: Boolean,
    isModify: Boolean,
  },
  computed: {
    ...mapState(["todoData"]),
  },
  methods: {
    addTodoList() {
      this.sendData = {};
      //eslint-disable-next-line
      var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
      if (this.newTodoItem === "") {
        alert("오늘 할일을 입력하여 주세요");
        return false;
      } else if (regExp.test(this.newTodoItem)) {
        alert("특수문자가 포함되어 있습니다.");
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
          alert("추가되었습니다.");
          this.newTodoItem = "";
          this.$emit("close", false);
        } else {
          this.sendData.id = this.myData.id;
          let newLists = this.todoData.filter((e) => e.id !== this.myData.id);
          newLists.splice(this.myData.id, 0, this.sendData);
          this.$store.commit("changeLists", newLists);
          alert("수정되었습니다.");
          this.newTodoItem = "";
          this.$emit("close", false);
        }
      }
      this.$emit("newTodoItem", this.newTodoItem);
    },
  },
};
</script>

<style>
/* .tasks-input {
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
} */
</style>
