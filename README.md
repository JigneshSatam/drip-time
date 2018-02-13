# Drip Time


This is a sample application. It contains three models:

1. Exporter
2. Insurance
3. Analytic

### Problem Statement
* Add a feature to track creation, deletion and changes inside the models' objects.   
* For instance, an `Exporter` should create an entry and full snapshot of all it's values when it's created.
```ruby
e = Exporter.create(name: 'Ankur', email: 'foobar@foobar.com', password: 'foobar', password_confirmation: 'foobar')
e.reload.archived #=> [one ArchivedExporter object] [1]
e.archived.first.model_action #=> create
e.update_attribute :name, 'FooBar'
e.reload.archived #=> [two or more ArchivedExporter objects] [2]
e.archived.last.model_action #=> update
e.password = e.password_confirmation = 'newpassword'; e.save
e.reload.archived #=> should be same as [2]
e.destroy
e.archived.reload.last.action #=> 'destroy'
```
* By _full snaphot_, we mean that object should contain all the attributes of the object at that point of time. 
* `Exporter` and `Insurance` attributes need to be tracked. Name of attributes to be tracked is mentioned in models. `Analytic` does not need to be tracked.
* API should be flexible, we should be able to control what attributes we want to track.
* Bonus points, if your system allows data to be queried (via SQL). For example, get the data from archived exporters before 1st Jan 2018 when name changed from 'Ankur' to 'FooBar' and some other attributed changed from x to y.

### Good to have
* If new columns are added, existing columns are removed, think and implement/suggest how your solution will adopt.
* How does your solution scale when new models are added?
* Optimizations thinking Ruby/Rails and performance in point of view.   

### Submission
* Clone this project and submit your solution as a **zip** file.
* Mention additional `rails` / `rake` commands which are necessary to support your changes.
* Example snippets like above should work.
* If you wish, you can also add submission notes below discussing your approach and challenges faced.

### Submission notes:
