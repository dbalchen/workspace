/**
 * 
 */


const net = require('net');
const client = new net.Socket();

client.connect(8888, '127.0.0.1', function() {
	console.log('Connected');
});

client.on('data', function(data) {
	console.log('Received: ' + data);
	client.write('DEBIT,6085761900,10.00');
});