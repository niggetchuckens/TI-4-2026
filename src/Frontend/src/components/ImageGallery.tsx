import React from 'react';
import { useImageControls } from '../hooks/useImageControls';
import { ImageControls } from './ImageControls'; // TUS FLECHAS VISUALES

interface ImageGalleryProps {
  images: string[];
  className?: string;
  autoPlayInterval?: number;
}

export const ImageGallery = ({
  images = [],
  className = 'w-[600px] h-[300px]',
  autoPlayInterval = 2500,
}: ImageGalleryProps) => {

  // CORRECCIÓN: Llamamos a useImageControls (con "use")
  const { currentIndex, isManualTransition, next, prev, goTo, pause, resume } =
    useImageControls({
      totalItems: images.length,
      autoPlayInterval,
    });

  if (!images || images.length === 0) {
    return (
      <div className={`bg-gray-200 rounded-[2rem] flex items-center justify-center ${className}`}>
        <span className="text-gray-500 font-medium">No hay imágenes disponibles</span>
      </div>
    );
  }

  return (
    <div
      className={`relative overflow-hidden rounded-[2rem] shadow-md group ${className}`}
      onMouseEnter={pause}
      onMouseLeave={resume}
    >
      <div
        className="flex w-full h-full"
        style={{
          transform: `translateX(-${currentIndex * 100}%)`,
          transition: isManualTransition
            ? 'transform 0.5s cubic-bezier(0.16, 1, 0.3, 1)'
            : 'transform 0.8s cubic-bezier(0.87, 0, 0.13, 1)',
        }}
      >
        {images.map((src, index) => (
          <img
            key={index}
            src={src}
            alt={`Imagen ${index + 1}`}
            className="w-full h-full object-cover flex-shrink-0"
          />
        ))}
      </div>

      {images.length > 1 && (
        <>
          <ImageControls onPrev={prev} onNext={next} />

          <div className="absolute bottom-4 left-1/2 -translate-x-1/2 bg-white/80 backdrop-blur rounded-full px-3 py-1 flex gap-2 items-center shadow-lg">
            {images.map((_, index) => (
              <button
                key={index}
                onClick={() => goTo(index)}
                className={`w-3 h-3 rounded-full transition-all ${
                  index === currentIndex ? 'bg-black scale-125' : 'bg-gray-400'
                }`}
                aria-label={`Ir a imagen ${index + 1}`}
              />
            ))}
          </div>
        </>
      )}
    </div>
  );
};
