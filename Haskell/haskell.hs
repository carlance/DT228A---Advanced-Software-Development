--Haskell Assignment 
--Submission Date: January-4-2016

-- Question 1

is_square :: Int -> Bool
is_square x = length[sqrt | sqrt <- [1..x], sqrt * sqrt == x] == 1


-- Question 2

alphabet = "abcdefghijklmnopqrstuvwxyz"

qsort :: [(Char,Int)] -> [(Char,Int)]
qsort [] = []
qsort((a,b):xs) = 
	qsort larger ++ [(a,b)] ++ qsort smaller
	where
		smaller = [(c,d) | (c,d) <- xs, d <= b]
		larger = [(e,f) | (e,f) <- xs, f > b]

count_letter :: [Char] -> Char -> Int
count_letter s l = length[x | x <- s, x == l]

freq_letter :: [Char] -> [(Char,Int)]
freq_letter s = qsort[(c,count_letter s c) | c <- alphabet, count_letter s c > 0]


-- Question 3

cities = [(1,"Paris",7000000,1), (2,"London",8000000,2), (1,"Rome",3000000,3), (1,"Edinburgh",500000,2), (1,"Florence",500000,3), (1,"Venice",200000,3), (1,"Lyon",1000000,1),(1,"Milan",5000000,3), (1,"Madrid",6000000,4),(1,"Barcelona",5000000,4)] 
countries = [(1,"UK"), (2,"France"), (3,"Italy"), (4,"Spain")] 

-- Q3 Part A
get_city_above :: Int -> [String]
get_city_above n = 
	[city_name | (id,city_name,population,country_id) <- cities, population > n]

-- Q3 Part B
get_country_id :: [Char] -> Int
get_country_id country_name = 
	head[country_id | (country_id,name) <- countries, country_name == name]

get_city :: [Char] -> [String]
get_city country_name = 
	[city_name | (id,city_name,population,country_id) <- cities, country_id == get_country_id country_name]

-- Q3 Part C
num_city :: [(String,Int)]
num_city = [(country_name,length(get_city country_name)) | (country_id,country_name) <- countries]



-- Question 4
indexed_alphabet = zip " abcdefghijklmnopqrstuvwxyz" [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27]

-- Q4 Part A
get_index_plus_n :: Char -> Int -> Int 
get_index_plus_n letter n = 
	if letter == ' '
	then 1
	else
	head([index | (c,index) <- indexed_alphabet, c == letter]) + n

get_encoded_index :: Char -> Int -> Int
get_encoded_index letter n = 	
	if get_index_plus_n letter n > length(indexed_alphabet)
	then get_index_plus_n letter n - length(indexed_alphabet)
	else get_index_plus_n letter n
	
c_encrypt :: [Char] -> Int -> [Char]
c_encrypt s n = [encoded_letter | letter <- s, (encoded_letter,i) <- indexed_alphabet, i == get_encoded_index letter n]

-- Q4 Part B
get_index_minus_n :: Char -> Int -> Int
get_index_minus_n letter n = 
	if letter == ' '
	then 1
	else
	head([index | (c,index) <- indexed_alphabet, c == letter]) - n

get_decoded_index :: Char -> Int -> Int
get_decoded_index letter n = 
	if get_index_minus_n letter n <= 0
	then get_index_minus_n letter n + length(indexed_alphabet)
	else get_index_minus_n letter n

c_decrypt :: [Char] -> Int -> [Char]
c_decrypt s n = [decoded_letter | letter <- s, (decoded_letter, i) <- indexed_alphabet, i == get_decoded_index letter n]



--Question 5

apply_f_list :: (Int -> Bool) -> [Int] -> [Int]
apply_f_list f a = [b | b <- a, f b]



-- Question 6
get_interval :: Float -> Float -> Int -> Float
get_interval x1 x2 n = (x2 - x1)/a
	where a = fromIntegral n :: Float

f :: Float -> Float
f x = 0.5 * x 

integral :: (Float -> Float) -> Float -> Float -> Int -> Float
integral f x1 x2  n = sum[f (x - interval) * (x - ((x/interval - 1) * interval)) | x <- [x1,(x1+interval)..x2], x > x1]
	where interval = get_interval x1 x2 n
