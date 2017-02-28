module Setup
  module Subjects

    extend self

    def pick_subject
      subjects.sample
    end

    private

    def subjects
      [
        "Project Zebra - meeting update",
        "Find attached the annual report",
        "This is a really really really really really really really really really really really really really really long subject",
        "Dinner tonight?",
        "How many times do I have to tell you, stop sending misaddressed emails",
        "You didn't listen, you sent another misaddressed email, you're now fired!",
        "Have you heard about CheckRecipient?",
        "This ! subject _ has * random + punctuation =",
        "Email is dead, long live email",
        "Out of London, Paris, Berlin, San Francisco, New York, Sydney, Oslo and Tokyo - London is the place to be",
      ]
    end

  end
end