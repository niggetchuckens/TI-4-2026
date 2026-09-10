import React from 'react';

interface CheckboxItemProps extends React.InputHTMLAttributes<HTMLInputElement> {
  label: string;
  icon?: React.ReactNode;
}

export const CheckboxItem = React.forwardRef<HTMLInputElement, CheckboxItemProps>(
  ({ label, icon, className = '', ...props }, ref) => {
    return (
      <label className={`group flex items-center justify-between px-4 py-3 bg-page-gray-light rounded-xl cursor-pointer hover:brightness-95 transition-all w-full max-w-sm ${className}`}>
        <div className="flex items-center gap-3 transition-transform duration-300 ease-out group-hover:translate-x-1">
          {icon && (
            <span className="text-page-dark flex items-center justify-center text-2xl">
              {icon}
            </span>
          )}
          <span className="text-page-dark font-medium text-lg">{label}</span>
        </div>

        <div className="relative flex items-center justify-center">
          <input
            type="checkbox"
            ref={ref}
            className="peer appearance-none w-7 h-7 border-[3px] border-page-dark rounded-md bg-transparent checked:bg-page-yellow cursor-pointer transition-colors outline-none focus-visible:ring-2 focus-visible:ring-page-blue focus-visible:ring-offset-2"
            {...props}
          />
        </div>
      </label>
    );
  }
);

CheckboxItem.displayName = 'CheckboxItem';
