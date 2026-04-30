# frozen_string_literal: true

require_relative '../models/upgrade'

UPGRADES = [
  {
    id: 1,
    name: 'Buy a VPN',
    cost: 10,
    description: 'Purchase a VPN to hide from authorities.',
    cost_modifier: 1.5,
    times_purchased: 1,
    modifier_type: Upgrade::CLICKS_PER_SECOND,
    buff_percentage: 0.05
  },
  {
    id: 2,
    name: 'Set Up a Secure Chat',
    cost: 20,
    description: 'Establish a secure communication channel for your followers.',
    cost_modifier: 1.6,
    times_purchased: 1,
    modifier_type: Upgrade::FOLLOWERS_PER_SECOND,
    buff_percentage: 0.06
  },
  {
    id: 3,
    name: 'Recruit a Hacker',
    cost: 500,
    description: 'Bring a skilled hacker onboard to access confidential information.',
    cost_modifier: 1.7,
    times_purchased: 1,
    modifier_type: Upgrade::CLICKS_PER_SECOND,
    buff_percentage: 0.07
  },
  {
    id: 4,
    name: 'Launch a Misinformation Campaign',
    cost: 800,
    description: 'Spread your conspiracy theories wider through social media.',
    cost_modifier: 1.8,
    times_purchased: 1,
    modifier_type: Upgrade::FOLLOWERS_PER_SECOND,
    buff_percentage: 1.08
  },
  {
    id: 5,
    name: 'Acquire a Secret HQ',
    cost: 1200,
    description: 'Buy a headquarters for your followers to gather.',
    cost_modifier: 2.0,
    times_purchased: 1,
    modifier_type: Upgrade::FOLLOWERS_PER_SECOND,
    buff_percentage: 0.09
  },
  {
    id: 6,
    name: 'Encrypt Data Archives',
    cost: 1500,
    description: 'Secure your data archives with advanced encryption.',
    cost_modifier: 2.2,
    times_purchased: 1,
    modifier_type: Upgrade::CLICKS_PER_SECOND,
    buff_percentage: 0.10
  },
  {
    id: 7,
    name: 'Develop a Mobile App',
    cost: 2000,
    description: 'Create an app to keep your followers engaged on the go.',
    cost_modifier: 2.5,
    times_purchased: 1,
    modifier_type: Upgrade::FOLLOWERS_PER_SECOND,
    buff_percentage: 0.11
  },
  {
    id: 8,
    name: 'Upgrade Server Capacity',
    cost: 2500,
    description: 'Enhance your servers to handle more follower data.',
    cost_modifier: 2.8,
    times_purchased: 1,
    modifier_type: Upgrade::CLICKS_PER_SECOND,
    buff_percentage: 0.12
  },
  {
    id: 9,
    name: 'Hire Private Security',
    cost: 3000,
    description: 'Protect your operations with private security personnel.',
    cost_modifier: 3.0,
    times_purchased: 1,
    modifier_type: Upgrade::CLICKS_PER_SECOND,
    buff_percentage: 0.13
  },
  {
    id: 10,
    name: 'Influence a Public Figure',
    cost: 5000,
    description: 'Gain the support of a public figure to spread your message.',
    cost_modifier: 3.5,
    times_purchased: 1,
    modifier_type: Upgrade::FOLLOWERS_PER_SECOND,
    buff_percentage: 0.14
  }
].freeze
