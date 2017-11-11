describe 'Example' do
  example 'Page contains title' do
    visit 'https://monocle.com/'
    expect(page).to have_content('Monocle')
  end
end
