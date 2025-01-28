import psycopg2
from tkinter import *
from tkinter import ttk
from PIL import Image, ImageTk
import os

root = Tk()
root.title('Więzienia System')
root.geometry("1000x1000")

def log_error(exception, trigger_name):

    print(f"Error: {exception} - Trigger: {trigger_name}")

def connect_db():

    return psycopg2.connect(

        database="postgres",

        user="postgres",

        password="XDhaslo123",

        host="localhost",

        port="5432"

    )

def clear_content():
    for widget in content_frame.winfo_children():
        widget.destroy()

def dodaj_wieznia():
    try:
        conn = connect_db()
        cursor = conn.cursor()

        cursor.execute("SELECT COUNT(*) FROM wiezniowie WHERE id_celi = %s", (entries["Id celi"].get(),))
        cela_count = cursor.fetchone()[0]
        cursor.execute("SELECT COUNT(*) FROM wiezniowie WHERE id_stolowki = %s", (entries["Id stolowki"].get(),))
        stolowka_count = cursor.fetchone()[0]

        cursor.execute("SELECT pojemnosc_celi FROM cele WHERE id_celi = %s", (entries["Id celi"].get(),))
        cela_cap = cursor.fetchone()[0]
        cursor.execute("SELECT pojemnosc_stolowki FROM stolowki WHERE id_stolowki = %s", (entries["Id stolowki"].get(),))
        stolowka_cap = cursor.fetchone()[0]

        if cela_count == cela_cap:
            result_label.config(text="Cela jest pełna! Wybierz inną celę.")
            return
        if stolowka_count == stolowka_cap:
            result_label.config(text="Stołówka jest pełna! Wybierz inną stołówkę.")
            return

        sql = '''INSERT INTO wiezniowie (imie, nazwisko, pseudonim, id_przestepstwa, data_przybycia, wyrok,
        gang, id_celi, id_stolowki, data_wyjscia, adres_zdjecia) VALUES (%s, %s, %s, %s, CURRENT_DATE, %s, %s, %s, %s, NULL, %s)'''
        values = (entries["Imie"].get(), entries["Nazwisko"].get(), entries["Pseudonim"].get(),
                  entries["Id przestepstwa"].get(), entries["Wyrok"].get(), entries["Gang"].get(),
                  entries["Id celi"].get(), entries["Id stolowki"].get(), entries["Sciezka do zdjecia"].get())
        cursor.execute(sql, values)
        conn.commit()
        conn.close()
        wyswietl_obecnych_wiezniow()
        result_label.config(text="Więzień dodany pomyślnie.")
    except Exception as e:
        log_error(e, "dodaj_wieznia")
        result_label.config(text="Błąd dodawania więźnia!")

def wyswietl_obecnych_wiezniow():

    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM wiezniowie w WHERE w.data_wyjscia IS NULL")
    records = cursor.fetchall()
    conn.close()
    update_table(records)


def wyswietl_bylych_wiezniow():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM wiezniowie w WHERE w.data_wyjscia IS NOT NULL")
    records = cursor.fetchall()
    conn.close()
    update_table(records)

'''def wypusc_wieznia():
    id_wieznia = release_entry.get()
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE wiezniowie SET data_wyjscia = CURRENT_DATE WHERE id_wieznia = %s AND data_wyjscia IS NULL",
        (id_wieznia,)
    )
    conn.commit()
    conn.close()
    wyswietl_obecnych_wiezniow()
      except Exception as e:
        log_error(e, "wypusc_wieznia")
        result_label.config(text="Jeszcze za wczesnie zeby wypuscic wieznia!")'''
   

def szukaj_wieznia():
    typ = search_type.get()
    wartosc = search_entry.get()
    conn = connect_db()
    cursor = conn.cursor()
    sql = f"SELECT * FROM wiezniowie WHERE {typ} = %s"
    cursor.execute(sql, (wartosc,))
    records = cursor.fetchall()
    conn.close()
    update_table(records)

