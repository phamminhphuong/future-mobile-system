$(document).ready(function() {
  $('#product_images_attributes_0_image_link').bind('change', function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert(I18n.t('error_image'));
    }
  });
});
