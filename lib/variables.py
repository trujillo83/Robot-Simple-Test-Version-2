HOMEPAGE = "https://www.lounaat.info/"
BROWSER = "Chrome"
ID_CONTENT = "//*[@id=\"content\"]/div/div[1]/div/div/section[2]/div/div/div[1]/div/div/div[9]"
PATH_FILE_TO_WRITE = "${CURDIR}/../file_resources/menus_list.txt"
#LIST_OF_RESTAURANTS = ["sodexo hermia 6", "antell hermian farmi", "Nekalan Patakunkku", "Il posto hervanta"]
#RESTAURANT_NAME_1 = "sodexo hermia 6"
#RESTAURANT_NAME_2 = "antell hermian farmi"
#RESTAURANT_NAME_3 = "Nekalan Patakunkku"
#RESTAURANT_NAME_4 = "Il posto hervanta"
#LIST_OF_RESTAURANTS = ["${RESTAURANT_NAME_1}", "${RESTAURANT_NAME_2}", "${RESTAURANT_NAME_3}", "${RESTAURANT_NAME_4}"]
LIST_OF_RESTAURANTS = [${RESTAURANT_NAME_1}, ${RESTAURANT_NAME_2}, ${RESTAURANT_NAME_3}, ${RESTAURANT_NAME_4}]
