<template>
    <BookDetail :is-edit="false"></BookDetail>
</template>

<script>
  import BookDetail from "./components/BookDetail";

  import BookList from "./BookList.vue";
    export default {
        name: "AddBook",
        components: {BookDetail, BookList}
    }



</script>

<style scoped>

</style>
