module Event::Tags
  include Radiant::Taggable
  include ActionView::Helpers::TagHelper
  
  desc %{    
    *Usage*:
    <pre><code><r:all_events /></code></pre>
  }
  tag 'all_events' do |tag|
    events = Event.all
    r = '<table width="100%" style="border: 2px solid rgb(255, 255, 255);">
          <tbody>
            <tr>
              <td width="229" style="background-color: rgb(166, 210, 46); height: 44px;">
                <div style="padding: 12px;" class="tdTitle">Description</div>
              </td>

              <td width="69" style="background-color: rgb(166, 210, 46); height: 44px;">&nbsp;</td>

              <td width="110" style="background-color: rgb(166, 210, 46); height: 44px;">
                <div style="padding: 12px;" class="tdTitle">Location</div>
              </td>

              <td width="140" style="background-color: rgb(166, 210, 46); height: 44px;">
                <div style="padding: 12px;" class="tdTitle">Time</div>
              </td>

              <td width="140" style="background-color: rgb(166, 210, 46); height: 44px;">
                <div style="padding: 12px;" class="tdTitle">Date</div>
              </td>

              <td width="88" style="background-image: url(/images/bg_register.gif); background-repeat: no-repeat; height: 44px;">
                <div style="padding: 12px;" class="tdTitle">Register</div>
              </td>
            </tr>
            <tr>'

    r << events.map { |event| 
      '<td valign="top" style="background-color: rgb(246, 246, 247); height: 44px;">' <<
      '<div style="padding: 12px;" class="tdtxt">' << event.description << '</div></td>' <<

      '<td valign="top" align="center" style="background-color: rgb(246, 246, 247); height: 44px;">' <<
      '<div style="padding-top: 10px;"><img height="17" width="62" style="border: medium none ; margin: 0px;" alt="Register" src="/images/gordcooke-events.png" /></div></td>' <<
      
      '<td valign="top" style="background-color: rgb(246, 246, 247); height: 44px;">' <<
      '<div style="padding: 12px;" class="tdtxt"><span style="background-color: rgb(246, 246, 247); height: 44px;">' << event.location << '</span></div></td>' <<
      
      '<td valign="top" style="background-color: rgb(246, 246, 247); height: 44px;">' <<
      '<div style="padding: 12px;" class="tdtxt">' << event.time << '</div></td>' <<
      
      '<td valign="top" style="background-color: rgb(246, 246, 247); height: 44px;">' <<
      '<div style="padding: 12px;" class="tdtxt">' << event.date << '</div></td>' <<
      
      '<td valign="top" align="center" style="background-color: rgb(246, 246, 247); height: 44px;">' <<
      '<div style="padding-top: 6px;"><a href="/meet-gord?event_id='+event.id.to_s+'&description='+event.description+'&location='+event.location+'&time='+event.time+'&date='+event.date+'"><img height="21" width="65" style="border: medium none ; margin: 0px;" alt="Register" src="/images/b_register-events.png" /></a></div></td>'
    }.join('</tr><tr>')
    
    r << '</tr></tbody></table>'
  end

  
  desc %{    
    *Usage*:
    <pre><code><r:recent_events /></code></pre>    
  }
  tag 'recent_events' do |tag|
    events = Event.find(:all, :order => 'id DESC', :limit => 2)
    events.map { |event| 
      "<p>#{event.description}.<br/>" <<
      '<span class="readmore"><a href="/events/events-calendar">Read more</a></span> <img height="7" width="9" alt="" src="/images/arrow-black.png"/></p>'
    }.join("\n")
  end  
end
