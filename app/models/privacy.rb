class Privacy
  include Mongoid::Document
  
  field :sos, :type => Integer, :default => 0    # show on searches / directory   0 - no, 1 - all, 2 - only registered users
    # By default an user don't appear on searches / directory until he/she have published art, so people that only creates
    #    an account for buy items won't appear unless they change it.
    # Applies also to the arts the user has
  field :acp, :type => Integer, :default => 2    # allow comments on profile      0 - no, 1 - ppl that follows him, 2 - all
  field :aca, :type => Integer, :default => 2    # allow comments on art          0 - no, 1 - ppl that follows him or likes that art, 2 - all
  field :mom, :type => Boolean, :default => true # mail on message                0 - no, 1 - yes
  field :mcp, :type => Boolean, :default => true # mail on comment on profile     0 - no, 1 - yes
  field :mca, :type => Boolean, :default => true # mail on comment on art         0 - no, 1 - yes
  field :mof, :type => Boolean, :default => true # mail on follow                 0 - no, 1 - yes
  field :mol, :type => Boolean, :default => true # mail on like                   0 - no, 1 - yes

  embedded_in :user
  
end
