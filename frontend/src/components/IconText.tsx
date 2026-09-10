import React from 'react';

interface IconTextProps {
  icon: React.ReactNode;
  text: string;
  className?: string;
}

export const IconText = ({ icon, text, className = '' }: IconTextProps) => {
  return (
    <div className={`flex items-center gap-3 text-page-dark ${className}`}>
      <span className="flex items-center justify-center text-3xl">
        {icon}
      </span>
      <span className="font-medium text-xl">{text}</span>
    </div>
  );
};
