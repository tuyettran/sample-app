$(document).ready(function(){
  $('#micropost_picture').change(function(){
    var size_in_megabytes = this.files[0].size;
    if (size_in_megabytes > 5) {
      alert(I18n.t("microposts.create.too_big_file"));
    }
  });
})
