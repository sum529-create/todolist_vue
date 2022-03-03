import { createStore } from "vuex";
import todoData from "./assets/todoData";

const store = createStore({
  state() {
    return {
      todoData,
    };
  },
  mutations: {
    changeLists(state, payload) {
      state.todoData = payload;
    },
  },
});

export default store;
