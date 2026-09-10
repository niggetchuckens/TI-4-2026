import { NavLink } from 'react-router-dom';
import React from 'react';

interface SectionButtonProps {
  /** Ruta a la que navega */
  to: string;       
  /** Icono a mostrar en el botón */
  icon?: React.ReactNode;
  /** Texto que aparece al expandirse */
  label?: string;
  /** Ancho máximo al que se expandirá el botón (ej: '200px', '16rem'). Por defecto 200px. */
  expandedWidth?: string;
}

export const SectionButton = ({ to, icon, label, expandedWidth = "200px" }: SectionButtonProps) => {
  return (
    <NavLink 
      to={to} 
      style={{ '--expanded-width': expandedWidth } as React.CSSProperties}
      className={() => 
        `group relative flex items-center h-14 rounded-2xl transition-[width] duration-300 ease-in-out cursor-pointer shadow-sm overflow-hidden bg-page-white w-14 hover:w-[var(--expanded-width)]`
      }
    >
      {({ isActive }) => (
        <>
          {/* Contenedor del Ícono (Siempre visible, tamaño fijo 56x56) */}
          <div className={`flex-shrink-0 flex items-center justify-center w-14 h-14 rounded-2xl transition-colors duration-200 ${
            isActive 
              ? 'bg-page-yellow text-page-white' // Activo: Cuadro amarillo
              : 'bg-transparent text-page-blue'   // Inactivo: Transparente (toma el blanco del fondo)
          }`}>
            <span className="flex items-center justify-center w-8 h-8">
              {icon}
            </span>
          </div>

          {/* Contenedor del Texto (Se revela al expandir con deslizamiento) */}
          <span className="ml-3 whitespace-nowrap text-2xl font-medium text-gray-800 opacity-0 -translate-x-4 transition-all duration-300 group-hover:opacity-100 group-hover:translate-x-0 group-hover:delay-[100ms]">
            {label}
          </span>
        </>
      )}
    </NavLink>
  );
};
