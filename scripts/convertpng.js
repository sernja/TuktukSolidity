const imageToBase64 = require('image-to-base64');

// function convertimg(str) {
//     return imageToBase64(str);
// }

// console.log(convertimg('scripts/2.png'))

// export function convertimg(str)

const img_base = imageToBase64("scripts/2.png");
img_base.then(function(result) {
    console.log(result) // "Some User token"
 })