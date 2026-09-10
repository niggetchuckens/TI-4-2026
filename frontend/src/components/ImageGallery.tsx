import React, { useState, useEffect } from 'react';

interface ImageGalleryProps {
  images: string[];
  className?: string;
  autoPlayInterval?: number;
}

export const ImageGallery = ({
  images,
  className = 'w-[600px] h-[300px]',
  autoPlayInterval = 2500
}: ImageGalleryProps) => {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isPaused, setIsPaused] = useState(false);
  const [isManualTransition, setIsManualTransition] = useState(false);

  useEffect(() => {
    if (images.length <= 1 || autoPlayInterval <= 0 || isPaused) return;

    const intervalId = setInterval(() => {
      setIsManualTransition(false);
      setCurrentIndex((prev) => (prev === images.length - 1 ? 0 : prev + 1));
    }, autoPlayInterval);

    return () => clearInterval(intervalId);
  }, [images.length, autoPlayInterval, currentIndex, isPaused]);

  if (!images || images.length === 0) {
    return (
      <div className={`bg-gray-200 rounded-[2rem] flex items-center justify-center ${className}`}>
        <span className="text-gray-500 font-medium">No hay imágenes disponibles</span>
      </div>
    );
  }

  const handleNext = () => {
    setIsManualTransition(true);
    setCurrentIndex((prev) => (prev === images.length - 1 ? 0 : prev + 1));
  };

  const handlePrev = () => {
    setIsManualTransition(true);
    setCurrentIndex((prev) => (prev === 0 ? images.length - 1 : prev - 1));
  };

  const handleDotClick = (index: number) => {
    setIsManualTransition(true);
    setCurrentIndex(index);
  };

  return (
    <div
      className={`relative overflow-hidden rounded-[2rem] shadow-md group ${className}`}
      onMouseEnter={() => setIsPaused(true)}
      onMouseLeave={() => setIsPaused(false)}
    >

      <div
        className="flex w-full h-full"
        style={{
          transform: `translateX(-${currentIndex * 100}%)`,
          transition: isManualTransition
            ? 'transform 0.5s cubic-bezier(0.16, 1, 0.3, 1)'
            : 'transform 0.8s cubic-bezier(0.87, 0, 0.13, 1)'
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
          {/* LEFT ARROW */}
          <button
            onClick={handlePrev}
            className="absolute left-2 top-1/2 -translate-y-1/2 text-white transition-transform duration-700 ease-[cubic-bezier(0.16,1,0.3,1)] hover:scale-110 active:duration-75 active:ease-out active:-translate-x-1.5 active:scale-95 drop-shadow-[0_2px_4px_rgba(0,0,0,0.5)] z-10"
            aria-label="Anterior"
          >
            <svg xmlns="http://www.w3.org/2000/svg" width="72" height="72" viewBox="0 0 24 24" fill="currentColor" stroke="currentColor" strokeWidth="2" strokeLinejoin="round">
              <polygon points="16,5 8,12 16,19" />
            </svg>
          </button>

          {/* RIGHT ARROW */}
          <button
            onClick={handleNext}
            className="absolute right-2 top-1/2 -translate-y-1/2 text-white transition-transform duration-700 ease-[cubic-bezier(0.16,1,0.3,1)] hover:scale-110 active:duration-75 active:ease-out active:translate-x-1.5 active:scale-95 drop-shadow-[0_2px_4px_rgba(0,0,0,0.5)] z-10"
            aria-label="Siguiente"
          >
            <svg xmlns="http://www.w3.org/2000/svg" width="72" height="72" viewBox="0 0 24 24" fill="currentColor" stroke="currentColor" strokeWidth="2" strokeLinejoin="round">
              <polygon points="8,5 16,12 8,19" />
            </svg>
          </button>

          <div className="absolute bottom-4 left-1/2 -translate-x-1/2 bg-white rounded-full px-4 py-2 flex gap-4 items-center shadow-lg">
            {images.map((_, index) => (
              <button
                key={index}
                onClick={() => handleDotClick(index)}
                className={`w-3.5 h-3.5 rounded-full border-[3px] border-black ${
                  index === currentIndex
                    ? 'bg-black scale-[1.4]'
                    : 'bg-transparent scale-100'
                }`}
                style={{
                  transition: index === currentIndex
                    ? 'all 0.5s cubic-bezier(0.68, -0.55, 0.26, 1.55)'
                    : 'all 0.5s cubic-bezier(0.16, 1, 0.3, 1)'
                }}
                aria-label={`Ir a imagen ${index + 1}`}
              />
            ))}
          </div>
        </>
      )}
    </div>
  );
};
