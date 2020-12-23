# Garter

ReScript의 표준 라이브러리라 할 수 있는 Belt는 아직 충분히 성숙하지 않아 필수 유틸리티 함수가 많이 부족합니다.
Garter는 Belt 라이브러리의 부족한 부분을 보완하는 확장 라이브러리입니다.

하스켈 Prelude가 레퍼런스가 된다는 점에서 [reazen/relude](https://github.com/reazen/relude/tree/master/src)와 지향점이 비슷합니다.
다른점은 아래와 같습니다.

1. 우리 내부의 필요에 의해서만 확장한다.
2. OCaml을 고려하지 않는다.
3. Pipe First 문법을 사용한다.
