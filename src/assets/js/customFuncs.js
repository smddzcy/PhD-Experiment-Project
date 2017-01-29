Array.prototype.random = function() {
  return this[Math.floor((Math.random() * this.length))];
};

Array.prototype.shuffle = function() {
  var m = this.length, i;
  while (m) {
    i = (Math.random() * m--) >>> 0;
    [this[m], this[i]] = [this[i], this[m]]
  }
  return this;
};
