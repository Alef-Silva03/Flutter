const db = require('../db');

// Criar pedido
exports.create = (req, res) => {
  const { usuario_id, total, itens } = req.body;

  // Adiciona o campo status e data
  const sqlPedido = `
    INSERT INTO pedidos (usuario_id, total, status, data_pedido) 
    VALUES (?, ?, 'PENDENTE', NOW())
  `;

  db.query(sqlPedido, [usuario_id, total], (err, result) => {
    if (err) return res.status(500).json(err);

    const pedidoId = result.insertId;

    itens.forEach(item => {
      db.query(
        "INSERT INTO pedido_itens (pedido_id, produto_id, quantidade, preco) VALUES (?,?,?,?)",
        [pedidoId, item.produto_id, item.quantidade, item.preco]
      );
    });

    res.json({ message: "Pedido criado", pedidoId });
  });
};
// Listar pedidos
exports.listar = (req, res) => {
  db.query("SELECT * FROM pedidos", (err, result) => {
    if (err) return res.status(500).json(err);
    res.json(result);
  });
};

// Atualizar status do pedido
exports.atualizarStatus = (req, res) => {
  const { id } = req.params;
  const { status } = req.body;

  const sql = "UPDATE pedidos SET status = ? WHERE id = ?";
  db.query(sql, [status, id], (err, result) => {
    if (err) return res.status(500).json({ erro: err });

    res.json({ mensagem: "Status atualizado com sucesso" });
  });
};

// Deletar pedido
exports.deletar = (req, res) => {
  const { id } = req.params;

  db.query("DELETE FROM pedidos WHERE id = ?", [id], (err, result) => {
    if (err) return res.status(500).json({ erro: err });

    db.query("DELETE FROM pedido_itens WHERE pedido_id = ?", [id], (err2) => {
      if (err2) return res.status(500).json({ erro: err2 });
      res.json({ mensagem: "Pedido deletado com sucesso" });
    });
  });
};