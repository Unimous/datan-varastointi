from flask import Flask, request, jsonify
import db

app = Flask(__name__, static_url_path='')
app.config['JSON_AS_ASCII'] = False

@app.route('/')
def home():
	message = {
		'status': 200,
		'message': 'Hello from Company!' ,
    }
	resp = jsonify(message)
	resp.status_code = 200    
	return resp	

@app.route('/employees', methods=['GET'])
def employees():
	try:
		conn = db.createConnetion()
		cursor = conn.cursor()
		sql = """
            SELECT fname, lname, 
	            CAST(bdate AS char) as bdate, 
		        salary, phone1  
	        FROM employee
            ORDER BY lname
        """
		cursor.execute(sql)
		rows = cursor.fetchall()
		cursor.close() 
		conn.close()
		resp = jsonify(rows)
		resp.status_code = 200
		return resp
	except Exception as e:
		message = {
        	'status': 500,
        	'message': f'{e}'
    	}
		resp = jsonify(message)
		resp.status_code = 500
		return resp		
	
@app.route('/departments', methods=['GET'])
def departments():
	try:
		conn = db.createConnetion()
		cursor = conn.cursor()
		sql = """
            SELECT name  
	        FROM department
            ORDER BY id
        """
		cursor.execute(sql)
		rows = cursor.fetchall()
		cursor.close() 
		conn.close()
		resp = jsonify(rows)
		resp.status_code = 200
		return resp
	except Exception as e:
		message = {
        	'status': 500,
        	'message': f'{e}'
    	}
		resp = jsonify(message)
		resp.status_code = 500
		return resp		

@app.route('/projects', methods=['GET'])
def projects():
	try:
		conn = db.createConnetion()
		cursor = conn.cursor()
		sql = """
            SELECT *  
	        FROM project
            ORDER BY id
        """
		cursor.execute(sql)
		rows = cursor.fetchall()
		cursor.close() 
		conn.close()
		resp = jsonify(rows)
		resp.status_code = 200
		return resp
	except Exception as e:
		message = {
        	'status': 500,
        	'message': f'{e}'
    	}
		resp = jsonify(message)
		resp.status_code = 500
		return resp	

@app.route('/works-on', methods=['GET'])
def worksOn():
	try:
		conn = db.createConnetion()
		cursor = conn.cursor()
		sql = """
            SELECT 	employee.fname 
					, employee.lname
					, project.name AS "project"  
					, hours
	        FROM works_on
			INNER JOIN employee 
			ON works_on.employee_id = employee.id
			INNER JOIN project
			ON works_on.project_id = project.id
            ORDER BY employee.id
        """
		cursor.execute(sql)
		rows = cursor.fetchall()
		cursor.close() 
		conn.close()
		resp = jsonify(rows)
		resp.status_code = 200
		return resp
	except Exception as e:
		message = {
        	'status': 500,
        	'message': f'{e}'
    	}
		resp = jsonify(message)
		resp.status_code = 500
		return resp	

@app.route('/parts', methods=['GET'])
def parts():
	try:
		conn = db.createConnetion()
		cursor = conn.cursor()
		sql = """
            SELECT *  
	        FROM part
            ORDER BY id
        """
		cursor.execute(sql)
		rows = cursor.fetchall()
		cursor.close() 
		conn.close()
		resp = jsonify(rows)
		resp.status_code = 200
		return resp
	except Exception as e:
		message = {
        	'status': 500,
        	'message': f'{e}'
    	}
		resp = jsonify(message)
		resp.status_code = 500
		return resp	

@app.route('/part-of', methods=['GET'])
def partOf():
	try:
		conn = db.createConnetion()
		cursor = conn.cursor()
		sql = """
            SELECT 	part_of.part_id
					, GROUP_CONCAT(
						CONCAT(
							part.name
							, ': '
							, part_of.quantity
						)
						SEPARATOR ', '
					) AS parts
	        FROM part_of 
			INNER JOIN part
			on part_of.compart_id = part.id
			GROUP BY part_id
        """
		
		cursor.execute(sql)
		rows = cursor.fetchall()
		cursor.close() 
		conn.close()
		resp = jsonify(rows)
		resp.status_code = 200
		return resp
	except Exception as e:
		message = {
        	'status': 500,
        	'message': f'{e}'
    	}
		resp = jsonify(message)
		resp.status_code = 500
		return resp

@app.errorhandler(404)
def not_found(error=None):
    message = {
        'status': 404,
        'message': 'Not Found: ' + request.url,
    }
    resp = jsonify(message)
    resp.status_code = 404    
    return resp
		
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
