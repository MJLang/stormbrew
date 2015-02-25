# require 'attributes'
require 'bindata'
require_relative 'bitreader'

module Heroes
  class GameEvent
    attr_accessor :event_type, :player_index, :global, :ticks_elapsed, :data

    def initialize
      @data = {}
    end
    def self.parse(stream, replay)

    end
  end

  class Events
    def self.parse(stream, replay)
      events = []
      reader = Heroes::BitReader.new(stream)

      ticks_elapsed = 0
      while (!reader.end?)
        event = GameEvent.new
        ticks_elapsed += reader.read(6 + (reader.read(2) << 3))
        event.ticks_elapsed = ticks_elapsed
        event.player_index = reader.read(5)
        if event.player_index == 16
          event.global = true
        end

        event.event_type = reader.read(7)
        binding.pry
        case event.event_type
          when 2
            events << self.parse_game_start_event(reader, event)
          when 5
            events << self.parse_finish_loading_event(reader, event)
          when 7
            events << self.parse_user_options_event(reader, event)
          when 9
            events << self.parse_bank_file_event(reader, event)
          when 10
            events << self.parse_bank_section_event(reader, event)
          when 11
            events << self.parse_bank_key_event(reader, event)
          when 13
            events << self.parse_bank_signature_event(reader, event)
          when 14
            events << self.parse_camera_save_event(reader, event)
          when 25
            events << self.parse_command_manager_reset_event(reader, event)
          when 27
            events << self.parse_cmd_event(reader, event)
          when 28
            events << self.parse_selection_delta_event(reader, event)
          when 29
            events << self.parse_control_group_update_event(reader, event)
          when 31
            events << self.parse_resource_trade_event(reader, event)
          when 32
            events << self.parse_trigger_chat_message_event(reader, event)
          when 36
            events << self.parse_trigger_ping_event(reader, event)
          when 39
            events << self.parse_unit_click_event(reader, event)
          when 44
            events << self.parse_trigger_skipped_event(reader, event)
          when 45
            events << self.parse_trigger_sound_length_query_event(reader, event)
          when 46
            events << self.parse_trigger_sound_offset_event(reader, event)
          when 47
            events << self.parse_trigger_transmission_offset_event(reader, event)
          when 48
            events << self.parse_trigger_tranmission_complete_event(reader, event)
          when 49
            events << self.parse_camera_update_event(reader, event)
          when 53
            events << self.parse_trigger_planet_mission_launched_event(reader, event)
          when 55
            events << self.parse_trigger_dialog_control_event(reader, event)
          when 56
            events << self.parse_trigger_sound_length_synced_event(reader, event)
          when 58
            events << self.parse_trigger_mouse_clicked_event(reader, event)
          when 59
            events << self.parse_trigger_mouse_moved_event(reader, event)
          when 61
            events << self.parse_trigger_hotkey_pressed_event(reader, event)
          when 62
            events << self.parse_trigger_target_mode_updated_event(reader, event)
          when 64
            events << self.parse_trigger_soundtrack_done_event(reader, event)
          when 66
            events << self.parse_trigger_key_pressed_event(reader, event)
          when 97
            events << self.parse_trigger_cutscence_bookmark_fired_event(reader, event)
          when 98
            events << self.parse_trigger_cutscense_end_fired_event(reader, event)
          when 101
            events << self.parse_user_leave_event(reader, event)
          when 102
            events << self.parse_user_join_event(reader, event)
          when 103
            events << self.parse_command_manager_state_event(reader, event)
          when 104
            events << self.parse_update_target_point_event(reader, event)
          when 105
            events << self.parse_update_target_unit_event(reader, event)
          when 110
            events << self.parse_hero_talent_selected_event(reader, event)
          when 112
            events << self.parse_hero_talent_panel_toggled_event(reader, event)
          else
            binding.pry
            raise Exception, 'Nope'
        end

        reader.align_to_byte
      end

      return events
    end



    def self.parse_game_start_event(reader, event)
      return event
    end

    def self.parse_finish_loading_event(reader, event)
      return event
    end

    def self.parse_user_options_event(reader, event)
      event.data[:array] = [
          {uint: reader.read(1)},
          {uint: reader.read(1)},
          {uint: reader.read(1)},
          {uint: reader.read(1)},
          {uint: reader.read(1)},
          {uint: reader.read(1)},
          {uint: reader.read(1)},
          {uint: reader.read(1)},
          {uint: reader.read(1)},
          {uint: reader.read(32)},
          {uint: reader.read(32)},
          {uint: reader.read(32)},
          {type: 2, blob: reader.read_blob_with_length(7)}
      ]
      return event
    end

    def self.parse_bank_file_event(reader, event)
      event.event_type = 'BankFileEvent'
      event.data[:type] = 2
      event.data[:blob] = reader.read_blob_with_length(7)
      return event
    end

    def self.parse_bank_section_event(reader, event)
      event.event_type = 'BankSectionEvent'
      event.data[:type] = 2
      event.data[:blob] = reader.read_blob_with_length(6)
      return event
    end

    def self.parse_bank_key_event(reader, event)
      event.event_type = 'BankKeyEvent'
      event.data[:array] = [{type: 2, blob: reader.read_blob_with_length(6)}, 
                            {uint: reader.read(32)},
                            {type: 2, blob: reader.read_blob_with_length(7)}]
      return event
    end

    def self.parse_bank_signature_event(reader, event)
      event.event_type = 'BankSignatureEvent'
      event.data[:type] = 2
      array_length = reader.read(5)
      event.data[:array] = []
      array_length.times do
        event.data[:array] << {uint: reader.read(8)}
      end
      event.data[:blob] = reader.read_blob_with_length(7)
      return event
    end

    def self.parse_camera_save_event(reader, event)
      reader.read(3)
      reader.read(16)
      reader.read(16)
      return event
    end

    def self.parse_command_manager_reset_event(reader, event)
      reader.read(32)
      return event
    end

    def self.parse_cmd_event(reader, event)
      event.data[:array] = []
      if replay.build < 33684
        event.data[:array] << {uint: reader.read(22)}
      else
        event.data[:array] << {uint: reader.read(23)}
      end

      if reader.read_boolean
        event.data[:array] << {array: [{uint: reader.read(16)}, {uint: reader.read(5)}, {}]}
        if reader.read_boolean
          event.data[:array][1][:array][2][:uint] = reader.read(8)
        end
      end
      case reader.read(2)
        when 0
        when 1
          event.data[:array][2] = {array: [{uint: reader.read(20)}, {uint: reader.read(20)}, {vint: reader.read(32) - 2147483648}]}
        when 2
          event.data[:array][2] = {array: [{uint: reader.read(16)}, {uint: reader.read(8)}, {uint: reader.read(32)}, {uint: reader.read(16)}, {}, {}, {}]}
          if reader.read_boolean
            event.data[:array][2][:array][4][:uint] = reader.read(4)
          end
          if reader.read_boolean
            event.data[:array][2][:array][5][:uint] = reader.read(4)
          end
          event.data[:array][2][:array][6] = {array: [{uint: reader.read(20)}, {uint: reader.read(20)}, {vint: reader.read(32) - 2147483648}]}
        when 3
          event.data[:array][2] = {uint: reader.read(32)}
      end
      if replay.build >= 33684
        reader.read(32)
      end
      if reader.read_boolean
        event.data[:array] << {uint: reader.read(32)}
      end
      if reader.read_boolean
        event.data[:array] << {uint: reader.read(32)}
      end
      return event
    end

    def self.parse_selection_delta_event(reader, event)
      return event
    end
    def self.parse_control_group_update_event(reader, event)
      return event
    end
    def self.parse_resource_trade_event(reader, event)
      return event
    end
    def self.parse_trigger_chat_message_event(reader, event)
      return event
    end
    def self.parse_trigger_ping_event(reader, event)
      return event
    end
    def self.parse_unit_click_event(reader, event)
      return event
    end
    def self.parse_trigger_skipped_event(reader, event)
      return event
    end
    def self.parse_trigger_sound_length_query_event(reader, event)
      return event
    end
    def self.parse_trigger_sound_offset_event(reader, event)
      return event
    end
    def self.parse_trigger_transmission_offset_event(reader, event)
      return event
    end
    def self.parse_trigger_tranmission_complete_event(reader, event)
      return event
    end
    def self.parse_camera_update_event(reader, event)
      return event
    end
    def self.parse_trigger_planet_mission_launched_event(reader, event)
      return event
    end
    def self.parse_trigger_dialog_control_event(reader, event)
      return event
    end
    def self.parse_trigger_sound_length_synced_event(reader, event)
      return event
    end
    def self.parse_trigger_mouse_clicked_event(reader, event)
      return event
    end
    def self.parse_trigger_mouse_moved_event(reader, event)
      return event
    end
    def self.parse_trigger_hotkey_pressed_event(reader, event)
      return event
    end
    def self.parse_trigger_target_mode_updated_event(reader, event)
      return event
    end
    def self.parse_trigger_soundtrack_done_event(reader, event)
      return event
    end
    def self.parse_trigger_key_pressed_event(reader, event)
      return event
    end
    def self.parse_trigger_cutscence_bookmark_fired_event(reader, event)
      return event
    end
    def self.parse_trigger_cutscense_end_fired_event(reader, event)
      return event
    end
    def self.parse_user_leave_event(reader, event)
      return event
    end
    def self.parse_user_join_event(reader, event)
      return event
    end
    def self.parse_command_manager_state_event(reader, event)
      return event
    end
    def self.parse_update_target_point_event(reader, event)
      return event
    end
    def self.parse_update_target_unit_event(reader, event)
      return event
    end
    def self.parse_hero_talent_selected_event(reader, event)
      return event
    end
    def self.parse_hero_talent_panel_toggled_event(reader, event)
      return event
    end


  end
end