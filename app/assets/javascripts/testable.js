function TestThis() {
	this.name = 'Vahur';
}

TestThis.prototype.hello = function() {
	return 'Hello';
};

TestThis.prototype.print = function(word) {
 	return word;
};
