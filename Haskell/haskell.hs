--Haskell Assignment 
--Submission Date: January-4-2016
--Student Number: C10309107

import Data.Char --Data Char library import

-- Question 1


is_square :: Int -> Bool
is_square x = length[square | square <- [1..x], square * square == x] == 1 


-- Question 2

qsort :: [(Char,Int)] -> [(Char,Int)] --Quick sort algorithm in descending order
qsort [] = []
qsort((a,b):xs) = 
	qsort larger ++ [(a,b)] ++ qsort smaller
	where
		smaller = [(c,d) | (c,d) <- xs, d <= b]
		larger = [(e,f) | (e,f) <- xs, f > b]

count_letter :: Char -> String -> Int
count_letter c s = length [c' | c' <- s, c == c']

freq_letter :: String -> [(Char,Int)]
freq_letter s = qsort[(c,count_letter c s) | c <- ['a'..'z'], count_letter c s > 0]


-- Question 3

qsort1 :: [(Char,Float)] -> [(Char,Float)] --Quick sort algorithm in descending order
qsort1 [] = []
qsort1((a,b):xs) = 
	qsort1 larger ++ [(a,b)] ++ qsort1 smaller
	where
		smaller = [(c,d) | (c,d) <- xs, d <= b]
		larger = [(e,f) | (e,f) <- xs, f > b]


percent :: Int -> Int -> Float
percent n m = (fromIntegral n / fromIntegral m) * 100 --converts frequency to percentage

letter :: String -> Int 
letter s = length [c | c <- s, isLetter c] --ignores spaces and gets length of string

freq_letter_pc :: String -> [(Char,Float)]
freq_letter_pc s =  qsort1[(c,percent(count_letter c s) n) | c <- ['a'..'z'], count_letter c s > 0]
					where n = letter s
				

-- Question 4

cities = [(1,"Paris",7000000,1),(2,"London",8000000,2),(1,"Rome",3000000,3), (1,"Edinburgh",500000,2),(1,"Florence",500000,3),(1,"Venice",200000,3), (1,"Lyon",1000000,1),(1,"Milan",5000000,3),(1,"Madrid",6000000,4),(1,"Barcelona",5000000,4)]
countries = [(1,"France"), (2,"UK"),(3,"Italy"), (4,"Spain")] 

-- Q4 Part A
get_city_above :: Int -> [String]
get_city_above n = 
	[city_name | (id,city_name,population,country_id) <- cities, population > n]

-- Q4 Part B
get_country_id :: String -> Int
get_country_id country_name = 
	head[country_id | (country_id,name) <- countries, country_name == name]

get_city :: String -> [String]
get_city country_name = 
	[city_name | (id,city_name,population,country_id) <- cities, country_id == get_country_id country_name]

-- Q4 Part C
num_city :: [(String,Int)]
num_city = [(country_name,length(get_city country_name)) | (country_id,country_name) <- countries]



-- Question 5
indexed_alphabet = zip "abcdefghijklmnopqrstuvwxyz " [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27]

-- Q5 Part A
get_index_plus_n :: Char -> Int -> Int 
get_index_plus_n letter n = 
	if letter == ' '
	then 27 --last element of list is empty 
	else
	head([index | (c,index) <- indexed_alphabet, c == letter]) + n

get_encoded_index :: Char -> Int -> Int
get_encoded_index letter n = 	
	if get_index_plus_n letter n > length(indexed_alphabet)
	then get_index_plus_n letter n - length(indexed_alphabet)
	else get_index_plus_n letter n
	
c_encrypt :: [Char] -> Int -> [Char]
c_encrypt s n = [encoded_letter | letter <- s, (encoded_letter,i) <- indexed_alphabet, i == get_encoded_index letter n]

-- Q5 Part B
get_index_minus_n :: Char -> Int -> Int
get_index_minus_n letter n = 
	if letter == ' '
	then 27 --last element of list is empty 
	else
	head([index | (c,index) <- indexed_alphabet, c == letter]) - n

get_decoded_index :: Char -> Int -> Int
get_decoded_index letter n = 
	if get_index_minus_n letter n <= 0
	then get_index_minus_n letter n + length(indexed_alphabet)
	else get_index_minus_n letter n

c_decrypt :: [Char] -> Int -> [Char]
c_decrypt s n = [decoded_letter | letter <- s, (decoded_letter, i) <- indexed_alphabet, i == get_decoded_index letter n]



--Question 6

distance :: [Float] -> [Float] -> Float
distance as bs = sqrt (distance as bs)

  where	distance [] _          = 0
        distance _ []          = 0
        -------(Head:Tail)
        distance (p:ps) (q:qs) = ((p - q)^2 + distance ps qs)




-- Question 8

get_interval :: Double -> Double -> Int -> Double
get_interval x1 x2 n = (x2 - x1)/a
	where a = fromIntegral n :: Double

f :: Double -> Double
f x = 0.5 * x 

integral :: (Double -> Double) -> Double -> Double -> Int -> Double
integral f x1 x2  n = sum[f (x - interval) * (x - ((x/interval - 1) * interval)) | x <- [x1,(x1+interval)..x2], x > x1]
	where interval = get_interval x1 x2 n
