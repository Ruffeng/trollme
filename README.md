# Trollme
How many of us we work in an office, and spend 8 daily hours with our colleagues? How many time did we see their screens unlocked, tempted to apply some changes on their laptops?

That's the purpose of **Trollme**. Basically is a gem to prank people changing their Desktop Background. You can choose among 6 topics, or just make it random if you prefer. 

As well is important to say that right now it just works with Mac. I know it's not 100% fair that it's just supported by one OS. But 90% of my colleagues are working with Mac and the idea of this gem is to prank them... In the future, I can try to arrange it.
**Why do I want to do that?**

Just looking to prank some people in a funny and inoffensive way. At the end we teach them to lock their screens and help the enterprise to apply the ISO Quality Management, don't we?

![time to troll!](https://media.giphy.com/media/q8pghZNgAQ0rm/giphy.gif)
## Installation
Is quite easy:

 ` gem install trollme`

Then in your command line terminal, you just have to invoke it
`$ trollme`

In case you want to select one topic, here is the list you can use:
```sh
- dogs
- horror
- memes
- nerds
- cats
- sweet
```

To make it work you just have to specify the topic. Example:
`$ trollme cats`
In case you insert a wrong topic or one is not in the list, automatically will fall into random.

Or if you are a Rails developer and you want to super troll them, just hide it in your gemfile
`gem 'trollme'`
now just wait until they leave the screen unlocked and just run the command line statement. Cool :)

### Other uses
Another use for this gem, is to fork the project, change the YAML file ( just need to respec the format ), and sync with a cronjob. You can have an automated background changer for everyday with the images you want.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ruffeng/trollme.

## TODO
- [x] Create categories in a YAML file
- [x] Upload pictures in Cloudinary
- [x] Let the user choose a category
[ ] Generate meme text if a text is sent
[ ] Change Background depending on their OS

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
