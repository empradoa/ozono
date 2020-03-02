class HomeController < ApplicationController
  def index
  	
	#@url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=89129&distance=0&API_KEY=86D41DC5-5113-4F19-8A1A-5AFCFFB0AC9E'
  end

  def codigopostal
  	 @codigo_query = params[:codigopostal]

  	 if params[:codigopostal] == ""
  	 	@codigo_query = "Por favor digite un codigo postal"
  	 elsif params[:codigopostal]
  	 	require 'net/http'
		require 'json'
  	 	@url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' + @codigo_query + '&distance=0&API_KEY=86D41DC5-5113-4F19-8A1A-5AFCFFB0AC9E'
		@uri = URI(@url)
		@response = Net::HTTP.get(@uri)
		@output = JSON.parse(@response)
	  	 	#Verificar si no retorna resultados
		if @output.empty?
			@final_output = "Error"
	    elsif !@output
	    	@final_output = "Carambas"
		else
		    @final_output = @output[0]['AQI']
		end
		if @final_output == "Error"
			@api_color = "silver"
		elsif @final_output <= 50
			@api_color = "green"
			@api_description = "Moderado (51 - 100)
								La calidad del aire se considera satisfactoria, y la contaminación del aire representa poco o ningún riesgo."
		elsif @final_output >= 51 && @final_output <= 100
			@api_color = "yellow"
			@api_description = "Moderado (51 - 100)
								La calidad del aire es aceptable; sin embargo, para algunos contaminantes puede haber un problema de salud moderado para un número muy pequeño de personas que son inusualmente sensibles a la contaminación del aire."
		elsif @final_output >= 101 && @final_output <= 150
			@api_color = "orange"
			@api_description = "Insalubre para grupos sensibles (101 - 150)
								Aunque no es probable que el público en general se vea afectado en este rango de AQI, las personas con enfermedad pulmonar, adultos mayores y niños tienen un mayor riesgo de exposición al ozono, mientras que las personas con corazón y pulmón enfermedad, los adultos mayores y los niños están en mayor riesgo por la presencia de partículas en el aire."
		elsif @final_output >= 151 && @final_output <= 200
			@api_color = "red"
			@api_description = "Insalubre (151 - 200)
								Todos pueden comenzar a experimentar efectos en la salud; Los miembros de grupos sensibles pueden experimentar efectos de salud más graves."
		elsif @final_output >= 201 && @final_output <= 300
			@api_color = "purple"	
			@api_description = "Muy poco saludable (201 - 300)
								Alerta de salud: todos pueden experimentar efectos de salud más graves."
		elsif @final_output >= 301 && @final_output <= 500
			@api_color = "maroon"
			@api_description = "Peligroso (301 - 500)
								Advertencias sanitarias de condiciones de emergencia. Es más probable que toda la población se vea afectada."
		end

  	 end
  	 	


  end


end
