module DeliveriesHelper

  def state_transition(datum, transition)
    case transition
    when "assign"
      datum.assign
    when "begin_delivery"
      datum.begin_delivery
    when "pickup_order"
      datum.pickup_order
    when "deliver" 
      datum.deliver
    when "request_feedback"
      datum.request_feedback
    when "receive_feedback"
      datum.receive_feedback
    when "report_issue"
      datum.report_issue
    when "resolve_issue" 
      datum.resolve_issue
    end
  end
end
