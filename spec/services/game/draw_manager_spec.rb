# frozen_string_literal: true

require_relative '../../../services/game/draw_manager'

RSpec.describe Game::DrawManager do
  let(:game_screen) do
    double('GameScreen', active_conspiracies_names: 'Flat Earth', auto_gen_followers_text: 'Auto-gen',
                         number_of_followers: 100, donations_amount: 50, warning_message: 'Warning!',
                         fade_alpha_warning: 200, latest_follower: 'John Doe', click_x: 150, click_y: 200,
                         fade_alpha_new_follower: 150, fade_alpha_auto_gen: 100)
  end
  let(:font) { instance_double(Gosu::Font) }

  before do
    stub_const('Game::DrawManager::FONT', font)
    allow(font).to receive(:draw_text)
    allow(Gosu::Color).to receive(:argb).and_return(0xFFFFFFFF)
  end

  describe '.draw_game_screen' do
    it 'calls draw_header, draw_body, and draw_footer' do
      expect(Game::DrawManager).to receive(:draw_header).with(game_screen)
      expect(Game::DrawManager).to receive(:draw_body).with(game_screen)
      expect(Game::DrawManager).to receive(:draw_footer)

      Game::DrawManager.draw_game_screen(game_screen)
    end
  end

  describe '.draw_header' do
    it 'draws the active conspiracies header' do
      expect(Game::DrawManager::FONT).to receive(:draw_text).with('Active consipiracies: Flat Earth', 100, 10, 1, 1.0,
                                                                  1.0, 0xFFFFFFFF)

      Game::DrawManager.send(:draw_header, game_screen)
    end
  end

  describe '.draw_body' do
    it 'draws the auto-gen followers text and number of followers' do
      expect(Game::DrawManager::FONT).to receive(:draw_text).with('Auto-gen', 100, 100, 1, 1.0, 1.0, 0xFFFFFFFF)
      expect(Game::DrawManager::FONT).to receive(:draw_text).with('Number of followers: 100', 100, 130, 1, 1.0, 1.0,
                                                                  0xFFFFFFFF)
      expect(Game::DrawManager::FONT).to receive(:draw_text).with('Total donations: 50$', 100, 150, 1, 1.0, 1.0,
                                                                  0xFFFFFFFF)
      expect(Game::DrawManager::FONT).to receive(:draw_text).with('John Doe', 150, 200, 1, 1.0, 1.0, 0xFFFFFFFF)

      Game::DrawManager.send(:draw_body, game_screen)
    end

    it 'draws the warning message' do
      expect(Game::DrawManager::FONT).to receive(:draw_text).with('Warning!', 250, 300, 1, 1.0, 1.0, 0xFFFFFFFF)

      Game::DrawManager.send(:draw_warning_message, game_screen.warning_message, game_screen.fade_alpha_warning)
    end
  end

  describe '.draw_footer' do
    it 'draws the footer text' do
      expect(Game::DrawManager::FONT).to receive(:draw_text).with(
        '(B) to buy a new conspiracy with the follower\'s donations', 100, 520, 1, 1.0, 1.0, 0xFFFFFFFF
      )
      expect(Game::DrawManager::FONT).to receive(:draw_text).with('!Left mouse click anywhere to gain followers!', 100,
                                                                  540, 1, 1.0, 1.0, 0xFFFFFFFF)
      expect(Game::DrawManager::FONT).to receive(:draw_text).with('(ESC) To restart game', 100, 560, 1, 1.0, 1.0,
                                                                  0xFFFFFFFF)

      Game::DrawManager.send(:draw_footer)
    end
  end
end
