$(document).ready(function(){
  $('#micropost_picture').change(function(){
    var maximum_picture = $('#new_micropost').data('max_size');
    var size_in_megabytes = this.files[0].size;
    if (size_in_megabytes > maximum_picture) {
      alert(I18n.t("microposts.create.too_big_file"));
    }
  });
})
