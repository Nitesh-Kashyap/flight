class AirplanesController < ApplicationController
	protect_from_forgery

	def new
		@airplane = Airplane.new
	end

	def create
		@airplane = Airplane.new(airplane_params)
		if @airplane.save
			redirect_to airplanes_path
		else
			render 'new'
			flash.now.alert = "Something went wrong ! try again!!"
		end
	end

	def index
		@airplanes = Airplane.all
	end

	def show
		@airplane = Airplane.find(params[:id])
	end

	def my_book
		@booking = Booking.new(booking_params)
	end

	def book
		@airplane = Airplane.find(params[:booking][:airplane_id])
		if @airplane
			@booking = Booking.new(booking_params)
			if @booking.save
				redirect_to payment_path(@booking)
			else
				flash.now.alert = "#{@booking.errors.full_messages.to_sentence}"
				render 'show'
			end
		else
			flash.now.alert = "Flight has been cancelled"
			render 'show'
		end
	end

	def payment
		@booking = Booking.find(params[:id])
	end

	def success
		@booking = Booking.find(params[:id])
		if @booking
			@payment = Payment.new(payment_params)
			if @payment.save
				@airplane = @booking.airplane
				NotificationMailer.notification_mailer(@booking,@airplane,current_user).deliver rescue nil
				flash.now.notice = "Your payment is successfull, An email has been sent to you with the booking details."
				if @airplane.seats*50/100 < @airplane.bookings.count
					@airplane.update_columns(price: @airplane.price + @airplane.price*10/100) 
				end
			else
				flash.now.alert = "#{@payment.errors.full_messages.to_sentence}"
				render 'payment'
			end
		end
	end


	def search
		@airplanes = Airplane.search(params[:search])
	end

	def available
		@airplanes = Airplane.where( "source LIKE ? AND destination LIKE ? AND category LIKE ?", params[:source], params[:destination], params[:available][:category])
	      render 'search'
	end 


	def pnr
		@booking = Booking.find_by_pnr(params[:pnr]) if params[:pnr]
		if @booking
			render :template => 'airplanes/status'
		else
			flash.now.alert = "PNR not found! Try Again!" if params[:pnr]
		end
	end


	private

	def airplane_params
		params.require(:airplane).permit(:name, :category, :seats, :rows, :source, :destination, :price)
	end

	def booking_params
		params.require(:booking).permit(:name, :status, :airplane_id, :pnr, :passport_id, :passenger1, :passenger2, :age)
	end

	def payment_params
		params.require(:payment).permit(:name, :card_number, :cvv, :month, :year, :price)
	end
end
