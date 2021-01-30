let identity: 'a. 'a => 'a = {
  a => a;
};

let complement = (f: 'a => bool): ('a => bool) => {
  x => !f(x);
};
