let appendSuffix: (array('a), 'b) => array(string) =
  (ar, suffix) => ar->(Belt.Array.map(n => {j|$n$suffix|j}));
