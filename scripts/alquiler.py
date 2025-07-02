#!/sbin/python
import requests
from bs4 import BeautifulSoup
import math
import json
from datetime import datetime
import pyperclip
import subprocess
import webbrowser
import threading

URL_AGUAS_CORDOBESAS = "https://www.aguascordobesas.com.ar/espacioClientes/seccion/gestionDeuda/consulta/528149"
RENTAS_NUM_CUENTA = "110123133951"
MUNICIPALIDAD_NUM_CUENTA = "300406701000013"

# Global variables to store results
rentas_result = 0
muni_result = 0
alquiler_result = 0
water_result = 0


def get_alquiler():
    global alquiler_result
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
    alquiler_result = int(90000 * total_percentage)


def extract_importe(json_string):
    try:
        data_dict = json.loads(json_string)
        html_deuda = data_dict['data']['datosHtmlDeuda']
        soup = BeautifulSoup(html_deuda, 'html.parser')

        importe_values = []
        table = soup.find(
            'h3', class_='tit01', string='Comprobantes no vencidos').find_next_sibling('table')

        if table:
            rows = table.tbody.find_all('tr')
            for row in rows:
                cells = row.find_all('td')
                if len(cells) > 6:
                    importe_cell = cells[6]
                    importe_value = importe_cell.text.strip()
                    importe_values.append(importe_value)
        return importe_values[0]
    except (json.JSONDecodeError, KeyError, AttributeError):
        return []


def get_water() -> None:
    global water_result
    url = 'https://www.aguascordobesas.com.ar/espacioClientes/recursos/includesActions/inc_gestionDeuda.php'
    data = {
        'uf': '528149',
        'tu': 'C',
        'token': '8e0be04a6e2df58cd0029fadce5f8f9f',
        'actions': 'get-deuda'
    }

    response = requests.post(url, data=data)
    importe = extract_importe(response.text)
    water_result = int(importe.split(",")[0])


def get_with_browser(url, value_to_copy, msg) -> str:
    webbrowser.open(url)
    pyperclip.copy(value_to_copy)
    subprocess.run(["notify-send", "Numero de cuenta copiado al portapapeles"])
    result = input(msg)
    return result


def get_rentas() -> None:
    global rentas_result
    result = get_with_browser(
        "https://www.rentascordoba.gob.ar/emision/ver-y-pagar/inmobiliario",
        RENTAS_NUM_CUENTA,
        "Paste Rentas amount:"
    )
    rentas_result = int(result.replace(".", "").replace("$", ""))


def get_muni() -> None:
    global muni_result
    result = get_with_browser(
        "https://tributariomuni.gob.ar/samweb/index.php?r=objeto%2Fobjeto%2Findex&to=1",
        MUNICIPALIDAD_NUM_CUENTA,
        "Paste Muni amount:"
    )
    muni_result = int(result.replace(".", "").split(",")[0])


def get_rentas_and_muni():
    get_rentas()
    get_muni()


def main() -> None:
    # Create threads for each function
    threads = []
    # Rentas and Muni on the same thread
    threads.append(threading.Thread(target=get_rentas_and_muni))
    # Alquiler on a separate thread
    threads.append(threading.Thread(target=get_alquiler))
    # Water on a separate thread
    threads.append(threading.Thread(target=get_water))

    # Start all threads
    for thread in threads:
        thread.start()

    # Wait for all threads to complete
    for thread in threads:
        thread.join()

    total = sum([
        alquiler_result,
        water_result,
        rentas_result,
        muni_result,
    ])
    month = datetime.now().strftime('%b')[:3]
    template = f"""Bachmann, Lautaro
Adrian Beccar Varela N°652 4° A
Liquidación de cuota {month}

Alquiler: ${alquiler_result}
Agua: ${water_result}
Rentas Cordoba: ${rentas_result}
Muni Cordoba: ${muni_result}

Total: ${total}
"""
    subprocess.run(["notify-send", "Monto alquiler copiado al portapapeles"])
    pyperclip.copy(template)


if __name__ == "__main__":
    main()
