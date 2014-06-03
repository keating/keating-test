

**1**

Because I use `Thread` to test the with method of payment.rb

So we should change the configuration in spec_helper.rb
```
config.use_transactional_fixtures = false
```
This is very important, otherwise the tests with thread will not be passed.

**2**

I have uploaded the whole project to

https://github.com/keating/keating-test

**3**

There are some approaches for the third task,

1.

> The default transaction isolation level for postgresql is read committed, but we can change it to read repeatable. So we will not need any lock.

2.

> Pessimistic Locking

3.

> Optimistic Locking

I prefer to use `Optimistic Locking` here.