def update_table(records):

    tree.delete(*tree.get_children())
    for record in records:
        img_path = record[-1]  
        if os.path.exists(img_path):
            img = Image.open(img_path).resize((50, 50))
            img = ImageTk.PhotoImage(img)
        else:
            img = None
    
        tree.insert("", "end", values=record[:-1] + (img,))
        
def zmien_cela():
    id_wieznia = cell_id_entry.get()
    nowa_cela = new_cell_entry.get()
    conn = connect_db()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "UPDATE wiezniowie SET id_celi = %s WHERE id_wieznia = %s",
            (nowa_cela, id_wieznia)
        )
        conn.commit()
        result_label.config(text="Cela zmieniona pomyślnie")
    except psycopg2.Error as e:
        result_label.config(text=f"Błąd: {e}")
    conn.close()
    wyswietl_obecnych_wiezniow()  
    
    

def wypusc_wieznia():

    id_wieznia = release_entry.get().strip()

    if not id_wieznia:

        result_label.config(text="Podaj ID więźnia!")

        return



    try:

        conn = connect_db()
        cursor = conn.cursor()
        cursor.execute(
            "UPDATE wiezniowie SET data_wyjscia = CURRENT_DATE WHERE id_wieznia = %s AND data_wyjscia IS NULL",
            (id_wieznia,)
        )
        conn.commit()
        conn.close()
        wyswietl_obecnych_wiezniow()
        result_label.config(text=f"Więzień {id_wieznia} został zwolniony.")

    except Exception as e:
        log_error(e, "wypusc_wieznia")
        result_label.config(text="Błąd przy zwalnianiu więźnia!")


# GUI Setup

def pokaz_wiezniow():
    clear_content()

    global entries  
    my_frame = LabelFrame(content_frame, text="Dane więźnia")
    my_frame.pack(pady=20)

    fields = ["Imie", "Nazwisko", "Pseudonim", "Id przestepstwa", "Wyrok", "Gang", "Id celi", "Id stolowki", "Sciezka do zdjecia"]
    entries = {}

    for i, field in enumerate(fields):
        Label(my_frame, text=f"{field}: ").grid(row=i, column=0, pady=5, padx=10)
        entry = Entry(my_frame)
        entry.grid(row=i, column=1, pady=5, padx=10)
        entries[field] = entry  

    Button(my_frame, text="Dodaj więźnia", command=dodaj_wieznia).grid(row=10, column=0, pady=10, padx=10)
    Button(my_frame, text="Wyświetl obecnych", command=wyswietl_obecnych_wiezniow).grid(row=11, column=0, pady=10, padx=10)
    Button(my_frame, text="Wyświetl byłych", command=wyswietl_bylych_wiezniow).grid(row=11, column=1, pady=10, padx=10)

    # Search prisoner section
    search_frame = LabelFrame(content_frame, text="Szukaj więźnia")
    search_frame.pack(pady=10)

    search_type = StringVar(value="nazwisko")
    Label(search_frame, text="Szukaj według:").pack(side=LEFT, padx=5)
    OptionMenu(search_frame, search_type, "imie", "nazwisko", "id_celi", "id_przestepstwa").pack(side=LEFT)
    search_entry = Entry(search_frame)
    search_entry.pack(side=LEFT, padx=5)
    Button(search_frame, text="Szukaj", command=szukaj_wieznia).pack(side=LEFT, padx=5)

    # Update Release Date Section
    release_frame = LabelFrame(content_frame, text="Zmień datę wyjścia")
    release_frame.pack(pady=10)

    Label(release_frame, text="ID więźnia:").pack(side=LEFT, padx=5)
    release_entry = Entry(release_frame)
    release_entry.pack(side=LEFT, padx=5)
    Button(release_frame, text="Wypuść więźnia", command=wypusc_wieznia).pack(pady=10, padx=10)

    # Change Cell Section
    cell_frame = LabelFrame(content_frame, text="Zmień celę więźnia")
    cell_frame.pack(pady=10)

    Label(cell_frame, text="ID więźnia:").pack(side=LEFT, padx=5)
    cell_id_entry = Entry(cell_frame)
    cell_id_entry.pack(side=LEFT, padx=5)

    Label(cell_frame, text="Nowa cela:").pack(side=LEFT, padx=5)
    new_cell_entry = Entry(cell_frame)
    new_cell_entry.pack(side=LEFT, padx=5)

    Button(cell_frame, text="Zmień celę", command=zmien_cela).pack(side=LEFT, padx=5)

    # Result label
    result_label = Label(content_frame, text="")
    result_label.pack()

    wyswietl_obecnych_wiezniow()





    
