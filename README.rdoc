== Keating-Test

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