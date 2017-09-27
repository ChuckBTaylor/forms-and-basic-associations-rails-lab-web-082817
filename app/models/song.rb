class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name
    self.artist.try(:name)
  end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def genre_id=(genre_id)
    self.genre = Genre.find_or_create_by(id: genre_id)
  end

  def genre_id
    self.genre.try(:id)
  end

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    self.genre.name
  end

  def note_contents=(contents)
    contents.reject! do |content|
      content.size == 0
    end
    if contents
      contents.each do |content|
        note = Note.create(content:content)
        self.notes << note
      end
    end
  end

  def note_contents
    self.notes.map do |note|
      note.content
    end
  end


end
