import React from 'react';

interface FileUploadProps {
  label?: string;
  maxFiles?: number;
  className?: string;
}

export const FileUpload = ({ maxFiles = 3, label = `ARRASTRA MÁXIMO ${maxFiles} IMÁGENES`, className = '' }: FileUploadProps) => {
  return (
    <div className={`w-full bg-[#dfdfdf] rounded-[18px] h-48 flex flex-col items-center justify-center text-[#aaaaaa] gap-3 cursor-pointer hover:bg-gray-300 transition-colors ${className}`}>
      <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 24 24" fill="currentColor">
        <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V5h14v14zm-5.04-6.71l-2.75 3.54-1.96-2.36L6.5 17h11l-3.54-4.71z"/>
      </svg>
      <span className="text-lg font-medium">{label}</span>
    </div>
  );
};
