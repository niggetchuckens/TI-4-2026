import React from 'react';
import { type PageColor, bgPageColors, textPageColors, borderPageColors, hoverBgPageColors, solidButtonConfig } from '../constants/colors';

type ButtonSize = 'sm' | 'md' | 'lg';

interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'solid' | 'outline' | 'ghost';
  color?: PageColor;
  size?: ButtonSize;
}

export const Button = ({ variant = 'solid', color = 'blue', size = 'md', className = '', children, ...props }: ButtonProps) => {

  const sizeClasses: Record<ButtonSize, string> = {
    sm: "px-4 py-1.5 text-sm",
    md: "px-6 py-2.5",
    lg: "px-10 py-3 text-[22px] tracking-wide"
  };

  // Clases base para el botón normal
  const baseClasses = `${sizeClasses[size]} rounded-full font-medium transition-all duration-200 active:scale-95`;

  let variantClasses = "";
  if (variant === 'solid') {
    const config = solidButtonConfig[color];
    variantClasses = `${bgPageColors[color]} ${config.text} ${config.hover} shadow-sm border-[3px] border-transparent`;
  } else if (variant === 'outline') {
    // Si el color es gray, usamos un color de texto más oscuro genérico (o text-page-gray si aplica)
    variantClasses = `bg-transparent border-[3px] ${textPageColors[color]} ${borderPageColors[color]} ${hoverBgPageColors[color]}`;
  } else if (variant === 'ghost') {
    variantClasses = `bg-transparent ${textPageColors[color]} ${hoverBgPageColors[color]}`;
  }

  return (
    <button
      className={`${baseClasses} ${variantClasses} ${className}`}
      {...props}
    >
      {children}
    </button>
  );
};
