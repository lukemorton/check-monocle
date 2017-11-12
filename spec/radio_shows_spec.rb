describe 'Radio Shows' do
  shared_examples_for 'latest show' do
    example 'Latest show is valid' do
      visit radio_show_url(show)
      latest_show_link.click
      assert_page_has_title
      assert_page_has_hero
      assert_page_has_description
      assert_if_page_has_chapters_that_they_are_valid
    end
  end

  shared_examples_for 'soon to be released show' do
    example 'Soon to be released show is valid' do |example|
      skip 'Do not run on Monday' if Time.now.monday? and !example.metadata[:monday]
      skip 'Do not run on Tuesday' if Time.now.tuesday? and !example.metadata[:tuesday]
      skip 'Do not run on Wednesday' if Time.now.wednesday? and !example.metadata[:wednesday]
      skip 'Do not run on Thursday' if Time.now.thursday? and !example.metadata[:thursday]
      skip 'Do not run on Friday' if Time.now.friday? and !example.metadata[:friday]
      skip 'Do not run on Saturday' if Time.now.saturday? and !example.metadata[:saturday]
      skip 'Do not run on Sunday' if Time.now.sunday?

      visit radio_show_url(show)
      visit next_show_url
      assert_page_has_title
      assert_page_has_hero
      assert_page_has_description
      assert_if_page_has_chapters_that_they_are_valid
    end
  end

  context 'Culture with Robert Bound', monday: true do
    let(:show) { 'culture-with-robert-bound' }
    let(:default_description) { 'Our Culture editor and his guests discuss' }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'Section D', tuesday: true do
    let(:show) { 'section-d' }
    let(:default_description) { 'Everything you need to know about the world of' }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Entrepreneurs', wednesday: true do
    let(:show) { 'the-entrepreneurs' }
    let(:default_description) { 'Monocle 24’s weekly tour of the most inspiring' }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Urbanist', thursday: true do
    let(:show) { 'the-urbanist' }
    let(:default_description) { 'With an influential audience of city mayors' }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Sessions', friday: true do
    let(:show) { 'the-sessions-at-midori-house' }
    let(:default_description) { 'Our standalone home of live music presented' }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Menu', friday: true do
    let(:show) { 'the-menu' }
    let(:default_description) { 'Our guide to the world of food, drink' }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Curator', friday: true do
    let(:show) { 'the-curator' }
    let(:default_description) { 'The best of the week on Monocle 24' }

    example 'Latest show is valid' do
      visit radio_show_url(show)
      latest_show_link.click
      assert_page_has_title
      assert_page_has_description
    end

    example 'Soon to be released show is valid' do
      skip 'Only run on Friday' unless Time.now.friday?
      visit radio_show_url(show)
      visit next_show_url
      assert_page_has_title
      assert_page_has_description
    end
  end

  context 'The Stack', friday: true do
    let(:show) { 'the-stack' }
    let(:default_description) { 'Essential listening for anyone who cares about' }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Foreign Desk', friday: true do
    let(:show) { 'the-foreign-desk' }
    let(:default_description) { 'flagship global-affairs show featuring interviews' }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'Meet the Writers', friday: true do
    let(:show) { 'meet-the-writers' }
    let(:default_description) { 'Want to know more about the authors behind' }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Monocle Weekly', saturday: true do
    let(:show) { 'the-monocle-weekly' }
    let(:default_description) { 'Want to hear from the authors, artists, creative' }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Bulletin with UBS', saturday: true do
    let(:show) { 'the-bulletin-with-ubs' }
    let(:default_description) { 'Delivering insights into the people, places' }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  def latest_show_link
    page.first('.tb_icon .icon.episode:not(.star)').find(:xpath, '../../..').find('.tb_desc a')
  end

  # Based on current URL, we guess the next show URL by incrementing the ID
  # found in the current URL.
  #
  # Example:
  #
  #   https://monocle.com/radio/shows/the-urbanist/318/
  #
  #   becomes:
  #
  #   https://monocle.com/radio/shows/the-urbanist/319/
  #
  def next_show_url
    show_number = latest_show_link['href'].scan(/\/(\d+)\//)[0][0]
    next_show_number = show_number.to_i.next.to_s
    latest_show_link['href'].sub(show_number, next_show_number)
  end

  # We assert the the <h1> content is found and used in <title>
  #
  def assert_page_has_title
    expect(page.title).to_not start_with('The Urbanist')
    expect(page.title).to include(page.find('h1').text)
  end

  def assert_page_has_hero
    hero_style_attr = page.find('.radio-hero')['style']
    expect(hero_style_attr).to_not include('generic-episode-photo')
    expect(hero_style_attr).to match(/jpg|jpeg/)
  end

  def assert_page_has_description
    expect(page.first('.meta-summary').text).to_not eq(default_description)
  end

  def assert_if_page_has_chapters_that_they_are_valid
    page.all('.radio__title--chapter h3').each do |title|
      expect(title.text).to_not be_empty
    end

    page.all('.radio__title--chapter + p').each do |paragraph|
      expect(paragraph.text).to_not be_empty
    end
  end
end
