SELECT clientes.nombre,clientes.primApellido,clientes.email,pais.nombre,clientes.cliente_frecuente
FROM clientes
INNER JOIN pais on pais.idPais = clientes.idPais
WHERE clientes.cliente_frecuente = 'TRUE';


SELECT venta.fechaEmision,venta.statusVenta,clientes.nombre,producto.nombre,colaborador.nombre
FROM venta
INNER JOIN clientes on clientes.idCliente = venta.idCliente
INNER JOIN colaborador on colaborador.idColaborador = venta.idColaborador

