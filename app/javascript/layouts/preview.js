$(document).on('turbolinks:load', () =>{
  $('.block-toggle__press .btn').on('click', event =>{
    $(event.currentTarget).parent('.block-toggle__press').next('.block-toggle__content').slideToggle(700);
  });
});

$(document).on('turbolinks:load', () =>{

  const imgUplorader = new ImgUplorader;
  imgUplorader.copyToSaveInput();

});

class ImgUplorader{
  constructor(){
    this.selectorPreview = '.form-image-uploader__preview';
    this.selectorSave = '.form-image-uploader__save';
    this.selectorCache = '.form-image-uploader__cache';
    this.noPhotoImgPath = '/assets/no_image.png';

  }

  copyToSaveInput(){
    $(document).on('change', this.selectorSave, event => {

      const input = $(event.currentTarget);
      const filesLength = input[0].files.length;
      const cacheDefaultVal = $(input).next(this.selectorCache)[0].defaultValue;

      if (this.hasNotImg(filesLength)) {
        this.changeNoPhotoImg(input);
        return;
      }

      this.changeSelectedImg(input);

    });
  }

  hasCacheDefaultImg(filesLength){
    if(filesLength == 0){
      return true;
    }

    return false;
  }

  /*
   * Return true when input doesn't have file
   * @param filesLength : file length of input
   * @return bool
  */
  hasNotImg(filesLength){
    if(filesLength == 0){
      return true;
    }

    return false;
  }

  changeNoPhotoImg(input){
    $(input).prev(this.selectorImg).children('img').attr('src', this.noPhotoImgPath);
  }

  changeSelectedImg(input){
    const reader = new FileReader();
    reader.onload = (progressEvent) => {
      $(input).prev(this.selectorImg).children('img').attr('src', progressEvent.currentTarget.result);
    }

    const file = input[0].files[0];
    reader.readAsDataURL(file);
  }
}
