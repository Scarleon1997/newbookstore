<template>
  <BookDetail :is-edit="true"></BookDetail>
</template>

<script>
  import BookDetail from "./components/BookDetail";
  import BookList from "./BookList.vue";
    export default {
        name: "UpdateBook",
        components: {BookDetail, BookList}
    }
</script>

<style scoped>

</style>
