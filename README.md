# Robot-Simple-Test

Example of a test using robot framework, python customized libraries, and robotframework-selenium2library.

This test case looks, in _lounaat.info_ webpage, for "menus of the day" of given restaurants. The name of the restaurants
are handle as parameters (e.g. RESTAURANT_NAME_1,RESTAURANT_NAME_2,etc), and these names must be set as environment variables.

The found menus are gather and written down in _menu_list.txt_ under _file_resources_ folder

First create python virtual environment

	python -m venv env
	source env/Script/activate

Then install requirements

	pip install -r requirements.txt

Robot test can be run with following command

	robot --outputdir logs/ get_menu.robot
	