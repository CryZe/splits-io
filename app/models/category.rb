class Category < ActiveRecord::Base
  belongs_to :game, touch: true
  has_many :runs

  before_create :autodetect_shortname
  after_touch :destroy, if: Proc.new { |category| category.runs.unscoped.count.zero? }

  def best_known_run
    runs.where("time != 0").order(:time).first
  end

  def to_s
    name
  end

  def to_param
    id.to_s
  end

  def autodetect_shortname
    shortname = {
      "any%" => "anypct",
      "100%" => "100pct",
    }[name.try(:downcase)]
  end

  def shortname
    name.downcase.gsub(/ *%/, 'pct').gsub(/ +/, "-")
  end

  def popular?
    runs.unscoped.count * 10 >= game.runs.unscoped.count
  end
end
