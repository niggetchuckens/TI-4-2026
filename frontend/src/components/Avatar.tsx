import React from 'react';

interface AvatarProps {
  src?: string | null;
  className?: string;
}

export const Avatar = ({ src, className = 'w-20 h-20' }: AvatarProps) => {
  return (
    <div className={`rounded-full p-1.5 bg-gradient-to-b from-page-yellow from-50% to-page-blue to-50% shadow-md flex-shrink-0 ${className}`}>

      <div className="w-full h-full rounded-full overflow-hidden bg-page-gray-light flex items-center justify-center">
        {src && (
          <img
            src={src}
            className="w-full h-full object-cover"
            onError={(e) => {
              e.currentTarget.style.display = 'none';
            }}
          />
        )}
      </div>
    </div>
  );
};
