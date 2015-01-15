class Profile < ActiveRecord::Base
  belongs_to :user

  COUNTRIES = [['Ukraine', 'Ukraine'], ['Russian', 'Russian'], ['USA', 'USA'], ['Japan', 'Japan'], ['China', 'China'], ['Kazakhstan', 'Kazakhstan'], ['Poland', 'Poland'], ['Korea', 'Korea'], ['Canada', 'Canada'], ['Mexico', 'Mexico']]
  SEX = [['Man', 'Man'], ['Woman', 'Woman']]
end
