const router = require('express').Router();
const upload = require('../upload');
const controller = require('../controllers/produtosController');

router.get('/', controller.listar);
router.post('/', upload.single('imagem'), controller.create);
router.put('/', upload.single('imagem'), controller.update);
router.delete('/', controller.delete);

module.exports = router;