let identity: 'a. 'a => 'a = {
  a => a;
};

let complement = (f: 'a => bool): ('a => bool) => {
  x => !f(x);
};

let constantly: 'a 'b. ('a, 'b) => 'a = (a, _) => a;
