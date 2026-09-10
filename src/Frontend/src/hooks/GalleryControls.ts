import { useState, useEffect, useCallback } from 'react';

interface GalleryControlsProps {
  totalItems: number;
  autoPlay?: boolean;
  autoPlayInterval?: number;
}

export const useGalleryControls = ({
  totalItems,
  autoPlay = false,
  autoPlayInterval = 2500,
}: UseGalleryControlsProps) => {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isPaused, setIsPaused] = useState(false);
  const [isManualTransition, setIsManualTransition] = useState(false);

  const next = useCallback(() => {
    setIsManualTransition(true);
    setCurrentIndex((prev) => (prev === totalItems - 1 ? 0 : prev + 1));
  }, [totalItems]);

  const prev = useCallback(() => {
    setIsManualTransition(true);
    setCurrentIndex((prev) => (prev === 0 ? totalItems - 1 : prev - 1));
  }, [totalItems]);

  const goTo = useCallback((index: number) => {
    setIsManualTransition(true);
    setCurrentIndex(index);
  }, []);

  useEffect(() => {
    if (totalItems <= 1 || autoPlayInterval <= 0 || isPaused) return;

    const intervalId = setInterval(() => {
      setIsManualTransition(false);
      setCurrentIndex((prev) => (prev === totalItems - 1 ? 0 : prev + 1));
    }, autoPlayInterval);

    return () => clearInterval(intervalId);
  }, [totalItems, autoPlayInterval, isPaused]);

  return {
    currentIndex,
    isManualTransition,
    next,
    prev,
    goTo,
    pause: () => setIsPaused(true),
    resume: () => setIsPaused(false),
  };
};
