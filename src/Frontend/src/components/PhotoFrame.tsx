import React, { useState } from 'react';
import { useGalleryControls } from '../hooks/GalleryControls';

interface PhotoFrameProps {
  src?: string | null;
  images?: string[];
  alt?: string;
  className?: string;
  autoPlayInterval?: number;
}

export const PhotoFrame = ({
  src,
  images = [],
  alt = 'Foto',
  className = 'w-48 h-48',
  autoPlayInterval = 0, // Por defecto apagado si es un marco simple
}: PhotoFrameProps) => {
  // Lista unificada: si pasaron src único, lo mete al arreglo
  const imageList = src ? [src] : images;
  const [hasError, setHasError] = useState(false);

  const { currentIndex, next, prev } = useGalleryControls({
    totalItems: imageList.length,
    autoPlayInterval,
  });

  const currentImage = imageList[currentIndex];

  return (
    <div className={`relative overflow-hidden rounded-2xl bg-page-gray-light flex items-center justify-center flex-shrink-0 group ${className}`}>
      {currentImage && !hasError ? (
        <img
          src={currentImage}
          alt={alt}
          className="w-full h-full object-cover transition-all duration-300"
          onError={() => setHasError(true)}
        />
      ) : (
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 24 24"
          fill="currentColor"
          className="w-1/2 h-1/2 text-page-gray-medium"
        >
          <path d="M21 19V5c0-1.1-.9-2-2-2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2zM8.5 13.5l2.5 3.01L14.5 12l4.5 6H5l3.5-4.5z" />
        </svg>
      )}

      {/* Mini-flechas si el marco tiene más de una imagen */}
      {imageList.length > 1 && (
        <div className="absolute inset-0 flex items-center justify-between px-1 opacity-0 group-hover:opacity-100 transition-opacity">
          <button
            onClick={prev}
            className="bg-black/50 text-white rounded-full p-1 hover:bg-black/70"
            aria-label="Anterior foto"
          >
            ‹
          </button>
          <button
            onClick={next}
            className="bg-black/50 text-white rounded-full p-1 hover:bg-black/70"
            aria-label="Siguiente foto"
          >
            ›
          </button>
        </div>
      )}
    </div>
  );
};
