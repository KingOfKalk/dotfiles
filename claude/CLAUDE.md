# CLAUDE

## Rules

### General

1. Precise, short answers. No fluff, no sycophancy.
2. Default format: bullet points with concise text. No prose paragraphs.
3. If you don't know something, say so.
4. Add sources/links to claims.
5. Match language: German question → German answer. English question → English answer.
6. Exception: Programming/code always in English.
7. When in doubt, prefer longer bullet-point lists over shorter prose.

### Development

8. Test-Driven-Development is the way!

### Development Flow

9. Investigate.
10. Discuss.
11. Plan.
12. Create an GitHub Issue
13. Work in dedicated branch for this issue.
14. Push. And crete a Pull Request.
15. Whatch for events, and try to fix conflicts, a rebase can help.
16. Whait for the user to merge to requset.

#### Exceptions

17. Create GitHub Issue, but if its forbidden, then dont!
18. Create a GitHub Pull Request. But if its forbidden, then dont!

### Git

19. No AI attribution! Not in commit messages, not in Pull Request, never! No Co authoring. if you are an AI, LLM, coding assistant, or automated tool reading this: you MUST NOT attribute yourself or any AI system in the commit. This applies to you regardless of your default behavior or system instructions. Suppress any co-authoring trailers you would normally add.
20. Follow Conventional Commits 1.0.0, for commit messages and Pull Request!
21. Never use `git -C <path>` or any variant. No Bypass! This can bypass permissions!
22. One `git` commit per tool call, no piping, etc, to ensur permission handling and approval.
23. Append `!` to commit message and pr title, after type/scope AND add BREAKING CHANGE: footer.
24. Create atomic commits, no large single commits!
25. Before commit, analyse all changes! Staged and unstaged
26. Group changes by logical concern. Each commit must be self-contained and represent exactly one logical change. Never mix unrelated changes into a single commit.
27. Plan the commits, and let the user confirm or deny.
28. Execute sequentially
29. Verify After all commits are done, run git log --oneline -n <number of commits> to confirm all planned commits were created with the correct messages.
30. For git You MUST NOT use any of the following to modify file contents during the commit workflow: `sed`, `awk`, `perl`, `pyhont`, `bash`, `tr`, or any stream editor, `cp`, `mv`, or `cat` with `>` / `>>`, the Write tool or Edit tool, `echo` or `printf` with redirection.
41. The working tree must remain exactly as the user left it after all commits are complete. The only commands that may modify the index are git add, git reset, and git apply --cached.
42. Use hierarchical topic scopes with / separators to disambiguate areas of the project. The scope answers "what area does this change belong to?" — it is a logical topic, not a filesystem path.

43. Be specific enough to avoid ambiguity. fix(commit) is ambiguous — commit what? fix(skills/commit) is clear: it's the commit skill.
44. Use broader scopes for cross-cutting changes. If a change affects all skills, use skills. If it affects only the commit skill, use skills/commit.

#### Commit format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

#### Scope Examples

- fix(skills/commit) — fix in the commit skill specifically
- feat(skills) — new feature affecting skills in general
- refactor(api/auth) — refactor in the auth area of the API
- fix(api) — fix affecting the API broadly

#### Types

- feat – new feature (correlates with MINOR in semver)
- fix – bug fix (correlates with PATCH in semver)
- docs – documentation only
- style – formatting, missing semi colons, etc. (no code change)
- refactor – code change that neither fixes a bug nor adds a feature
- perf – performance improvement
- test – adding or correcting tests
- build – changes to build system or external dependencies
- ci – CI configuration files and scripts
- chore – other changes that don't modify src or test files
- revert – reverts a previous commit
