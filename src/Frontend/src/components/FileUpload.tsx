import React, { useRef, useState, useEffect } from 'react';
import { CloseButton } from './ExitButton';
import { useImageControls } from '../hooks/useImageControls';
import { ImageControls } from './ImageControls';

interface FileUploadProps {
  label?: string;
  maxFiles?: number;
  className?: string;
  width?: string;
  height?: string;
  onFilesChange?: (files: File[]) => void;
}

export const FileUpload = ({
  maxFiles = 3,
  label = `ARRASTRA MÁXIMO ${maxFiles} IMÁGENES`,
  className = '',
  width = '170',
  height = '70',
  onFilesChange,
}: FileUploadProps) => {
  const [files, setFiles] = useState<File[]>([]);
  const [isDragging, setIsDragging] = useState(false);
  const inputRef = useRef<HTMLInputElement>(null);

  const { currentIndex, next, prev, goTo, pause, resume } = useImageControls({
    totalItems: files.length,
    autoPlay: false,
  });

  useEffect(() => {
    if (currentIndex >= files.length && files.length > 0) {
      goTo(files.length - 1);
    }
  }, [files.length, currentIndex, goTo]);

  const handleFiles = (incomingFiles: FileList | null) => {
    if (!incomingFiles) return;

    const validNewFiles = Array.from(incomingFiles).filter((file) =>
      file.type.startsWith('image/')
    );

    setFiles((prevFiles) => {
      const combined = [...prevFiles, ...validNewFiles].slice(0, maxFiles);
      if (onFilesChange) onFilesChange(combined);
      return combined;
    });
  };

  const handleDrop = (e: React.DragEvent<HTMLDivElement>) => {
    e.preventDefault();
    setIsDragging(false);
    handleFiles(e.dataTransfer.files);
  };

  const handleDragOver = (e: React.DragEvent<HTMLDivElement>) => {
    e.preventDefault();
    setIsDragging(true);
  };

  const handleDragLeave = () => {
    setIsDragging(false);
  };

  const handleRemoveImage = (indexToRemove: number) => {
    setFiles((prevFiles) => {
      const updated = prevFiles.filter((_, idx) => idx !== indexToRemove);
      if (onFilesChange) onFilesChange(updated);
      return updated;
    });
  };

  return (
    <div
      onDragOver={handleDragOver}
      onDragLeave={handleDragLeave}
      onDrop={handleDrop}
      onMouseEnter={pause}
      onMouseLeave={resume}
      className={`relative rounded-[18px] overflow-hidden select-none transition-colors flex-shrink-0 w-${width} h-${height} ${
        files.length === 0
          ? isDragging
            ? 'bg-gray-300 border-2 border-dashed border-page-blue text-page-blue cursor-pointer'
            : 'bg-[#dfdfdf] text-[#aaaaaa] hover:bg-gray-300 cursor-pointer'
          : 'bg-black shadow-md'
      } ${className}`}
      onClick={() => {
        if (files.length === 0) inputRef.current?.click();
      }}
    >
      <input
        ref={inputRef}
        type="file"
        multiple={maxFiles > 1}
        accept="image/*"
        className="hidden"
        onChange={(e) => handleFiles(e.target.files)}
      />

      {files.length === 0 ? (
        <div className="w-full h-full flex flex-col items-center justify-center gap-3">
          <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" viewBox="0 0 24 24" fill="currentColor">
            <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V5h14v14zm-5.04-6.71l-2.75 3.54-1.96-2.36L6.5 17h11l-3.54-4.71z" />
          </svg>
          <span className="text-base font-medium px-4 text-center">
            {isDragging ? '¡SUELTA LAS IMÁGENES AQUÍ!' : label}
          </span>
        </div>
      ) : (
        <div className="relative w-full h-full overflow-hidden group">

        <div
          className="absolute inset-0 flex transition-transform duration-500 ease-out"
          style={{ transform: `translateX(-${currentIndex * 100}%)` }}
        >
          {files.map((file, idx) => (
            <div key={`${file.name}-${idx}`} className="min-w-full h-full flex-shrink-0">
              <img
                src={URL.createObjectURL(file)}
                alt={`Preview ${idx + 1}`}
                className="w-full h-full object-cover block select-none pointer-events-none"
              />
            </div>
           ))}
        </div>

        <CloseButton
          onClick={(e) => {
            e.stopPropagation();
            handleRemoveImage(currentIndex);
          }}
          className="absolute top-3 right-3"
        />

          {files.length < maxFiles && (
            <button
              type="button"
              onClick={(e) => {
                e.stopPropagation();
                inputRef.current?.click();
              }}
              className="absolute top-3 left-3 bg-black/60 hover:bg-black/80 text-white text-xs font-semibold px-2.5 py-1.5 rounded-full backdrop-blur transition-all active:scale-95 z-20"
            >
              + Añadir ({files.length}/{maxFiles})
            </button>
          )}

          {files.length > 1 && (
            <>
              <ImageControls
                onPrev={(e) => {
                  e.stopPropagation();
                  prev();
                }}
                onNext={(e) => {
                  e.stopPropagation();
                  next();
                }}
              />

              <div className="absolute bottom-3 left-1/2 -translate-x-1/2 bg-white/80 backdrop-blur rounded-full px-3 py-1 flex gap-2 items-center shadow-lg z-20">
                {files.map((_, idx) => (
                  <button
                    key={idx}
                    type="button"
                    onClick={(e) => {
                      e.stopPropagation();
                      goTo(idx);
                    }}
                    className={`w-3 h-3 rounded-full transition-all ${
                      idx === currentIndex ? 'bg-black scale-125' : 'bg-gray-400 hover:bg-gray-500'
                    }`}
                    aria-label={`Ir a imagen ${idx + 1}`}
                  />
                ))}
              </div>
            </>
          )}
        </div>
      )}
    </div>
  );
};
