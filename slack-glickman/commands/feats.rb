module SlackGlickman
  module Basketball
    module Commands
    class Feats < SlackRubyBot::Commands::Base
        command ":tophat:" do |client, data, _match|
          query_params = Stattleship::Params::HockeyFeatsParams.new
          query_params.feat = 'hat_trick_goals'

          feats = Stattleship::HockeyFeats.fetch(params: query_params).map(&:to_sentence).join("\n")

          send_message client, data.channel, ":tophat: Hat Tricks! \n #{feats}"
        end

        ['basketball', 'football', 'hockey'].each do |sport|

          statmoji = if sport == 'hockey'
                       'ice_hockey_stick_and_puck'
                      else
                        sport
                      end
          command ":fire: :#{statmoji}:" do |client, data, _match|
            query_params = const_get("Stattleship::Params::#{sport.capitalize}FeatsParams").new
            query_params.level_up = 3
            query_params.since = 'yesterday'

            feats = const_get("Stattleship::#{sport.capitalize}Feats").fetch(params: query_params).map(&:to_sentence).join("\n")

            send_message client, data.channel, ":fire: What's hot in :#{statmoji}: since #{query_params.since }! \n #{feats}"
          end
        end
      end
    end
  end
end
