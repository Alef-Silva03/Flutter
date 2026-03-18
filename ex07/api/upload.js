const multer = require('multer');
const storege = multer.diskStorage({
    destination: (req,file,cb)=>{
        cb(null,'uploads/');
    },
    filename: (req,file,cb)=>{
        cb(null,Date.now() + ".jpg");
    },
});
const upload = multer({ storage : storege });
module.exports = upload;