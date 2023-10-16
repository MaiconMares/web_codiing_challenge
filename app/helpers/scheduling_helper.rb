module SchedulingHelper

  def schedule_conferences_optimal(conferences)
    tracks = {}
    track_id = 0

    # Ordena conferências em ordem decrescente de duração
    conferences.sort_by! { |conf| -conf[0] }


    while conferences.length > 1
      track_id += 1
      tracks["#{track_id}"] = {
        'morning' => [],
        'afternoon' => [],
      }

      remaining_morning_time = 180
      remaining_afternoon_time = 240
      
      for conference in conferences
        duration, name = conference
    
        if remaining_morning_time >= duration
          tracks["#{track_id}"]['morning'] << [duration, name]
          remaining_morning_time -= duration
          conferences.shift
        elsif remaining_afternoon_time >= duration
          tracks["#{track_id}"]['afternoon'] << [duration, name]
          remaining_afternoon_time -= duration
          conferences.shift
        end
      end
    end

    tracks
  end
end