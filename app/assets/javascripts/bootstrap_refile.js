$(document).on("upload:start", "input[type=file]", function(e) {
  var refileUploadContainer = $(this).closest(".refile-upload");

  $(this).closest("form").find("input[type=submit]").attr("disabled", true);
  //refileUploadContainer.find('.progress').css('opacity', 1);
});

$(document).on("upload:progress", "input[type=file]", function(e) {
  var refileUploadContainer = $(this).closest(".refile-upload");

  var detail = e.originalEvent.detail;
  var progress = Math.round(detail.loaded / detail.total * 100);
  var progressBar = refileUploadContainer.find('.progress-bar');
  progressBar.css('width', progress + '%');
  progressBar.attr('aria-valuenow', progress);
  progressBar.find('.sr-only').text(progress + '% Complete');
});

$(document).on("upload:complete", "input[type=file]", function(e) {
  var refileUploadContainer = $(this).closest(".refile-upload");

  if(!refileUploadContainer.find("input.uploading").length) {
    $(this).closest("form").find("input[type=submit]").removeAttr("disabled");
    var progressBar = refileUploadContainer.find('.progress-bar');
    progressBar.css('width', '0%');
    progressBar.attr('aria-valuenow', 0);
    progressBar.find('.sr-only').text('0% Complete');
    //refileUploadContainer.find('.progress').css('opacity', 0);
  }
});

$(document).on("change", "input[type=file]", function() {
  fileIcons = {
    'default': 'fa-file-o',
    'pdf': 'fa-file-pdf-o',
    'xls': 'fa-file-excel-o',
    'xlsx': 'fa-file-excel-o',
    'csv': 'fa-file-excel-o',
    'doc': 'fa-file-word-o',
    'docx': 'fa-file-word-o',
    'jpg': 'fa-file-image-o',
    'jpeg': 'fa-file-image-o',
    'png': 'fa-file-image-o',
    'gif': 'fa-file-image-o'
  }

  if (this.files.length == 0) return;

  var refileUploadContainer = $(this).closest(".refile-upload");
  var fileName = this.files[0].name;
  var fileExt = fileName.split('.').pop().toLowerCase();
  var attachmentIcon = (fileIcons[fileExt])? fileIcons[fileExt] : fileIcons['default']

  refileUploadContainer.addClass('filled').addClass((fileExt != '')? 'filled-type-' + fileExt : '');
  refileUploadContainer.find('.file-info').html('<i class="fa ' + attachmentIcon + '"></i> ' + fileName);

  var reader = new FileReader();
  reader.onload = function (e) { refileUploadContainer.find("img.preview").attr("src", e.target.result); };
  reader.readAsDataURL(this.files[0]);
});