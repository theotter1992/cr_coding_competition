# CheckRecipient Engineering Challenge

## Overview

This challenge is designed so we can quickly see:

* how you approach a problem
* how you structure your code 
* your technical knowhow
* how you optimise processes

We have chosen to structure the challenge around our UploadEmail service as it presents interesting challenges and is core to our application.

## The Challenge

There are two data files in this repo: [uploads.json](https://github.com/PlutoFlume/cr_eng_challenge/blob/master/uploads.json) and [mini.json](https://github.com/PlutoFlume/cr_eng_challenge/blob/master/mini.json) (a smaller version of uploads.json for playing around with). uploads.json contains an array of uploads, where each upload contains an array of emails. An email has the structure:

* Recipients: an array of recipient email addresses
* Timestamp: the timestamp the email was sent
* Subject: a string of words making up the subject of the email

We have written a small rake task [perform_uploads.rake](https://github.com/PlutoFlume/cr_eng_challenge/blob/master/lib/tasks/perform_uploads.rake) which loops through uploads.json and calls the endpoint /api/upload_emails. Your task begins [here](https://github.com/PlutoFlume/cr_eng_challenge/blob/master/app/controllers/api_controller.rb#L7), and you should complete the challenege by:

* Designing a database schema and creating relevant migrations
* Complete the upload_emails API and save the data contained in each array of emails to the database
* Roughly document your thought process (why you did what you did, etc)

In production, we push upload_emails off to a background process, but for the purposes of this challenge please perform all of the upload logic in the web process.

Consider the objects and their relationships carefully. **The most important thing** is that the database should be designed for the common queries we perform, for example:

* Count how many emails donald.trump@us.com has been sent in the last month
* How many times donald.trump@us.com has seen the word “project” in the subject
* The number of unique subject words donald.trump@us.com has ever been sent

**HINT** -> You should keep an ongoing count of words for each recipient in the database. The count should be incremented for repeated words in the same subject. Also take a look at how the emails were generated [here](https://github.com/PlutoFlume/cr_eng_challenge/blob/master/lib/setup), this should lead you to a few optimisation ideas.

## Focus

What you should focus on:
* Optimisations (especially focussing on database interactions)
* Dry code
* Sensible design patterns

What you can ignore:
* Testing
* The Rails way!

**Healthy bit of competition:** For a bit of fun, we will run your code on an unseen dataset and benchmark you against our own engineers :)
