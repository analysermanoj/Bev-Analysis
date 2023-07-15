/*Who prefers energy drink more? (male/female/non-binary?*/
select Gender , count(Gender) num_gndr
from  project_db.dim_repondents 
group by Gender 
order by num_gndr desc
# Male prefers energy drink more.

/*Which age group prefers energy drinks more?*/
select Age , count(Age) num_age from dim_repondents 
group by Age order by num_age desc

# 19-30 age group prefers more energy drinks

/*Which type of marketing reaches the most Youth (15-30)?*/
select f.Marketing_channels ,count(f.Marketing_channels) marketing 
from fact_survey_responses f 
join dim_repondents d 
on f.Respondent_ID = d.Respondent_ID
where Age in ('15-18','19-30')
group by Marketing_channels 
order by marketing desc
# Online ads marketing reaches the most for youth (15-30)

/*What are the preferred ingredients of energy drinks among respondents*/
select Ingredients_expected , count(Ingredients_expected) pref_ingredients 
from fact_survey_responses 
group by Ingredients_expected order by pref_ingredients desc

# Caffeine is most preferred ingredients of energy among respondents

/*What packaging preferences do respondents have for energy drinks?*/
select Packaging_preference , count(Packaging_preference) packaging from fact_survey_responses
group by Packaging_preference order by packaging desc

#compact and portable cans are the pactkaging preference

/*Who are the current market leaders? */
SELECT current_brands , count(current_brands) brand_response
FROM fact_survey_responses  
group by current_brands order by brand_response desc

#Cola-Coka is the currents market leader in this time

#What are the primary reasons consumers prefer those brands over ours
select Reasons_for_choosing_brands total_response , count(Reasons_for_choosing_brands) reason_pref_count
from fact_survey_responses 
group by Reasons_for_choosing_brands 
order by reason_pref_count desc
# Brand reputation is the main reason for consumer preferanse

#Which marketing channel can be used to reach more customers?
select marketing_channels , count(marketing_channels) num 
from fact_survey_responses 
group by Marketing_channels order by num desc

#Online ads is the best channel for reaching out the more customers

#a. What do people think about our brand? (overall rating)
select avg(Taste_experience) overall_rating from fact_survey_responses

# 3.3 is the overall rating of our brand

# City for Improvement
# create view for lagging city
select dr.City_ID , count(dr.City_ID) num_of_response 
from dim_repondents dr
join fact_survey_responses fsr 
on dr.Respondent_ID = fsr.Respondent_ID
where Reasons_preventing_trying in ('Unfamiliar with the brand','Not available locally' )
group by dr.City_ID 
order by City_ID
# create view of total count city
select City_ID , count(City_ID) num from dim_repondents 
group by City_ID order by City_ID
# city id for improvement
select lbc.City_ID, round((lbc.num_of_response/tcc.total_count)*100,1) response 
from lag_behind_city lbc 
join total_count_city tcc 
on lbc.City_ID = tcc.City_ID
order by response desc
# city needs to be improve 
select City from dim_cities where City_ID in ('CT115','CT119','CT120')

# Kolkata , Jaipur and Lucknow 

#Where do respondents prefer to purchase energy drinks?
select Purchase_location ,count(Purchase_location) num_pref from fact_survey_responses
group by Purchase_location order by num_pref desc

#Supermarkets is prefer by respondents for purchasing energy drinks

/* What are the typical consumption situations for energy drinks among 
respondents */
select Typical_consumption_situations , count( Typical_consumption_situations) num
from fact_survey_responses
group by  Typical_consumption_situations 
order by num desc

/* Sports/exercise is the most situation where
 people prefer taking energy drinks */
 
/*What factors influence respondents' purchase decisions, such as price range and 
limited edition packaging? */
# 1.Price_range
select Price_range , count(Price_range) num from fact_survey_responses 
group by Price_range order by num desc
# most people want price range should be between 50-99

# 2.Limited_edition_packaging
select Limited_edition_packaging , count(Limited_edition_packaging) num from fact_survey_responses 
group by Limited_edition_packaging order by num desc
# here 40 % people want limited edition packaginga and another side 40% people also do want any limited edition packaging remain people not sure 

# 3.Branding
select marketing_channels , round(count(marketing_channels)/100,2) num 
from fact_survey_responses 
group by Marketing_channels order by num desc

# Approx. 70% of people have heard about the brand through online ads and TV commercials. Therefore, determining the most suitable platform for marketing is an essential factor in building brand reputation and influencing consumer decisions.
#4. Reason for choosing brand
 select Reasons_for_choosing_brands , count(Reasons_for_choosing_brands) num from 
 fact_survery_responses group by Reasons_for_choosing_brands
 
 /*Which area of business should we focus more on our product development? 
(Branding/taste/availability)
*/

#Availability and unfamiliar with brand for perventing tying 
select Reasons_preventing_trying ,round(count(Reasons_preventing_trying)/100,1) num from fact_survey_responses
group by Reasons_preventing_trying order by num desc

# 24.3 % people gave  response of not available and 18.5 % people response is unfamilar with the brand 

#Reason for choosing brands 
select Reasons_for_choosing_brands , round(count(Reasons_for_choosing_brands)/100,1) num 
from fact_survey_responses group by Reasons_for_choosing_brands order by num desc

# 26.5% people  choosing brands because of brand repuatation ,20.1 % people choosing brands because of taste and 19.1 % choosing because of Availability.

# for taste
select Taste_experience , round(count(Taste_experience)/100,1) num  from fact_survey_responses 
group by Taste_experience order by Taste_experience desc

# here approx 55% are the  people who gave  3 and less then 3 rating which show that product is not good 
