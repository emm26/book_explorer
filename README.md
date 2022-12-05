# The Book Explorer
An app that allows for the upload of a .csv file containing information about books. The list of books is then displayed nicely in the UI.

# Demo
https://user-images.githubusercontent.com/24696150/205674553-321962c9-a67b-41b7-bde2-2eeb587a2243.mov


# Dependencies
Ruby v3.1.2 and Rails v7.0.4 were used.

In order to fully use the app, you'll need to set up environment variables related to AWS S3 (used to store the uploaded .csv files):
- ```ENV['AWS_ACCESS_KEY_ID']```
- ```ENV['AWS_REGION']```
- ```ENV['AWS_SECRET_ACCESS_KEY']```

I didn't want to expose the credentials here for obvious security concerns. You may use your own credentials by setting the above as well as ```ENV['CSV_BOOK_UPLOADS_BUCKET']``` with the name of the bucket you wish to store your .csv files at.

# Running the app
i. Apply DB migrations:
```
bin/rails db:migrate
```
ii. Run the webserver:
```bin/dev``` or ```rails s```

# Running tests
RSpec was used as testing framework. You can run tests by running the command:
```
rspec
```


