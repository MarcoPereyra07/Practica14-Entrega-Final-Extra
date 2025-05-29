import tkinter as tk
from productos import ProductosCRUD
from categorias import CategoriasCRUD
from proveedores import ProveedoresCRUD
from clientes import ClientesCRUD
from ventas import VentasCRUD
from compras import ComprasCRUD
from empleados import EmpleadosCRUD
from usuarios import UsuariosCRUD
from inventario import InventarioCRUD
from unidades import UnidadesCRUD
from detalle_compras import DetalleComprasCRUD
from detalle_ventas import DetalleVentasCRUD
from pagos_historial import PagosHistorialWindow  # <--- Importa el historial de pagos

class MainMenu:
    def __init__(self, root, usuario):
        self.root = root
        self.usuario = usuario
        self.root.configure(bg="#f0f0f0")  # Fondo general
        self.frame = tk.Frame(root, bg="white", bd=2, relief="ridge")
        self.frame.pack(expand=True, padx=30, pady=30, ipadx=20, ipady=20)

        tk.Label(self.frame, text=f"Bienvenido {usuario['empleado']}", font=("Segoe UI", 14, "bold"), bg="white", fg="#333").pack(pady=10)

        botones = [
            ("Productos", ProductosCRUD),
            ("Categorías", CategoriasCRUD),
            ("Proveedores", ProveedoresCRUD),
            ("Clientes", ClientesCRUD),
            ("Ventas", VentasCRUD),
            ("Compras", ComprasCRUD),
            ("Empleados", EmpleadosCRUD),
            ("Usuarios", UsuariosCRUD),
            ("Inventario", InventarioCRUD),
            ("Unidades", UnidadesCRUD),
            ("Historial Pagos", PagosHistorialWindow),  # <--- Agrega aquí el historial
            ("Detalle Compras", DetalleComprasCRUD),
            ("Detalle Ventas", DetalleVentasCRUD)
        ]

        for texto, clase in botones:
            btn = tk.Button(
                self.frame, text=texto, width=25,
                font=("Segoe UI", 10, "bold"), bg="#007acc", fg="white", relief="flat",
                command=lambda c=clase: self.abrir_modulo(c)
            )
            btn.pack(pady=3)
            btn.bind("<Enter>", lambda e, b=btn: b.config(bg="#005a9e"))
            btn.bind("<Leave>", lambda e, b=btn: b.config(bg="#007acc"))

        tk.Button(
            self.frame, text="Salir", width=25,
            font=("Segoe UI", 10, "bold"), bg="#cc0000", fg="white", relief="flat",
            command=self.root.quit
        ).pack(pady=10)

    def abrir_modulo(self, ClaseModulo):
        self.frame.pack_forget()
        # Pasar usuario a ventas
        if ClaseModulo.__name__ == "VentasCRUD":
            ClaseModulo(self.root, self, self.usuario)
        else:
            ClaseModulo(self.root, self)