def pokaz_straznikow():
    clear_content()
    
    global tree  # Re-declare tree so it can be reused globally
    tree = ttk.Treeview(content_frame, columns=("ID", "Imie", "Nazwisko", "Stanowisko"), show="headings")
    tree.heading("ID", text="ID")
    tree.heading("Imie", text="Imie")
    tree.heading("Nazwisko", text="Nazwisko")
    tree.heading("Stanowisko", text="Stanowisko")
    tree.pack(side=RIGHT, fill=BOTH, expand=True)
    
    scrollbar = Scrollbar(content_frame, orient="vertical", command=tree.yview)
    scrollbar.pack(side=RIGHT, fill=Y)
    tree.configure(yscrollcommand=scrollbar.set)
    
    try:
        conn = connect_db()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM straznicy")  # Ensure correct column names
        records = cursor.fetchall()
        conn.close()
        update_table(records)
    except Exception as e:
        log_error(e, "pokaz_pracownikow")
        
def pokaz_pracownikow():
    clear_content()
    
    global tree  # Re-declare tree so it can be reused globally
    tree = ttk.Treeview(content_frame, columns=("ID", "Imie", "Nazwisko", "Stanowisko"), show="headings")
    tree.heading("ID", text="ID")
    tree.heading("Imie", text="Imie")
    tree.heading("Nazwisko", text="Nazwisko")
    tree.heading("Stanowisko", text="Stanowisko")
    tree.pack(side=RIGHT, fill=BOTH, expand=True)
    
    scrollbar = Scrollbar(content_frame, orient="vertical", command=tree.yview)
    scrollbar.pack(side=RIGHT, fill=Y)
    tree.configure(yscrollcommand=scrollbar.set)
    
    try:
        conn = connect_db()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM lista_pracownikow")  # Ensure correct column names
        records = cursor.fetchall()
        conn.close()
        update_table(records)
    except Exception as e:
        log_error(e, "pokaz_pracownikow")

        
def pokaz_zmiany():
    clear_content()
    
    global tree  # Re-declare tree so it can be reused globally
    tree = ttk.Treeview(content_frame, columns=("ID", "Imie", "Nazwisko", "Stanowisko"), show="headings")
    tree.heading("ID", text="ID")
    tree.heading("Imie", text="Imie")
    tree.heading("Nazwisko", text="Nazwisko")
    tree.heading("Stanowisko", text="Stanowisko")
    tree.pack(side=RIGHT, fill=BOTH, expand=True)
    
    scrollbar = Scrollbar(content_frame, orient="vertical", command=tree.yview)
    scrollbar.pack(side=RIGHT, fill=Y)
    tree.configure(yscrollcommand=scrollbar.set)
    
    try:
        conn = connect_db()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM zmiany_braki")  # Ensure correct column names
        records = cursor.fetchall()
        conn.close()
        update_table(records)
    except Exception as e:
        log_error(e, "pokaz_pracownikow")
        
        
