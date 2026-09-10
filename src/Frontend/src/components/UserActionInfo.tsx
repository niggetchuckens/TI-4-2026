import React from 'react';
import { Avatar } from './Avatar';

interface UserActionInfoProps {
  /** Título principal de la acción (ej: "Recuperado por Usuario") */
  title: string;
  /** Subtítulo secundario (ej: "Hace 12 minutos") */
  subtitle: string;
  /** URL de la imagen del avatar. Si no se pasa, mostrará un fondo gris. */
  avatarSrc?: string | null;
  /** Clases adicionales para el contenedor padre */
  className?: string;
}

export const UserActionInfo = ({ title, subtitle, avatarSrc, className = '' }: UserActionInfoProps) => {
  return (
    <div className={`flex items-center gap-4 bg-white p-2 ${className}`}>
      <Avatar src={avatarSrc} className="w-[72px] h-[72px]" />
      <div className="flex flex-col justify-center">
        <h3 className="text-[28px] leading-tight font-medium text-page-dark">{title}</h3>
        <p className="text-[22px] leading-tight font-medium text-gray-400 mt-1">{subtitle}</p>
      </div>
    </div>
  );
};
