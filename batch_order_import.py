import csv
import json
import sys
import requests
import base64


items_error = []
client_id = 'b96ee34f11ab48b69889c9392a4734ed'
client_secret = 'MzMxMjNjYjEtOTUxZS00NTc1LWE2YzgtMmRkNGNmZTczYjli'

# Get orders json array from csv file
def get_orders(csvFile):
    orders_array = []
    input_file = csv.DictReader(open(csvFile,'r'))
    for row in input_file:
        orders_array.append(row)

    return orders_array

#Send orders to ORDS
def send_orders():
	for item in orders:
		send_order(item)
	
def send_order(order):
	order_id = order['Id']
	url = 'https://data.aboca.com/ords/shopify/orders/' + order_id
	authorization = {'Authorization': 'Basic ' + access_token}

	response = requests.post(url, data = order, headers = authorization)

	if(response.status_code == 403):
		global access_token
		access_token = request_token()
		send_order(order)
	elif(response.status_code == 200):
		print('Order ' + order_id + ' registered')
	else:
		items_error.append(order)
		print('Order ' + order_id + ' registered')

def request_token():
	print('Requesting token')
	url = 'https://data.aboca.com/ords/oauth/token'
	body =	{ 'grant_type' : 'client_credentials',
			  'client_id' : client_id,
			  'clien_secret' : client_secret
			}

	message = client_id + ':' + client_secret
	message_bytes = message.encode('ascii')
	base64_bytes = base64.b64encode(message_bytes)
	
	authorization = {'Authorization': 'Basic ' + base64_bytes}

	response = requests.post(url, data = body, headers = authorization)
	body = response.json()
	access_token = body['access_token']
	print('Access_token = ' + access_token)
	return access_token


def save_items_error():
	#items_error_json = open(errorItemsPath, "w")
	#items_error_json.write(json.dumps(itemError, indent=4))

	items_error_file = open('items_error', "w")
	items_error_file.write(json.dumps(items_error, indent=4))


orders = get_orders('orders_export.csv')
access_token = request_token()
send_orders()
save_items_error()