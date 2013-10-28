# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

current = new Date()
days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
month =['January',
	'February',
	'March',
	'April',
	'May',
	'June',
	'July',
	'August',
	'September',
	'October',
	'November',
	'December']

$(document).ready ->
   create_calendar()

$(document).on("click", "#prev_year", ->
   current.setFullYear(current.getFullYear() - 1)
   create_calendar()
)

$(document).on("click", "#next_year", ->
   current.setFullYear(current.getFullYear() + 1)
   create_calendar()
)

$(document).on("click", "#prev_month", ->
   current.setMonth(current.getMonth() - 1)
   create_calendar()
)

$(document).on("click", "#next_month", ->
   current.setMonth(current.getMonth() + 1)
   create_calendar()
)

create_calendar = ->
   clear()
   initialize()
   select_day()
   $('.table tbody td').hover(
      -> $(this).addClass('highlight'),
      -> $(this).removeClass('highlight')
   )

clear = ->
   $(".table tbody").empty()

initialize = ->
   insert_monthyear()
   insert_row()

insert_monthyear = ->
   $("#month").empty()
   $("#month").append("<center><strong>#{month[current.getMonth()]} #{current.getFullYear()} </strong></center>")

insert_row = ->
   first_day = new Date(current.getFullYear(), current.getMonth(), 1)
   last_day = new Date(current.getFullYear(), current.getMonth()+1, 0)
   start = first_day.getDay()
   last = last_day.getDay()
   row = " "
   count  = 0
   while (count < days_in_month[current.getMonth()])
      if count == 0
         $(".table tbody").append(create_row(count, 7 - start, start))
         count = 0 + (7-start)
      else if count + 7 < days_in_month[current.getMonth()] 
         $(".table tbody").append(create_row(count, count + 7, start))
         count += 7
      else 
         $(".table tbody").append(create_row(count, days_in_month[current.getMonth()], last))
         break

create_row = (first, last, start) ->
   row = "<tr>" 
   row += generate_empty_cell(start) if first == 0 
   row += "<td> #{date + 1} </td>" for date in [first ... last]
   row += generate_empty_cell(6 - start) if last == days_in_month[current.getMonth()]
   row += "</tr>"

generate_empty_cell = (num)  ->
   list = " "
   for i in [0 ... num] by 1
      list += "<td> </td><br/>"
   return list

$(document).on('click', '#calendar td', (event) ->
   if validate this == true
      row = $(this).parents().index()
      column = $(this).parent().children().index($(this))
      cell_no = row * 7 + column
      cell = $('tbody tr td:eq('+ cell_no + ')').html()
      insert_event(cell) unless cell == " " 
   clear_form()
)

select_day = ->
   $('#calendar td:contains("' + current.getDate()+ '")').addClass('current_day')

validate = (doc)->
   if $('form #time').val().length == 0 or $('form #event_description').val().length == 0
      return false
   else
      return true
    # insert_event($('form #time').val(), $('form #event_description').val(), doc)

insert_event = (date) ->
   event = $('form #event_description').val()
   time = $('form #time').val()
   $('#calendar td:contains("' + date + '")').append("<br/> #{time}: #{event}")

clear_form = ->
   $('form #time option:first').attr('selected', true)
   $('form #event_description').val("")