def pokaz_finanse():
    clear_content()
    
    global tree  # Re-declare tree so it can be reused globally
    tree = ttk.Treeview(content_frame, columns=("ID", "Imie", "Nazwisko", "Stanowisko"), show="headings")
    tree.heading("ID", text="ID")
    tree.heading("Imie", text="Imie")
    tree.heading("Nazwisko", text="Nazwisko")
    tree.heading("Stanowisko", text="Stanowisko")
    tree.pack(side=RIGHT, fill=BOTH, expand=True)
    
    scrollbar = Scrollbar(content_frame, orient="vertical", command=tree.yview)
    scrollbar.pack(side=RIGHT, fill=Y)
    tree.configure(yscrollcommand=scrollbar.set)
    
    try:
        conn = connect_db()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM wydatki")  # Ensure correct column names
        records = cursor.fetchall()
        conn.close()
        update_table(records)
    except Exception as e:
        log_error(e, "pokaz_pracownikow")
        
        
def pokaz_przestepstwa():
    clear_content()
    
    global tree  # Re-declare tree so it can be reused globally
    tree = ttk.Treeview(content_frame, columns=("ID", "Imie", "Nazwisko", "Stanowisko"), show="headings")
    tree.heading("ID", text="ID")
    tree.heading("Imie", text="Imie")
    tree.heading("Nazwisko", text="Nazwisko")
    tree.heading("Stanowisko", text="Stanowisko")
    tree.pack(side=RIGHT, fill=BOTH, expand=True)
    
    scrollbar = Scrollbar(content_frame, orient="vertical", command=tree.yview)
    scrollbar.pack(side=RIGHT, fill=Y)
    tree.configure(yscrollcommand=scrollbar.set)
    
    try:
        conn = connect_db()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM przestepstwa")  # Ensure correct column names
        records = cursor.fetchall()
        conn.close()
        update_table(records)
    except Exception as e:
        log_error(e, "pokaz_pracownikow")
        
        
def pokaz_sale():
    clear_content()
    
    global tree  # Re-declare tree so it can be reused globally
    tree = ttk.Treeview(content_frame, columns=("ID", "Imie", "Nazwisko", "Stanowisko"), show="headings")
    tree.heading("ID", text="ID")
    tree.heading("Imie", text="Imie")
    tree.heading("Nazwisko", text="Nazwisko")
    tree.heading("Stanowisko", text="Stanowisko")
    tree.pack(side=RIGHT, fill=BOTH)
    
    scrollbar = Scrollbar(content_frame, orient="vertical", command=tree.yview)
    scrollbar.pack(side=RIGHT, fill=Y)
    tree.configure(yscrollcommand=scrollbar.set)
    
    try:
        conn = connect_db()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM oblozenie_cele")  # Ensure correct column names
        records = cursor.fetchall()
        conn.close()
        update_table(records)
    except Exception as e:
        log_error(e, "pokaz_pracownikow")
        
    global tree2  # Re-declare tree so it can be reused globally
    tree2 = ttk.Treeview(content_frame, columns=("ID", "Imie", "Nazwisko", "Stanowisko"), show="headings")
    tree2.heading("ID", text="ID")
    tree2.heading("Imie", text="Imie")
    tree2.heading("Nazwisko", text="Nazwisko")
    tree2.heading("Stanowisko", text="Stanowisko")
    tree2.pack(side=LEFT, fill=BOTH)
    
    scrollbar = Scrollbar(content_frame, orient="vertical", command=tree2.yview)
    scrollbar.pack(side=RIGHT, fill=Y)
    tree2.configure(yscrollcommand=scrollbar.set)
    
    try:
        conn = connect_db()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM oblozenie_stolowki")  # Ensure correct column names
        records = cursor.fetchall()
        conn.close()
        update_table(records)
    except Exception as e:
        log_error(e, "pokaz_pracownikow")
        
        
def pokaz_placowki():
    clear_content()
    
    global tree  # Re-declare tree so it can be reused globally
    tree = ttk.Treeview(content_frame, columns=("ID", "Imie", "Nazwisko", "Stanowisko"), show="headings")
    tree.heading("ID", text="ID")
    tree.heading("Imie", text="Imie")
    tree.heading("Nazwisko", text="Nazwisko")
    tree.heading("Stanowisko", text="Stanowisko")
    tree.pack(side=RIGHT, fill=BOTH, expand=True)
    
    scrollbar = Scrollbar(content_frame, orient="vertical", command=tree.yview)
    scrollbar.pack(side=RIGHT, fill=Y)
    tree.configure(yscrollcommand=scrollbar.set)
    
    try:
        conn = connect_db()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM placowki")  # Ensure correct column names
        records = cursor.fetchall()
        conn.close()
        update_table(records)
    except Exception as e:
        log_error(e, "pokaz_pracownikow")

