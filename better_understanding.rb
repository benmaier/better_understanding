# Welcome to Sonic Pi v3.1

use_bpm 130

acid_vol = 0
chord_vol = 0
bass_vol = 0

percussion_vol = 1
hh_vol = 1*percussion_vol
ride_vol = 1*percussion_vol
clap_vol = 0*percussion_vol
tom_vol = 0*percussion_vol
constant_hh_vol = 0*percussion_vol

fear_vol = 1
capitalism_vol = 0

bass_cutoff = 40

high_note_vol = 0
happy_rpg_vol = 0.0

bd_vol = 1
hackit = true

fear_intro = true

add_acid_vol = 0
additional_acid = false


live_loop :disco do
  sleep 1
end

live_loop :hh do
  cue :disco
  sample "Users/bfmaier/Music/sonicpi/fear/808-HiHats03.wav", amp: rrand(0.7,1.3)*0.3*constant_hh_vol
  sleep 0.25
end

with_fx :panslicer, phase: 1.5, mix: 0.5 do
  with_fx :reverb, room: 0, mix: 0.5 do
    with_fx :echo, phase: 0.75, mix: 0.3, decay: 6 do
      live_loop :hh2 do
        sleep 1.5
        cue :disco
        #sample :drum_cymbal_closed, amp: rrand(0.7,1.3)*0.3
        sample "Users/bfmaier/Music/sonicpi/fear/808-HiHats05.wav", amp: rrand(0.85,1.15)*0.35*hh_vol
        sleep 2.5
      end
    end
  end
end

live_loop :bd do
  cue :disco
  if hackit
    base_vol = 1.2
    s = :bd_mehackit
  else
    base_vol = 2
    s = "Users/bfmaier/Music/sonicpi/fear/808-Kicks08.wav"
  end
  sample s, amp: base_vol*bd_vol
  
  sleep 1
end

live_loop :ride do
  cue :disco
  sleep 0.5
  with_fx :hpf, cutoff: 80 do
    sample "Users/bfmaier/Music/sonicpi/fear/808-OpenHiHats11.wav", amp: 0.2*ride_vol
    sleep 0.5
  end
end


live_loop :bass do
  with_fx :lpf, cutoff: bass_cutoff do
    cue :disco
    use_synth :square
    sleep 0.5
    play :C2, amp: bass_vol, attack: 0.05
    sleep 1.5
    play :C2, release: 0.5, attack: 0.2, amp: bass_vol
    sleep 0.75
    play [:G2, :A1].choose, amp: bass_vol, attack: 0.05
    sleep 0.75
    play [ :G1, :G1, :C2, :C2 ].choose, amp: bass_vol, attack: 0.05
    sleep 0.5
  end
end

live_loop :tom do
  cue :disco
  sleep 8
  sleep 2.75
  sample :drum_tom_lo_soft, amp: 1.5*tom_vol
  sleep 0.75
  sample :drum_tom_hi_soft, amp: 1.5*tom_vol
  sleep 0.5
end

live_loop :clap do
  cue :disco
  2.times do
    sleep 1
    sample "/Users/bfmaier/Music/sonicpi/fear/clap.wav", amp: 1*clap_vol
    sleep 1
  end
end

live_loop :vox do
  cue :disco
  with_fx :reverb, mix: 0.2, room: 1 do
    sample "/Users/bfmaier/Music/sonicpi/fear/understanding.wav", amp: 1.1*capitalism_vol
    sleep 64
  end
end

live_loop :chords do
  cue :bd
  use_synth :hollow
  with_fx :reverb, mix: 0.6, room: 0.8 do
    3.times do
      with_fx :ixi_techno, phase: 64, cutoff_max: 120,cutoff_min: 80 do
        play chord(:C4,:add9), amp: 2*chord_vol, sustain: 7.5, release: 2, attack: 0.5
        sleep 7.5
        play chord(:A4,:minor7), amp: 2*chord_vol, sustain: 8, release: 2, attack: 0.5
        sleep 8.5
      end
    end
    with_fx :ixi_techno, phase: 64, cutoff_max: 120,cutoff_min: 80 do
      play chord(:F4,:add9), amp: 2*chord_vol, sustain: 4, release: 2, attack: 0.5
      sleep 4
      play chord(:A4,:minor7), amp: 2*chord_vol, sustain: 3.5, release: 2, attack: 0.5
      sleep 3.5
      play chord(:D4,:minor7), amp: 2*chord_vol, sustain: 8.5, release: 2, attack: 0.5
      sleep 8.5
    end
    #end
  end
end

