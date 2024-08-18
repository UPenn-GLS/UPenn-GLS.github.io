module Jekyll
  class YearlyPageGenerator < Generator
    safe true

    def generate(site)
      years = site.collections["talks"].docs.map { |talk| talk.data["year"] }.uniq

      years.each do |year|
        site.pages << YearlyPage.new(site, site.source, File.join("talks", year.to_s), year)
      end
    end
  end

  class YearlyPage < Page
    def initialize(site, base, dir, year)
      @site = site
      @base = base
      @dir = dir
      @name = "index.html"

      self.process(@name)
      self.read_yaml(File.join(base, "_layouts"), "yearly_archive.html")
      self.data["year"] = year
      self.data["title"] = "Talks for #{year}"
    end
  end
end
