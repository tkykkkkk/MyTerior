document.addEventListener('DOMContentLoaded', () => {
  const imageUpload = document.getElementById('image-upload');

  if (imageUpload) {
    imageUpload.addEventListener('change', function(event) {
      const files = event.target.files;
      const preview = document.getElementById('image-preview');
      // プレビューをクリア
      preview.innerHTML = '';
      if (files) {
        Array.from(files).forEach(file => {
          const reader = new FileReader();
          reader.onload = (e) => {
            const img = document.createElement('img');
            img.src = e.target.result;
            img.className = 'img-thumbnail';
            img.style.maxWidth = '200px'; // プレビュー画像の最大幅を設定
            img.style.maxHeight = '200px'; // プレビュー画像の最大高さを設定
            preview.appendChild(img);
          };
          reader.readAsDataURL(file);
        });
      }
    });
  }
});