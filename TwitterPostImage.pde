import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

Twitter twit;
ConfigurationBuilder cb = new ConfigurationBuilder();

List<Status> tweets;
File file;
int currentTweet = 0;
PImage img;
void setup() {
  size(400, 400);
  img = createImage(width, height, RGB);
  img = randomGradient();
  image(img, 0, 0);
  img.save("output.jpg");
  /////having the correct path is fondamental/////
  file = new File("/Users/yannpatrick/Documents/Processing3/TwitterPostImage/output.jpg");
  ////////////////////////////////////////////////
  cb.setOAuthConsumerKey("Vq0pTTJbVeCETRrmxmIwX4v67");
  cb.setOAuthConsumerSecret("JFhruKoNx0xomOMb5GmznuJJTyu0ZSATBWknXfVE1c9mIpVBXM");
  cb.setOAuthAccessToken("812625522689765376-gccAXyVDUiXrPP0gPG8LhOb69yn6BHy");
  cb.setOAuthAccessTokenSecret("wBNJWGtti8EgSflnDFAzoWKE7LbzCTARbXoFlMXzXneBe");

  TwitterFactory tf = new TwitterFactory(cb.build());
  twit = tf.getInstance();
  ///thread for re-tweeting///
  thread("refreshTweets");
}

void draw() {
  image(img, 0, 0);
}

void tweet() {
  ////CREATE THE IMAGE///
  img = randomGradient();
  img.save("output.jpg");
  ///////////////////////////
  try {
    StatusUpdate status = new StatusUpdate("This is a gradient sent from Processing!");
    status.setMedia(file);
    twit.updateStatus(status);
    System.out.println("Status updated");
  }
  catch (TwitterException te) {
    System.out.println("Error: "+ te.getMessage());
  }
}

void keyPressed() {
  tweet();
}


void refreshTweets() {
  while (true) {
    tweet();
    println("Updated Tweets");
    delay(3000);
  }
}

PImage randomGradient() {
  PImage img = createImage(600, 600, RGB);
  color c1 = color(random(255), random(255), random(255));
  color c2 = color(random(255), random(255), random(255));
  img.loadPixels();
  for (int y = 0; y < img.width; y++) {
    for (int x = 0; x < img.height; x++) {
      int index = x + y * img.width;
      float amp = map(index, 0, img.width * img.height, 0, 1);
      color col = lerpColor(c1, c2, amp);
      img.pixels[index] = col;
    }
  }
  img.updatePixels();
  return img;
}