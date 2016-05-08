# == Schema Information
#
# Table name: places
#
#  place_id        :integer          not null, primary key
#  place_type      :string
#  prefname        :string
#  latitude        :float
#  longitude       :float
#  geom_wkt        :text
#  geom_wkt_l      :text
#  geom_wkt_a      :text
#  source          :string
#  placerefs_count :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Place < ActiveRecord::Base
  self.primary_key = 'place_id'

  has_many :placerefs
  has_many :passages, :through => :placerefs
  has_many :works, :through => :passages
  has_many :authors, :through => :works

  scope :by_passage, -> (passarray = nil) {
    placesets = []
    placearray = []
    passages = Passage.where(passage_id: passarray)
    # passages = Passage.where{passage_id >> passarray}
    passages.each do |p|
      placesets.push(p.places)
    end
    placesets.each do |arr|
      arr.each do |p|
        placearray.push(p)
      end
    end
    placearray.uniq
  }

  # auto-increment work_id
  before_create :set_id

  def set_id
    self.place_id = Place.maximum(:place_id).next
  end

  # TODO: need places in or near an area (neighborhood, e.g. 14 is Bloomsbury)
  def self.in_or_near(id)
    where {
        # geom_wkt like 'POINT%' and
        st_intersects(
          st_geomfromtext(Area.find(id).geom_poly_wkt),
          # st_buffer( (st_geomfromtext(Area.find(id).geom_poly_wkt)), 0.01),
          st_geomfromtext(geom_wkt)
        )
    }
  end

  def self.by_id(id)
    Place.find(id)
  end

end