with_fx :panslicer, mix: 0.3, phase: 8, smooth: 1.0 do
  
  with_fx :reverb, room: 0.8 do
    with_fx :echo, mix: 0.5, phase: 0.75, decay: 10 do
      with_fx :ixi_techno, phase: 128, cutoff_min: 70, cutoff_max: 129 do
        live_loop :squelch do
          use_synth :tb303
          cue :disco
          use_random_seed 3000
          #with_fx :lpf, cutoff: 120 do
          #with_fx :hpf, cutoff: 0 do
          64.times do
            n = (ring :A2, :A2, :A3).tick
            play n, release: rrand(0.125,0.25), cutoff: rrand(70, 130), res: 0.9, wave: 1, amp: 0.1*acid_vol
            sleep 0.25
          end
          64.times do
            n = (ring :F2, :F2, :F3).tick
            #n = (ring :A2, :A2, :A3).tick
            
            play n, release: rrand(0.125,0.25), cutoff: rrand(70, 130), res: 0.9, wave: 1, amp: 0.1*acid_vol
            sleep 0.25
          end
          64.times do
            
            n = (ring :A2, :A2, :A3).tick
            
            play n, release: rrand(0.125,0.25), cutoff: rrand(70, 130), res: 0.9, wave: 1, amp: 0.1*acid_vol
            sleep 0.25
            
          end
          32.times do
            n = (ring :F2, :F2, :F3).tick
            
            play n, release: rrand(0.125,0.25), cutoff: rrand(70, 130), res: 0.9, wave: 1, amp: 0.1*acid_vol
            sleep 0.25
            #end
            #end
            
          end
          32.times do
            
            n = (ring :D2, :D2, :D3).tick
            
            play n, release: rrand(0.125,0.25), cutoff: rrand(70, 130), res: 0.9, wave: 1, amp: 0.1*acid_vol
            sleep 0.25
            
          end
        end
      end
    end
  end
end

with_fx :panslicer, mix: 0.3, phase: 8, smooth: 1.0 do
  with_fx :reverb, mix: 1.0, room: 1.0 do
    live_loop :fear do
      if fear_intro
        sample "/Users/bfmaier/Music/sonicpi/fear/FEAR.wav", amp: 1.4*fear_vol, rate: +1
        sleep 13.75
        sample "/Users/bfmaier/Music/sonicpi/fear/FEAR.wav", amp: 1.4*fear_vol, rate: -1
        sleep 18.25
        sample "/Users/bfmaier/Music/sonicpi/fear/FEAR.wav", amp: 1.4*fear_vol, rate: +1
        sleep 13.75
        sample "/Users/bfmaier/Music/sonicpi/fear/FEAR.wav", amp: 1.4*fear_vol, rate: -1
        sleep 18.25
      else
        sleep 32
        sample "/Users/bfmaier/Music/sonicpi/fear/FEAR.wav", amp: 1.4*fear_vol, rate: +1
        sleep 32
      end
    end
  end
end

with_fx :ixi_techno, phase: 128, cutoff_min: 90, cutoff_max: 129, res: :A5 do
  with_fx :panslicer, mix: 0.4, phase: 16, smooth: 5.0 do
    with_fx :flanger, phase: 1, mix: 0.4 do
      live_loop :high do
        cue :bd
        use_synth :dark_ambience
        play :A5, sustain: 8, amp: high_note_vol
        sleep 8
      end
    end
  end
end



#with_fx :panslicer, mix: 0.3, phase: 8, smooth: 1.0 do

with_fx :reverb, room: 0.8 do
  with_fx :echo, mix: 0.5, phase: 0.75, decay: 10 do
    with_fx :ixi_techno, phase: 32, cutoff_min: 80, cutoff_max: 129 do
      live_loop :intro_acid do
        use_synth :tb303
        cue :disco
        #use_random_seed 3000
        #with_fx :lpf, cutoff: 120 do
        #with_fx :hpf, cutoff: 0 do
        8.times do
          n = (ring :r, :r, :A2, :r,  :r, :C4 , :r, :C4,  ).tick
          play n, release: rrand(0.125,0.25), cutoff: rrand(70, 130), res: 0.9, wave: 1, amp: 0.05*add_acid_vol
          sleep 0.25
        end
        
        8.times do
          n = (ring :r, :r, :A2, :r,  :r, :C4 , :r, :C4,  ).tick
          if additional_acid
            #play n, release: rrand(0.125,0.25), cutoff: rrand(70, 130), res: 0.9, wave: 1, amp: 0.05*add_acid_vol
          end
          sleep 0.25
        end
        
        8.times do
          n = (ring :r, :r, :A2, :r,  :r, :C4 , :r, :C4,  ).tick
          play n, release: rrand(0.125,0.25), cutoff: rrand(70, 130), res: 0.9, wave: 1, amp: 0.05*add_acid_vol
          sleep 0.25
        end
        
        
        8.times do
          n = (ring :r, :C4, :G2, :C4,  :A3, :D4 , :A3, :C4,  ).tick
          if additional_acid
            play n, release: rrand(0.125,0.25), cutoff: rrand(70, 130), res: 0.9, wave: 1, amp: 0.05*add_acid_vol
          end
          sleep 0.25
        end
      end
    end
  end
end

with_fx :panslicer, mix: 0.3, phase: 8, smooth: 1.0 do
  with_fx :reverb, room: 0.8 do
    with_fx :echo, mix: 0.5, phase: 0.75, decay: 10 do
      with_fx :ixi_techno, phase: 128, cutoff_min: 70, cutoff_max: 129 do
        live_loop :rpg do
          cue :disco
          use_synth :blade
          use_random_seed 3000
          n = (ring :C5, :r, :r, :C5, :C5, :r, :C5, :r).tick
          play n, sustain: 0.125, release: 0.2, attack: 0.0, amp: happy_rpg_vol
          sleep 0.25
        end
      end
    end
  end
end
