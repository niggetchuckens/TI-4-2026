import { NavLink } from 'react-router-dom';
import React from 'react';

interface NavButtonProps {
  /** Ruta a la que navega */
  to: string;       
  /** Icono a mostrar en el botón (opcional) */
  icon?: React.ReactNode;
  /** Texto a mostrar */
  label?: string;
}

export const NavButton = ({ to, icon, label }: NavButtonProps) => {
  return (
    <NavLink 
      to={to} 
      className={({ isActive }) => 
        `relative overflow-hidden group px-4 py-2 flex items-center gap-2 rounded-md font-medium transition-colors duration-200 z-0 ${
          isActive 
            ? 'bg-page-blue text-white shadow-md' 
            : 'bg-transparent text-gray-700 hover:text-page-blue'
        }`
      }
    >
      {({ isActive }) => (
        <>
          {/* Capa de relleno que aparece de izquierda a derecha */}
          {!isActive && (
            <div className="absolute inset-0 bg-blue-100 origin-left scale-x-0 transition-transform duration-300 ease-out group-hover:scale-x-100 -z-10 rounded-md" />
          )}
          {icon && <span className="flex items-center relative z-10">{icon}</span>}
          <span className="relative z-10">{label}</span>
        </>
      )}
    </NavLink>
  );
};
