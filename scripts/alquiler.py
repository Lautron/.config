#!/sbin/python
import requests
from bs4 import BeautifulSoup
import math
import json
from datetime import datetime
import pyperclip
import subprocess
from datetime import datetime
URL_AGUAS_CORDOBESAS = "https://www.aguascordobesas.com.ar/espacioClientes/seccion/gestionDeuda/consulta/528149"


def get_alquiler():
    url = 'https://arquiler.com/api/calculate'
    headers = {
        'content-type': 'application/json',
        'origin': 'https://arquiler.com'
    }
    data = {
        "value": 90000,
        "initialDate": "2024-02-01T03:00:00.000Z",
        "months": 3,
        "rate": "ipc"
    }

    response = requests.post(url, headers=headers, json=data)
    data = response.json()

    current_date = datetime.now().date()
    percentages = [1 + float(quarter['dif']) /
                   100 for quarter in data['data'][1:] if datetime.strptime(quarter['date'], '%Y-%m-%d').date() <= current_date]
    total_percentage = math.prod(percentages)
    return int(90000 * total_percentage)


def extract_importe(json_string):
    """
    Extracts "Importe $" values from a JSON string containing HTML table.

    Args:
        json_string: A string in JSON format containing HTML data.

    Returns:
        A list of strings representing the "Importe $" values.
        Returns an empty list if no "Importe $" values are found or if there is an error.
    """
    try:
        data_dict = json.loads(json_string)
        html_deuda = data_dict['data']['datosHtmlDeuda']
        soup = BeautifulSoup(html_deuda, 'html.parser')

        importe_values = []
        # Find the table within the "Comprobantes no vencidos" section
        table = soup.find(
            'h3', class_='tit01', string='Comprobantes no vencidos').find_next_sibling('table')

        if table:
            # Find all data rows in the table body
            rows = table.tbody.find_all('tr')
            for row in rows:
                # Find all data cells in each row
                cells = row.find_all('td')
                if len(cells) > 6:  # Check if the row has enough cells (at least 7 for "Importe $")
                    # "Importe $" is the 7th column (index 6)
                    importe_cell = cells[6]
                    importe_value = importe_cell.text.strip()
                    importe_values.append(importe_value)
        return importe_values[0]
    except (json.JSONDecodeError, KeyError, AttributeError):
        # Handle potential errors during JSON parsing, key access, or HTML parsing
        return []


def get_water() -> None:
    url = 'https://www.aguascordobesas.com.ar/espacioClientes/recursos/includesActions/inc_gestionDeuda.php'
    data = {
        'uf': '528149',
        'tu': 'C',
        'token': '8e0be04a6e2df58cd0029fadce5f8f9f',
        'actions': 'get-deuda'
    }

    response = requests.post(url, data=data)
    importe = extract_importe(response.text)
    return int(importe.split(",")[0])


def main() -> None:
    alquiler = get_alquiler()
    water = get_water()
    print(alquiler, water)
    total = alquiler + water
    month = datetime.now().strftime('%b')[:3]
    template = f"""Bachmann, Lautaro
Adrian Beccar Varela N°652 4° A
Liquidación de cuota {month}

Alquiler: ${alquiler}
Agua: ${water}
Total: ${total}

Fuentes:
- https://arquiler.com/
- {URL_AGUAS_CORDOBESAS}
"""
    subprocess.run(["notify-send", "Monto alquiler copiado al portapapeles"])
    pyperclip.copy(template)


if __name__ == "__main__":
    main()
