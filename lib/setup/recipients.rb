module Setup
  module Recipients

    extend self

    def pick_recipient
      index = (0..9).to_a.sample
      names[index] + '@' + companies[index] + '.com'
    end

    private

    def names
      %w[
        billy
        timmy
        sammy
        johnny
        tommy
        bobby
        cathy
        ally
        teddy
        eddy
      ]
    end

    def companies
      %w[
        apple
        microsoft
        facebook
        google
        tesla
        linkedin
        twitter
        spacex
        instagram
        checkrecipient
      ]
    end

  end
end