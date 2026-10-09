import { useState } from 'react';
import './index.css';
import DashboardView from './components/DashboardView';
import HeatmapView from './components/HeatmapView';
import ReviewQueueView from './components/ReviewQueueView';

function App() {
  const [activeTab, setActiveTab] = useState('dashboard');

  return (
    <div id="root">
      {/* Sidebar */}
      <aside className="sidebar">
        <div className="sidebar-header">
          <div className="logo-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" width="20" height="20">
              <path d="M12 2v20M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6" />
            </svg>
          </div>
          <div className="logo-text">
            CleanCity
            <div className="logo-sub">COMMAND PORTAL</div>
          </div>
        </div>

        <div className="jurisdiction">
          <div className="flex items-center gap-2">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" width="16" height="16" className="text-primary">
              <path d="M9 11l3 3L22 4" /><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" />
            </svg>
            <div>
              <div className="jurisdiction-title">JURISDICTION</div>
              <div className="jurisdiction-value">East Zone BBMP</div>
            </div>
          </div>
          <div className="status-dot"></div>
        </div>

        <nav className="nav-menu">
          <a className={`nav-item ${activeTab === 'dashboard' ? 'active' : ''}`} onClick={() => setActiveTab('dashboard')}>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="3" width="7" height="9" rx="1" /><rect x="14" y="3" width="7" height="5" rx="1" /><rect x="14" y="12" width="7" height="9" rx="1" /><rect x="3" y="16" width="7" height="5" rx="1" /></svg>
            <div className="nav-text">
              <span className="nav-label">Dashboard</span>
              <span className="nav-sub">ओवरव्यू</span>
            </div>
          </a>
          <a className={`nav-item ${activeTab === 'heatmap' ? 'active' : ''}`} onClick={() => setActiveTab('heatmap')}>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" /></svg>
            <div className="nav-text">
              <span className="nav-label">Ward Heatmap</span>
              <span className="nav-sub">हीटमैप</span>
            </div>
          </a>
          <a className={`nav-item ${activeTab === 'queue' ? 'active' : ''}`} onClick={() => setActiveTab('queue')}>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" /><polyline points="14 2 14 8 20 8" /><line x1="16" y1="13" x2="8" y2="13" /><line x1="16" y1="17" x2="8" y2="17" /><polyline points="10 9 9 9 8 9" /></svg>
            <div className="nav-text">
              <span className="nav-label">AI Review Queue</span>
              <span className="nav-sub">एआई समीक्षा कतार</span>
            </div>
          </a>
          <a className="nav-item">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M3 3v18h18" /><path d="M18.7 8l-5.1 5.2-2.8-2.7L7 14.3" /></svg>
            <div className="nav-text">
              <span className="nav-label">Reports & SLA</span>
              <span className="nav-sub">रिपोर्ट्स</span>
            </div>
          </a>
          <a className="nav-item">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="3" /><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z" /></svg>
            <div className="nav-text">
              <span className="nav-label">Settings</span>
              <span className="nav-sub">सेटिंग्स</span>
            </div>
          </a>
        </nav>

        <div className="sidebar-footer">
          <div className="flex justify-between items-center text-xs font-bold text-muted mb-1">
            <span>WARD STATUS</span>
            <span className="text-primary">Live Stream</span>
          </div>
          <div className="flex items-center gap-2 text-xs font-semibold">
            <div className="status-dot"></div>
            <span>Ward 142 Active Sync</span>
          </div>
        </div>
      </aside>

      {/* Main Content */}
      <main className="main-content">
        <header className="topbar">
          <div className="topbar-left">
            <div className="flex items-center gap-2 px-3 py-1.5 bg-white border border-gray-200 rounded-md text-sm font-semibold shadow-sm">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" className="text-primary" width="16" height="16"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" /><circle cx="12" cy="10" r="3" /></svg>
              <span>Designated Ward</span>
              <select className="border-none bg-transparent font-bold outline-none cursor-pointer">
                <option>Ward 142 - Indiranagar Central</option>
              </select>
            </div>
            <div className="badge-engine">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><rect x="3" y="11" width="18" height="11" rx="2" ry="2" /><path d="M7 11V7a5 5 0 0 1 10 0v4" /></svg>
              AI Verification Engine: Online
            </div>
          </div>

          <div className="topbar-right">
            <div className="lang-toggle">
              <div className="lang-btn active">EN</div>
              <div className="lang-btn text-muted">हि</div>
            </div>
            
            <div className="relative cursor-pointer">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="20" height="20"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9" /><path d="M13.73 21a2 2 0 0 1-3.46 0" /></svg>
              <div className="absolute -top-1 -right-1 bg-red-500 text-white text-[10px] w-4 h-4 flex items-center justify-center rounded-full font-bold" style={{backgroundColor: '#ef4444', position: 'absolute', top: -5, right: -5, width: 16, height: 16, display: 'flex', alignItems: 'center', justifyContent: 'center', borderRadius: '50%', color: 'white', fontSize: 10, fontWeight: 'bold'}}>7</div>
            </div>

            <div className="profile-widget">
              <div className="flex-col text-right">
                <span className="text-sm font-bold">Rajesh Kumar</span>
                <span className="text-xs text-muted">Senior San. Officer</span>
              </div>
              <div className="profile-avatar">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="20" height="20"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" /><circle cx="12" cy="7" r="4" /></svg>
              </div>
            </div>
          </div>
        </header>

        <div className="page-container">
          {activeTab === 'dashboard' && <DashboardView />}
          {activeTab === 'heatmap' && <HeatmapView />}
          {activeTab === 'queue' && <ReviewQueueView />}
        </div>
      </main>
    </div>
  );
}

export default App;
