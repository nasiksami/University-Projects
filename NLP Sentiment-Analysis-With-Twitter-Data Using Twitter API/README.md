<h3># Sentiment-Analysis-With-Twitter-Data</h3>


I’ll start by stating what I want this program to do. This program will analyze the sentiment of a Twitter account. More specifically, it’ll analyze the tweets/posts of one of Microsoft founders, Bill Gates

<h3>Import The Libraries and Packages:</h3>

Then I will use Google’s website to write this program, so I’ll be using Google’s library to upload the CSV file that contains my Twitter app keys. You can just input your keys directly into the variables if you want.

Next, I’ll store the Twitter keys/API credentials in variables.

Now, it’s time to create the authentication object. Set the access token and access token secret, and authenticate to Twitter.

<h3>Extract and Analyze the Data:</h3> 
It’s time to extract the tweets of a Twitter user. First, I’ll get the last 100 posts for the Twitter user Bill Gates and show only the five most recent tweets.

Create a DataFrame with a column called Tweets that’ll contain the posts from the Twitter user, and then show the first five rows.

The data is a little dirty because it contains the @ symbol, hyperlinks, RTs, and may contain hash tags, so I’ll clean it up by creating a function to remove these symbols from the tweets. Then, I’ll apply that function to the tweets and show the results.

I want to add the tweets’ subjectivity and polarity to the DataFrame. In order to do this, I’ll create two functions: one to get the tweets called Subjectivity (how subjective or opinionated the text is — a score of 0 is fact, and a score of +1 is very much an opinion) and the other to get the tweets called Polarity (how positive or negative the text is, — score of -1 is the highest negative score, and a score of +1 is the highest positive score).
Next I’ll store the results into two columns — one called Subjectivity and the other called Polarity — and show the results.

Let’s see how well the sentiments are distributed. A good way to accomplish this task is by understanding the common words by plotting word clouds.
A word cloud (also known as text clouds or tag clouds) is a visualization, the more a specific word appears in the text, the bigger and bolder it appears in the word cloud.
Let’s visualize all the words in the data using the word-cloud plot. It looks like the word “health” appears a lot in Bill Gates past 100 tweets.

Create a function to compute the negative (-1), neutral (0), and positive (+1) analysis, and add the information to a new column called Analysis. Then, show the results.

If you’re also interested in reading more on machine learning to immediately get started with problems and examples, then I strongly recommend you check out “Hands-on Machine Learning with Scikit-Learn and TensorFlow: Concepts, Tools, and Techniques to Build Intelligent Systems.”
It’s a great book for helping beginners learn how to write machine learning programs and for understanding machine learning concepts.
Thanks for reading this article. I hope it’s helpful to you all!

