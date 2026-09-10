import React from 'react';
import { type PageColor, bgPageColors } from '../constants/colors';

interface PanelProps {
  children: React.ReactNode;
  color?: PageColor;
  withUctBorder?: boolean;
  outerClassName?: string;
  innerClassName?: string;
  onClose?: () => void;
}

export const Panel = ({
  children,
  color = 'white',
  withUctBorder = false,
  outerClassName = 'rounded-3xl',
  innerClassName = 'p-6 flex flex-col relative',
  onClose
}: PanelProps) => {

  const bgColorClass = color === 'gray'
    ? "bg-page-gray-light border border-gray-200"
    : bgPageColors[color];

  const renderCloseButton = () => {
    if (!onClose) return null;
    return (
      <button
        onClick={onClose}
        className="absolute top-4 right-4 p-1 rounded-md text-gray-500 hover:text-page-dark hover:bg-gray-100 transition-colors z-10 outline-none"
        aria-label="Cerrar panel"
      >
        <svg xmlns="http://www.w3.org/2000/svg" className="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={1.5}>
          <path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" />
        </svg>
      </button>
    );
  };

  if (withUctBorder) {
    return (
      <div
        className={`bg-gradient-to-b from-page-blue from-50% to-page-yellow to-50% p-1.5 shadow-md w-max h-max ${outerClassName}`}
      >
        <div className={`${bgColorClass} w-full h-full rounded-2xl ${innerClassName}`}>
          {renderCloseButton()}
          {children}
        </div>
      </div>
    );
  }

  return (
    <div className={`${bgColorClass} shadow-sm w-max h-max relative ${outerClassName} ${innerClassName}`}>
      {renderCloseButton()}
      {children}
    </div>
  );
};
