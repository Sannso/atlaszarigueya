import React from 'react';

const OrganCard = ({ organName, organTitle, description, href, imageUrl, system }) => {
  return (
    <a href={href} className="organ-card">
      <div className="card-content">
        <div className="card-header">
          <div className="organ-icon">
            {imageUrl ? (
              <img src={imageUrl} alt={`${organTitle} icon`} className="organ-image" />
            ) : (
              <div className="organ-placeholder">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M12 2L2 7L12 12L22 7L12 2Z" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/>
                  <path d="M2 17L12 22L22 17" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/>
                  <path d="M2 12L12 17L22 12" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/>
                </svg>
              </div>
            )}
          </div>
          <div className="organ-info">
            <h3 className="organ-title">{organTitle}</h3>
            {system && <span className="system-tag">{system}</span>}
          </div>
        </div>
        
        <p className="organ-description">{description}</p>
        
        <div className="card-footer">
          <span className="view-more">Ver más</span>
          <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M6 3L11 8L6 13" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/>
          </svg>
        </div>
      </div>
    </a>
  );
};

export default OrganCard;
