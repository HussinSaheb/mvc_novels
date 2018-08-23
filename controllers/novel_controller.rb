class NovelController < Sinatra::Base
  # sets the root as the parent directory of the current File
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly.
  set :views, Proc.new{File.join(root,'views')}

 # add this line to setup the reloader
  configure :development do
    register Sinatra::Reloader
  end

# a hard coded array of hashs
  $novel_chapters = [{
    "id": 0,
    "chapter_number": 1,
    "title": "Chapter 1",
    "chapter_body": "The State of Zhao was a very small nation [1. The State of Zhao is named after the historical State of Zhao]. Like other small nations in the lands of South Heaven, its people admired the Great Tang [2. The Great Tang is named after the historical Tang Dynasty] in the Eastern Lands, and they admired Chang’an [3. Chang'an is named after the historical Chinese city Chang'an]. Not only did the king carry this admiration, all scholars in the State of Zhao did. They could see it, almost as if they stood atop the Tower of Tang in the capital city, oh so far away.This April was neither extremely cold, nor scorching hot."
  },
  {
    "id": 1,
    "chapter_number": 2,
    "title": "Chapter 2",
    "chapter_body": "this is chapter 2"
  },
  {
    "id": 2,
    "chapter_number": 3,
    "title": "Chapter 3",
    "chapter_body": "this is chapter 3"
  },
  {
    "id": 3,
    "chapter_number": 4,
    "title": "chapter 4",
    "chapter_body": "this is chapter 4"
  }]
 #  set title to novel title
  get '/' do
    @title = "Novel Title"
    # pass the array to the chapter variable
    @chapters = $novel_chapters
    # show the index view erv
    erb :'novels/index'
  end
  # a new chapter has a title of new chapter
  get '/new' do
    @title = "New chapter"
    @chapter = {
      # fields are empty just to display empty form
      id: '',
      chapter_number: '',
      title: '',
      chapter_body: ''
    }
    erb :'novels/new'
  end

  post '/' do
    # create new object
    new_chapter = {
      # gather required information
      id: $novel_chapters.length(),
      chapter_number: params[:chapter_number].to_i,
      title: params[:title],
      chapter_body: params[:chapter_body]
    }
    # add it to array of hash
    $novel_chapters.push(new_chapter)
    redirect "/"
  end


  get '/:id' do
    # get the id
    id = params[:id].to_i
    @chapter = $novel_chapters[id]
    # display the show view
    erb :'novels/show'
  end
  # set title to edit chapter
  get '/:id/edit' do
    @title= "Edit Chapter"
    # get the id
    id = params[:id].to_i
    # use the id to access the right chapter
    @chapter = $novel_chapters[id]
    erb :'novels/edit'
  end
  # update a current chapter
  put '/:id' do
    #  get the id
    id = params[:id].to_i
    #  access the specific id chapter
    chapter = $novel_chapters[id]
    # set the new objects title field to be the paramater title
    chapter[:title] = params[:title]
    chapter[:chapter_body] = params[:chapter_body]
    # pass back the chapter into the same id we accessed earlier
    $novel_chapters[id] = chapter
    redirect "/"
  end
# remove a chapter
  delete '/:id' do
    id = params[:id].to_i
    # deletes at the index which is the id
    $novel_chapters.delete_at(id)
    redirect "/"
  end
end
