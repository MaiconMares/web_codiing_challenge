module SchedulingHelper

  def schedule_conferences_optimal(conferences)
    tracks = {}
    track_id = 0

    # Ordena conferências em ordem decrescente de duração
    conferences.sort_by! { |conf| -conf["duration"] }

    while conferences.length > 1
      track_id += 1
      tracks["track_#{track_id}"] = {
        'morning' => [],
        'afternoon' => [],
      }

      remaining_morning_time = 180
      remaining_afternoon_time = 240

      last_morning_start = 540
      last_afternoon_start = 780
      
      conferences_to_remove = []
      conferences.each_with_index do |conference, idx|
        name = conference["name"]
        duration = conference["duration"]
    
        if remaining_morning_time >= duration
          start_time = get_start_time(last_morning_start)
          end_time = get_end_time(last_morning_start, duration)
          last_morning_start += duration

          tracks["track_#{track_id}"]['morning'] << {
            "name" => name, "duration" => duration, 
            "start_time" => start_time, "end_time" => end_time
          }

          remaining_morning_time -= duration
          conferences_to_remove << conference["id"]
        elsif remaining_afternoon_time >= duration
          start_time = get_start_time(last_afternoon_start)
          end_time = get_end_time(last_afternoon_start, duration)
          last_afternoon_start += duration

          tracks["track_#{track_id}"]['afternoon'] << {
            "name" => name, "duration" => duration,
            "start_time" => start_time, "end_time" => end_time
          }

          remaining_afternoon_time -= duration
          conferences_to_remove << conference["id"]
        end
      end

      conferences.delete_if {|conf| conferences_to_remove.include?(conf["id"])}

      if (remaining_morning_time || remaining_afternoon_time)
        tracks["track_#{track_id}"], conferences = explore_remaining_time_frame(tracks["track_#{track_id}"], conferences, remaining_morning_time, remaining_afternoon_time)
      end
    end

    tracks
  end

  def extract_conferences_from_file(file_path)
    file = File.open(file_path)&.read
    lightning_duration = 5

    return [] if file.blank?

    conferences = []

    file.each_line do |line|
      if line.scan(/lightning/).present?
        duration = lightning_duration
        name = line.gsub(/lightning/,"").squish
      else
        duration = line.scan(/\d+/)[0]&.to_i
        name = line.gsub(/\s*\d+min/,"").squish
      end
      

      conferences << {name: name, duration: duration}
    end

    conferences
  end

  def get_start_time(elapsed_time)
    Time.at(elapsed_time*60).utc.strftime('%H:%M')
  end

  def get_end_time(elapsed_time, duration)
    Time.at((elapsed_time+duration)*60).utc.strftime('%H:%M')
  end

  def explore_remaining_time_frame(track, conferences, remaining_morning_time, remaining_afternoon_time)
    last_morning_start = 720 - remaining_morning_time
    last_afternoon_start = 1020 - remaining_afternoon_time

    conferences_to_remove = []
    conferences.to_enum.with_index.reverse_each do |conference, idx|
      name = conference["name"]
      duration = conference["duration"]
  
      if remaining_morning_time >= duration
        start_time = get_start_time(last_morning_start)
        end_time = get_end_time(last_morning_start, duration)
        last_morning_start += duration

        track['morning'] << {
          "name" => name, "duration" => duration, 
          "start_time" => start_time, "end_time" => end_time
        }

        remaining_morning_time -= duration
        conferences_to_remove << conference["id"]
      elsif remaining_afternoon_time >= duration
        start_time = get_start_time(last_afternoon_start)
        end_time = get_end_time(last_afternoon_start, duration)
        last_afternoon_start += duration

        track['afternoon'] << {
          "name" => name, "duration" => duration,
          "start_time" => start_time, "end_time" => end_time
        }

        remaining_afternoon_time -= duration
        conferences_to_remove << conference["id"]
      end
    end

    conferences.delete_if {|conf| conferences_to_remove.include?(conf["id"])}

    [track, conferences]
  end
end