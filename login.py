import tkinter as tk
from tkinter import messagebox
import db
from utilidades import MainMenu

class LoginWindow:
    def __init__(self, root):
        self.root = root
        self.root.title("Punto de Venta")
        self.root.configure(bg="#f0f0f0")

        self.frame = tk.Frame(root, bg="white", bd=2, relief="groove")
        self.frame.pack(padx=40, pady=60, ipadx=20, ipady=20)

        tk.Label(self.frame, text="Usuario", bg="white", font=("Segoe UI", 10)).grid(row=0, column=0, pady=10, padx=10, sticky="e")
        tk.Label(self.frame, text="Contraseña", bg="white", font=("Segoe UI", 10)).grid(row=1, column=0, pady=10, padx=10, sticky="e")

        self.usuario = tk.Entry(self.frame, font=("Segoe UI", 10))
        self.usuario.grid(row=0, column=1, padx=10)

        self.contrasena = tk.Entry(self.frame, show="*", font=("Segoe UI", 10))
        self.contrasena.grid(row=1, column=1, padx=10)

        self.btn_ingresar = tk.Button(self.frame, text="Ingresar", width=20, bg="#007acc", fg="white", font=("Segoe UI", 10, "bold"), relief="flat", command=self.login)
        self.btn_ingresar.grid(row=2, column=0, columnspan=2, pady=20)

        # Efecto hover para el botón
        self.btn_ingresar.bind("<Enter>", lambda e: self.btn_ingresar.config(bg="#005a9e"))
        self.btn_ingresar.bind("<Leave>", lambda e: self.btn_ingresar.config(bg="#007acc"))

    def login(self):
        user = self.usuario.get()
        pwd = self.contrasena.get()
        con = db.crear_conexion()
        cur = con.cursor(dictionary=True)
        cur.execute("SELECT u.*, e.nombre as empleado FROM usuarios u JOIN empleados e ON u.id_empleado=e.id_empleado WHERE username=%s AND password=%s", (user, pwd))
        usuario = cur.fetchone()
        con.close()
        if usuario:
            self.frame.destroy()
            MainMenu(self.root, usuario)
        else:
            messagebox.showerror("Error", "Usuario o contraseña incorrectos")
