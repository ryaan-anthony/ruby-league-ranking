Ruby League Ranking
===========================================

[![CircleCI](https://circleci.com/gh/ryaan-anthony/ruby-league-ranking/tree/master.svg?style=svg)](https://circleci.com/gh/ryaan-anthony/ruby-league-ranking/tree/master)

Example usage
---------
`rake league_ranking:calculate < sample-input.txt` 

Run Tests
---------
`rake league_ranking:test`

The rules
---------
In this league, a draw (tie) is worth 1 point and a win is worth 3 points. A
loss is worth 0 points. If two or more teams have the same number of points,
they should have the same rank and be printed in alphabetical order (as in the
tie for 3rd place in the sample data).
