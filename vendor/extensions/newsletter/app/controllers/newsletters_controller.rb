class NewslettersController < ApplicationController

  before_filter :find_page_and_newsletter
  
  def new
  end
  
  def create
    if request.post?
      if params[:test_email]
        if params[:address] =~ /^$|^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
          flash[:notice] = "Test email has been sent correctly"
          send_test_email(@newsletter, @page, (NewsletterSubscriber.find_by_email(params[:address]) || NewsletterSubscriber.new(:email => params[:address])))
        else
          flash[:error] = "You must specify an email address"
          render :action => 'new' and return
        end
      else
        send_emails(@newsletter, @page)
        flash[:notice] = "Email has been sent correctly"
      end      
      redirect_to(:controller => '/admin/pages', :action => 'edit', :id => @page)
    else
      redirect_to(:action => "new", :page_id => @page.id)
    end
  end
  
  def preview
    render :text => @page.render
  end

private
  
  def find_page_and_newsletter
    @page = Page.find(params[:page_id])
    @newsletter = @page.parent
    redirect_to('/admin/') and return if !@newsletter || @newsletter.class_name != 'NewsletterPage'
  rescue ActiveRecord::RecordNotFound  
    redirect_to('/admin')
  end
  
  def send_emails(newsletter, page)
    newsletter.active_subscribers.each do |subscriber|      
      info = email_info(newsletter, page, subscriber)
      email = NewsletterMailer.create_newsletter(info[:subject], info[:html_body], subscriber.address, info[:from])
      NewsletterEmail.create({
        :page_id        => page.id,
        :mail           => email.encoded, 
        :to             => subscriber.email,
        :from           => info[:from]
      })
    end
    page.update_attribute(:sent_as_newsletter_email_at, Time.now)
  end     
  
  def send_test_email(newsletter, page, subscriber)
    info = email_info(newsletter, page, subscriber)
    email = NewsletterMailer.create_newsletter(info[:subject], info[:html_body], subscriber.address, info[:from])    
    NewsletterMailer.deliver(email)
  end
    
  def email_info(newsletter, page, subscriber)
    {
      :subject => "[#{newsletter.config["subject_prefix"]}] #{page.title}",
      :html_body => page.respond_to?(:render_with_subscriber) ? page.render_with_subscriber(subscriber) : page.render,
      :from => newsletter.config["from"]
    }
  end
  
end
