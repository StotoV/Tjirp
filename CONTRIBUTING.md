# How to contribute

First of all, thanks for taking the time to contribute to this project! On this page you will find everything you need to get started working on this project.

## Submitting changes
Please add a clear description to every pull request containing what you have done and it's impact. As for commits, make sure they are atomic (one feature per commit) and write clear commit descriptions. One-line commit descriptions are fine for small changes, but bigger changes should look as following:

```
  $ git commit -m "A brief summary of the commit
  > 
  > A paragraph describing what changed and its impact."
```

## Did you find a bug?
 * Before you create an issue, check if the bug is **already reported**
 * If not already reported create an issue. Make sure it incluedes an **title** and **clear description**, and as much relevant information as possible. Also include an **executable test case** that demonstrates the unexpected behaviour.
 

## Did you write a patch that fixes a bug?
 * Open a new GitHub pull request with the patch.
 * Make sure the pull request contains an clear description of the problem and the solution. Inlcude the issue number if applicable.
 * Check if the patch is conform the [code of conduct](CODE_OF_CONDUCT.md)
 
## Do you intend to add a new feature or change an existing one?
 * Fork this project and start writing code, be aware that this has to be conform the [code of conduct](CODE_OF_CONDUCT.md)
 * Create a pull request that contains a **clear description** of the new functionality
 
## Code conventions
When you start reading our code you will get the hang of it. Our main goal here is readability.

 * We indent using one tab
 * We ALWAYS put spaces after list items and method parameters ([1, 2, 3], not [1,2,3]), around operators (x += 1, not x+=1), and around hash arrows.
 * We open the brackets of a function or class on the **same line** like so:
  ```
  function myFunction() {
  ```
 
Thanks! ❤️
