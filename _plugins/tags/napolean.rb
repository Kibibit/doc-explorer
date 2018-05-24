require "jekyll-spark"

module Jekyll
  # Create your component class
  class NapoleanComponent < ComponentTag
    def template(context)
      render = %Q[
        <div class="napolean">
          <img src="https://media.giphy.com/media/9QbDWTcnq4wmc/giphy.gif">
        </div>
      ]
    end
  end
end

# Register your component with Liquid
Liquid::Template.register_tag(
  "Napolean", # Namespace your component
  Jekyll::NapoleanComponent, # Pass your newly created component class
)
