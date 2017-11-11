describe 'Radio Shows' do
  shared_examples_for 'latest show' do
    example 'Latest show is valid' do
      latest_show_link.click
      assert_page_has_title
      assert_page_has_hero
      assert_page_has_description
      assert_if_page_has_chapters_that_they_are_valid
    end
  end

  shared_examples_for 'soon to be released show' do
    example 'Soon to be released show is valid' do
      visit next_show_url
      assert_page_has_title
      assert_page_has_hero
      assert_page_has_description
      assert_if_page_has_chapters_that_they_are_valid
    end
  end

  context 'Culture with Robert Bound', monday: true do
    before { visit radio_show_url('culture-with-robert-bound') }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'Section D', tuesday: true do
    before { visit radio_show_url('section-d') }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Entrepreneurs', wednesday: true do
    before { visit radio_show_url('the-entrepreneurs') }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Urbanist', thursday: true do
    before { visit radio_show_url('the-urbanist') }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Sessions', weekend: true do
    before { visit radio_show_url('the-sessions-at-midori-house') }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Menu', weekend: true do
    before { visit radio_show_url('the-menu') }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Curator', weekend: true do
    before { visit radio_show_url('the-curator') }

    example 'Latest show is valid' do
      latest_show_link.click
      assert_page_has_title
      assert_page_has_description
    end

    example 'Soon to be released show is valid' do
      visit next_show_url
      assert_page_has_title
      assert_page_has_description
    end
  end

  context 'The Stack', weekend: true do
    before { visit radio_show_url('the-stack') }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Foreign Desk', weekend: true do
    before { visit radio_show_url('the-foreign-desk') }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'Meet the Writers', weekend: true do
    before { visit radio_show_url('meet-the-writers') }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Monocle Weekly', weekend: true do
    before { visit radio_show_url('the-monocle-weekly') }
    include_examples 'latest show'
    include_examples 'soon to be released show'
  end

  context 'The Bulletin with UBS', weekend: true do
    before { visit radio_show_url('the-bulletin-with-ubs') }
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
    next_show_url = latest_show_link['href'].sub(show_number, next_show_number)
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
    expect(page.first('.meta-summary').text).to_not eq('With an influential audience of city mayors')
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
