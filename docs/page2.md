# Page 2

## Heading yo yo yo
### Smaller heading
#### Even smaller heading
##### Tiny heading
###### Smallest possible heading

Some text let's go

Here's an iframe video
``` js
<iframe src="https://www.youtube.com/embed/LXb3EKWsInQ" allowfullscreen></iframe>
```
<iframe src="https://www.youtube.com/embed/LXb3EKWsInQ" allowfullscreen></iframe>
It didn't work very well, its so small

## mkdocs-video plugin

sh in to image

run `pip install mkdocs-video`

Exit sh

Then video is added like so
```
![type:video](https://www.youtube.com/embed/LXb3EKWsInQ)
```
![type:video](https://www.youtube.com/embed/LXb3EKWsInQ)

Some text below video, to see if it scales video height on mobile....it did not

## Responsive iframe
Let's try some responsive iframes!

```
<div class="container">
  <iframe class="responsive-iframe" src="https://www.youtube.com/embed/tgbNymZ7vqY"></iframe>
</div> 
```
<div class="container">
  <iframe class="responsive-iframe" src="https://www.youtube.com/embed/tgbNymZ7vqY"></iframe>
</div> 

Wow, responsive iframe is the way to go! Way better than even the videos plugin (at least for externally hosted files e.g. YouTube)

I had to add a css file to accomplish this, but it was easy!
See [additional-css](https://squidfunk.github.io/mkdocs-material/customization/#additional-css) and [w3 schools responsive iframe](https://www.w3schools.com/howto/howto_css_responsive_iframes.asp)