def pokaz_magazyny():
    clear_content()
    
    global tree  # Re-declare tree so it can be reused globally
    tree = ttk.Treeview(content_frame, columns=("ID", "Imie", "Nazwisko", "Stanowisko"), show="headings")
    tree.heading("ID", text="ID")
    tree.heading("Imie", text="Imie")
    tree.heading("Nazwisko", text="Nazwisko")
    tree.heading("Stanowisko", text="Stanowisko")
    tree.pack(side=RIGHT, fill=BOTH)
    
    scrollbar = Scrollbar(content_frame, orient="vertical", command=tree.yview)
    scrollbar.pack(side=RIGHT, fill=Y)
    tree.configure(yscrollcommand=scrollbar.set)
    
    try:
        conn = connect_db()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM magazyny")  # Ensure correct column names
        records = cursor.fetchall()
        conn.close()
        update_table(records)
    except Exception as e:
        log_error(e, "pokaz_pracownikow")

    global tree2  # Re-declare tree so it can be reused globally
    tree2 = ttk.Treeview(content_frame, columns=("ID", "Imie", "Nazwisko", "Stanowisko"), show="headings")
    tree2.heading("ID", text="ID")
    tree2.heading("Imie", text="Imie")
    tree2.heading("Nazwisko", text="Nazwisko")
    tree2.heading("Stanowisko", text="Stanowisko")
    tree2.pack(side=LEFT, fill=BOTH)
    
    scrollbar = Scrollbar(content_frame, orient="vertical", command=tree2.yview)
    scrollbar.pack(side=RIGHT, fill=Y)
    tree2.configure(yscrollcommand=scrollbar.set)
    
    try:
        conn = connect_db()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM magazyny")  # Ensure correct column names
        records = cursor.fetchall()
        conn.close()
        update_table(records)
    except Exception as e:
        log_error(e, "pokaz_pracownikow")



# Sidebar menu
side_menu = Frame(root, width=200, bg='gray')
side_menu.pack(side=LEFT, fill=Y)

Button(side_menu, text="Placówki", command=pokaz_placowki).pack(pady=5)
Button(side_menu, text="Przestępstwa", command=pokaz_przestepstwa).pack(pady=5)
Button(side_menu, text="Więźniowie", command=pokaz_wiezniow).pack(pady=5)
Button(side_menu, text="Pracownicy (w)", command=pokaz_pracownikow).pack(pady=5)
Button(side_menu, text="Magazyny", command=pokaz_magazyny).pack(pady=5)
Button(side_menu, text="Sale (w)", command=pokaz_cele).pack(pady=5)
Button(side_menu, text="Finanse (w)", command=pokaz_finanse).pack(pady=5)
Button(side_menu, text="Zmiany Strażników (w)", command=pokaz_zmiany).pack(pady=5)



# Content frame
content_frame = Frame(root)
content_frame.pack(side=RIGHT, expand=True, fill=BOTH)

# Prisoner list table
tree = ttk.Treeview(content_frame, columns=("ID", "Imie", "Nazwisko", "Wyrok", "Zdjęcie"), show="headings")
tree.heading("ID", text="ID")
tree.heading("Imie", text="Imie")
tree.heading("Nazwisko", text="Nazwisko")
tree.heading("Wyrok", text="Wyrok")
tree.heading("Zdjęcie", text="Zdjęcie")
tree.pack(side=RIGHT, fill=BOTH, expand=True)

scrollbar = Scrollbar(content_frame, orient="vertical", command=tree.yview)
scrollbar.pack(side=RIGHT, fill=Y)
tree.configure(yscrollcommand=scrollbar.set)

root.mainloop()
