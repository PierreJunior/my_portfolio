# my_portfolio — notes for Claude Code

## Git workflow

After making code changes, stop and show the diff/summary for review.
Do **not** run `git commit` or `git push` unless the user explicitly
asks for it in that moment — even if a task's instructions say to
"commit and push" as a default step. The user sometimes reviews and
commits/pushes manually themselves, so don't assume that's always
Claude's job just because a change was approved.
