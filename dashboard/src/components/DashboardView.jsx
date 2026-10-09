import React from 'react';

const DashboardView = () => {
  return (
    <div style={{ display: 'flex', gap: '24px', height: '100%' }}>
      {/* Left Column */}
      <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: '24px', overflowY: 'auto', paddingRight: '4px' }}>
        
        {/* Header */}
        <div className="dashboard-header">
          <div>
            <div className="flex items-center gap-2 text-xs font-bold text-muted mb-2">
              <div className="status-dot"></div>
              CIVICPULSE SAMPLE DASHBOARD • NOT A LIVE OPERATIONS FEED
            </div>
            <div className="flex items-center gap-3">
              <h1 style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--text-dark)' }}>Ward Executive Dashboard</h1>
              <div style={{ padding: '4px 8px', backgroundColor: '#e2e8f0', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 'bold' }}>वार्ड कार्यकारी डैशबोर्ड</div>
            </div>
            <p className="text-sm text-muted mt-2">Illustrative static metrics; live triage, dispatch, and compliance data are not connected.</p>
          </div>
          <div className="flex items-center gap-3">
            <div className="flex items-center gap-2 px-4 py-2 bg-white border border-gray-200 rounded-md text-sm font-semibold shadow-sm">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="16" height="16"><rect x="3" y="4" width="18" height="18" rx="2" ry="2" /><line x1="16" y1="2" x2="16" y2="6" /><line x1="8" y1="2" x2="8" y2="6" /><line x1="3" y1="10" x2="21" y2="10" /></svg>
              <span>Dashboard sample<br/>Static snapshot</span>
            </div>
            <button className="flex items-center gap-2 px-4 py-2 bg-white border border-gray-200 rounded-md text-sm font-semibold shadow-sm cursor-pointer hover:bg-gray-50">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="16" height="16"><polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3" /></svg>
              Ward Filters
            </button>
            <button className="flex items-center gap-2 px-4 py-2 bg-primary rounded-md text-sm font-semibold text-white shadow-sm cursor-pointer hover:opacity-90" style={{ backgroundColor: 'var(--primary-color)' }}>
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="16" height="16"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z" /><polyline points="3.27 6.96 12 12.01 20.73 6.96" /><line x1="12" y1="22.08" x2="12" y2="12" /></svg>
              Deploy Squad
            </button>
          </div>
        </div>

        {/* KPIs */}
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '16px' }}>
          {/* KPI 1 */}
          <div className="card">
            <div className="flex justify-between items-start mb-4">
              <div className="text-xs font-bold text-muted uppercase">Open Complaints<br/>लंबित शिकायतें</div>
              <div style={{ padding: '8px', backgroundColor: 'var(--bg-color)', borderRadius: '8px' }}>
                <svg viewBox="0 0 24 24" fill="none" stroke="var(--warning)" strokeWidth="2" width="16" height="16"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" /><polyline points="14 2 14 8 20 8" /><line x1="12" y1="18" x2="12" y2="12" /><line x1="9" y1="15" x2="15" y2="15" /></svg>
              </div>
            </div>
            <div className="flex items-end gap-3 mb-4">
              <div style={{ fontSize: '2.5rem', fontWeight: 800, lineHeight: 1 }}>184</div>
              <div style={{ padding: '4px 8px', backgroundColor: 'var(--warning-light)', color: '#b45309', borderRadius: '12px', fontSize: '0.75rem', fontWeight: 'bold' }}>↑ +12 today</div>
            </div>
            <div className="flex justify-between items-center text-xs font-semibold">
              <div className="flex items-center gap-1"><div style={{width:6,height:6,borderRadius:'50%',backgroundColor:'var(--danger)'}}></div> 28 tagged<br/>urgent</div>
              <div className="text-muted text-right">Ward 142<br/>Sector 4</div>
            </div>
          </div>

          {/* KPI 2 */}
          <div className="card">
            <div className="flex justify-between items-start mb-4">
              <div className="text-xs font-bold text-muted uppercase">SLA Misses<br/>एसएलए उल्लंघन</div>
              <div style={{ padding: '8px', backgroundColor: 'var(--danger-light)', borderRadius: '8px' }}>
                <svg viewBox="0 0 24 24" fill="none" stroke="var(--danger)" strokeWidth="2" width="16" height="16"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" /><line x1="12" y1="9" x2="12" y2="13" /><line x1="12" y1="17" x2="12.01" y2="17" /></svg>
              </div>
            </div>
            <div className="flex items-end gap-3 mb-4">
              <div style={{ fontSize: '2.5rem', fontWeight: 800, lineHeight: 1, color: 'var(--danger)' }}>6</div>
              <div style={{ padding: '4px 8px', backgroundColor: 'var(--danger-light)', color: 'var(--danger)', borderRadius: '12px', fontSize: '0.75rem', fontWeight: 'bold' }}>↘ -4 from last wk</div>
            </div>
            <div className="flex justify-between items-center text-xs font-semibold">
              <div className="text-muted">Target threshold &lt; 10</div>
              <div className="text-success">Under cap</div>
            </div>
          </div>

          {/* KPI 3 */}
          <div className="card">
            <div className="flex justify-between items-start mb-4">
              <div className="text-xs font-bold text-muted uppercase">Resolved This Week<br/>सप्ताह में हल</div>
              <div style={{ padding: '8px', backgroundColor: 'var(--success-light)', borderRadius: '8px' }}>
                <svg viewBox="0 0 24 24" fill="none" stroke="var(--success)" strokeWidth="2" width="16" height="16"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" /><polyline points="22 4 12 14.01 9 11.01" /></svg>
              </div>
            </div>
            <div className="flex items-end gap-3 mb-4">
              <div style={{ fontSize: '2.5rem', fontWeight: 800, lineHeight: 1, color: 'var(--success)' }}>642</div>
              <div style={{ padding: '4px 8px', backgroundColor: 'var(--success-light)', color: 'var(--success)', borderRadius: '12px', fontSize: '0.75rem', fontWeight: 'bold' }}>✓ 98.4% success</div>
            </div>
            <div className="flex justify-between items-center text-xs font-semibold">
              <div className="text-muted">Target<br/>90.0%</div>
              <div className="text-success text-right">+8.4% over<br/>baseline</div>
            </div>
          </div>

          {/* KPI 4 */}
          <div className="card">
            <div className="flex justify-between items-start mb-4">
              <div className="text-xs font-bold text-muted uppercase">Avg Resolution Time<br/>औसत समाधान समय</div>
              <div style={{ padding: '8px', backgroundColor: 'var(--success-light)', borderRadius: '8px' }}>
                <svg viewBox="0 0 24 24" fill="none" stroke="var(--success)" strokeWidth="2" width="16" height="16"><circle cx="12" cy="12" r="10" /><polyline points="12 6 12 12 16 14" /></svg>
              </div>
            </div>
            <div className="flex items-end gap-3 mb-4">
              <div style={{ fontSize: '2.5rem', fontWeight: 800, lineHeight: 1 }}>3h<br/>18m</div>
              <div style={{ padding: '4px 8px', backgroundColor: 'var(--success-light)', color: 'var(--success)', borderRadius: '12px', fontSize: '0.75rem', fontWeight: 'bold' }}>⚡ -2h 42m vs<br/>target</div>
            </div>
            <div className="flex justify-between items-center text-xs font-semibold">
              <div className="text-muted">Municipal SLA: 6h<br/>Max</div>
              <div className="text-success text-right">Optimal<br/>Speed</div>
            </div>
          </div>
        </div>

        {/* Chart */}
        <div className="card flex-col" style={{ gap: '16px' }}>
          <div className="flex justify-between items-start">
            <div>
              <h2 className="font-bold text-lg">Zonal Ward Performance Breakdown</h2>
              <p className="text-sm text-muted">Comparative resolution volume across East Zone sectors (On-Time vs Breached)</p>
            </div>
            <div className="flex items-center gap-4 text-xs font-bold">
              <div className="flex items-center gap-2"><div style={{width:8,height:8,borderRadius:'50%',backgroundColor:'var(--primary-color)'}}></div> On-Time (&lt;6h)</div>
              <div className="flex items-center gap-2"><div style={{width:8,height:8,borderRadius:'50%',backgroundColor:'var(--danger)'}}></div> SLA Breached</div>
            </div>
          </div>
          
          {/* Chart Mockup */}
          <div style={{ height: '200px', display: 'flex', alignItems: 'flex-end', justifyContent: 'space-around', padding: '20px 0', borderBottom: '1px solid #e2e8f0', borderLeft: '1px solid #e2e8f0', position: 'relative' }}>
            {/* Y-axis labels */}
            <div style={{ position: 'absolute', left: '-25px', top: 0, height: '100%', display: 'flex', flexDirection: 'column', justifyContent: 'space-between', fontSize: '10px', color: '#94a3b8' }}>
              <span>180</span><span>120</span><span>60</span><span>0</span>
            </div>
            {/* Grid lines */}
            <div style={{ position: 'absolute', left: 0, top: '0', width: '100%', borderTop: '1px dashed #e2e8f0' }}></div>
            <div style={{ position: 'absolute', left: 0, top: '33%', width: '100%', borderTop: '1px dashed #e2e8f0' }}></div>
            <div style={{ position: 'absolute', left: 0, top: '66%', width: '100%', borderTop: '1px dashed #e2e8f0' }}></div>
            
            {/* Bars */}
            {[
              { label: 'Ward 142', sub: 'Indiranagar', val1: 160, val2: 15 },
              { label: 'Ward 150', sub: 'Bellandur N.', val1: 140, val2: 25 },
              { label: 'Ward 78', sub: 'Pulikeshi', val1: 120, val2: 20 },
              { label: 'Ward 84', sub: 'Shanti Ngr', val1: 110, val2: 30 },
              { label: 'Ward 92', sub: 'Shivaji Ngr', val1: 150, val2: 10 },
              { label: 'Ward 110', sub: 'Sampangi', val1: 90, val2: 35 },
            ].map((d, i) => (
              <div key={i} className="flex-col items-center" style={{ gap: '8px', zIndex: 1, width: '40px' }}>
                <div className="flex items-end gap-1" style={{ height: '150px' }}>
                  <div style={{ width: '12px', height: `${(d.val1/180)*100}%`, backgroundColor: 'var(--primary-color)', borderRadius: '4px 4px 0 0' }}></div>
                  <div style={{ width: '12px', height: `${(d.val2/180)*100}%`, backgroundColor: 'var(--danger)', borderRadius: '4px 4px 0 0' }}></div>
                </div>
                <div className="text-center">
                  <div className="text-[10px] font-bold">{d.label}</div>
                  <div className="text-[9px] text-muted">{d.sub}</div>
                </div>
              </div>
            ))}
          </div>
          
          <div className="flex items-center gap-3 p-3 bg-primary-light rounded-md text-sm font-semibold" style={{ backgroundColor: 'var(--bg-color)' }}>
            <svg viewBox="0 0 24 24" fill="none" stroke="var(--primary-color)" strokeWidth="2" width="16" height="16"><circle cx="12" cy="12" r="10" /><line x1="12" y1="16" x2="12" y2="12" /><line x1="12" y1="8" x2="12.01" y2="8" /></svg>
            <span className="flex-1 text-xs">Ward 142 leads east zone with a 94.8% on-time resolution index this cycle.</span>
            <span className="text-xs text-primary cursor-pointer">Download Historical Audit</span>
          </div>
        </div>

        {/* SLA Misses Table */}
        <div className="card flex-col" style={{ gap: '16px', padding: 0 }}>
          <div className="flex justify-between items-center p-5 pb-0">
            <div className="flex items-center gap-3">
              <svg viewBox="0 0 24 24" fill="none" stroke="var(--danger)" strokeWidth="2" width="20" height="20"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" /><circle cx="12" cy="11" r="3" /><line x1="12" y1="14" x2="12" y2="16" /></svg>
              <div>
                <h2 className="font-bold text-lg">SLA Misses & Critical Escalations</h2>
                <p className="text-sm text-muted">Immediate intervention queue requiring executive override or re-assignment</p>
              </div>
            </div>
            <div style={{ backgroundColor: 'var(--danger-light)', color: 'var(--danger)', padding: '6px 12px', borderRadius: '100px', fontSize: '0.75rem', fontWeight: 'bold' }}>
              3 Urgent Tickets
            </div>
          </div>
          
          <div style={{ overflowX: 'auto' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left', fontSize: '0.85rem' }}>
              <thead>
                <tr style={{ backgroundColor: 'var(--bg-color)', borderBottom: '1px solid var(--border-color)', borderTop: '1px solid var(--border-color)' }}>
                  <th style={{ padding: '12px 20px', fontWeight: 700, color: 'var(--text-muted)' }}>TICKET ID</th>
                  <th style={{ padding: '12px 20px', fontWeight: 700, color: 'var(--text-muted)' }}>LOCATION</th>
                  <th style={{ padding: '12px 20px', fontWeight: 700, color: 'var(--text-muted)' }}>CATEGORY</th>
                  <th style={{ padding: '12px 20px', fontWeight: 700, color: 'var(--text-muted)' }}>ELAPSED / SLA</th>
                  <th style={{ padding: '12px 20px', fontWeight: 700, color: 'var(--text-muted)' }}>SQUAD</th>
                  <th style={{ padding: '12px 20px', fontWeight: 700, color: 'var(--text-muted)' }}>URGENCY</th>
                </tr>
              </thead>
              <tbody>
                <tr style={{ borderBottom: '1px solid var(--border-color)' }}>
                  <td style={{ padding: '16px 20px', fontWeight: 'bold', color: 'var(--primary-color)' }}>#CC-<br/>84712</td>
                  <td style={{ padding: '16px 20px' }}><div className="font-bold">8th Cross HAL</div><div className="text-xs text-muted">Ward 142 • Sub-zone 3</div></td>
                  <td style={{ padding: '16px 20px' }}><div className="flex items-center gap-2"><svg viewBox="0 0 24 24" fill="none" stroke="var(--danger)" strokeWidth="2" width="14" height="14"><path d="M10 2v7.31M14 9.31V2M8.5 2h7M14 9.31L22.61 21A1 1 0 0 1 21.75 22H2.25a1 1 0 0 1-.86-1.5L10 9.31V2"/></svg> Chemical<br/>Hazard</div></td>
                  <td style={{ padding: '16px 20px' }}><div className="flex items-center gap-2"><span className="font-bold text-danger text-lg">7h 12m</span><span style={{ backgroundColor: 'var(--danger-light)', color: 'var(--danger)', padding: '2px 6px', borderRadius: '4px', fontSize: '0.65rem', fontWeight: 'bold' }}>BREACHED</span></div></td>
                  <td style={{ padding: '16px 20px' }}><span style={{ backgroundColor: '#e0e7ff', color: '#3730a3', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 'bold' }}>Squad #9</span></td>
                  <td style={{ padding: '16px 20px' }}><span style={{ backgroundColor: 'var(--danger)', color: 'white', padding: '6px 12px', borderRadius: '100px', fontSize: '0.75rem', fontWeight: 'bold', display: 'inline-flex', alignItems: 'center', gap: '4px' }}><svg viewBox="0 0 24 24" fill="currentColor" width="12" height="12"><path d="M12 2L1 21h22M12 6l7.5 13h-15M11 10v4h2v-4M11 16v2h2v-2" /></svg> Critical Red</span></td>
                </tr>
                <tr style={{ borderBottom: '1px solid var(--border-color)' }}>
                  <td style={{ padding: '16px 20px', fontWeight: 'bold', color: 'var(--primary-color)' }}>#CC-<br/>84881</td>
                  <td style={{ padding: '16px 20px' }}><div className="font-bold">100ft Rd Bin Hub</div><div className="text-xs text-muted">Ward 142 • Junction 12</div></td>
                  <td style={{ padding: '16px 20px' }}><div className="flex items-center gap-2"><svg viewBox="0 0 24 24" fill="none" stroke="var(--warning)" strokeWidth="2" width="14" height="14"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg> Overflowing<br/>Bin</div></td>
                  <td style={{ padding: '16px 20px' }}><div className="flex items-center gap-2"><span className="font-bold text-warning text-lg" style={{ color: 'var(--warning)'}}>5h 48m</span><span style={{ backgroundColor: 'var(--warning-light)', color: '#b45309', padding: '2px 6px', borderRadius: '4px', fontSize: '0.65rem', fontWeight: 'bold' }}>WARNING</span></div></td>
                  <td style={{ padding: '16px 20px' }}><span style={{ backgroundColor: '#e0e7ff', color: '#3730a3', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 'bold' }}>Squad #14</span></td>
                  <td style={{ padding: '16px 20px' }}><span style={{ backgroundColor: 'var(--warning)', color: 'white', padding: '6px 12px', borderRadius: '100px', fontSize: '0.75rem', fontWeight: 'bold', display: 'inline-flex', alignItems: 'center', gap: '4px' }}>! High Amber</span></td>
                </tr>
                <tr>
                  <td style={{ padding: '16px 20px', fontWeight: 'bold', color: 'var(--primary-color)' }}>#CC-<br/>84889</td>
                  <td style={{ padding: '16px 20px' }}><div className="font-bold">CMH Rd Market</div><div className="text-xs text-muted">Ward 142 • Block C</div></td>
                  <td style={{ padding: '16px 20px' }}><div className="flex items-center gap-2"><svg viewBox="0 0 24 24" fill="none" stroke="var(--warning)" strokeWidth="2" width="14" height="14"><circle cx="12" cy="12" r="10"></circle><path d="M8 14s1.5 2 4 2 4-2 4-2"></path><line x1="9" y1="9" x2="9.01" y2="9"></line><line x1="15" y1="9" x2="15.01" y2="9"></line></svg> Garbage<br/>Pile</div></td>
                  <td style={{ padding: '16px 20px' }}><div className="flex items-center gap-2"><span className="font-bold text-warning text-lg" style={{ color: 'var(--warning)'}}>5h 30m</span><span style={{ backgroundColor: 'var(--warning-light)', color: '#b45309', padding: '2px 6px', borderRadius: '4px', fontSize: '0.65rem', fontWeight: 'bold' }}>WARNING</span></div></td>
                  <td style={{ padding: '16px 20px' }}><span style={{ backgroundColor: '#e0e7ff', color: '#3730a3', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 'bold' }}>Squad #3</span></td>
                  <td style={{ padding: '16px 20px' }}><span style={{ backgroundColor: 'var(--warning)', color: 'white', padding: '6px 12px', borderRadius: '100px', fontSize: '0.75rem', fontWeight: 'bold', display: 'inline-flex', alignItems: 'center', gap: '4px' }}>! High Amber</span></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        
      </div>

      {/* Right Column / Sidebar */}
      <div style={{ width: '320px', display: 'flex', flexDirection: 'column', gap: '24px' }}>
        
        {/* AI Insights */}
        <div style={{ backgroundColor: '#dcfce7', borderRadius: '16px', padding: '20px', display: 'flex', flexDirection: 'column', gap: '16px' }}>
          <div className="flex justify-between items-start">
            <div className="flex gap-3 items-center">
              <div style={{ backgroundColor: 'var(--primary-color)', color: 'white', padding: '8px', borderRadius: '8px' }}>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="20" height="20"><path d="M12 2a10 10 0 1 0 10 10H12V2z" /><path d="M12 12L2.1 12A10 10 0 0 1 12 2v10z" /></svg>
              </div>
              <div>
                <h3 style={{ fontSize: '1.1rem', fontWeight: 800, color: 'var(--primary-color)' }}>Sample Insights<br/>(Not Connected)</h3>
                <div style={{ fontSize: '0.65rem', fontWeight: 'bold', color: 'var(--primary-color)', opacity: 0.8 }}>लाइव मॉडल उपलब्ध नहीं</div>
              </div>
            </div>
            <div style={{ backgroundColor: 'var(--primary-color)', color: 'white', padding: '4px 8px', borderRadius: '100px', fontSize: '0.6rem', fontWeight: 'bold', textAlign: 'center' }}>Static<br/>Sample</div>
          </div>
          
          <p style={{ fontSize: '0.85rem', color: '#166534', fontWeight: 500 }}>
            Illustrative sample content only. No AI inference, telemetry, or dispatch integration is connected.
          </p>

          <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '16px', display: 'flex', flexDirection: 'column', gap: '8px' }}>
            <div className="flex items-center gap-2 font-bold text-sm" style={{ color: 'var(--primary-color)' }}>
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><rect x="1" y="3" width="15" height="13"></rect><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon><circle cx="5.5" cy="18.5" r="2.5"></circle><circle cx="18.5" cy="18.5" r="2.5"></circle></svg>
              Fleet routing (sample)
            </div>
            <p className="text-xs text-muted leading-relaxed">Live fleet routing and dispatch are not connected in this prototype.</p>
            <div className="flex justify-between items-center mt-2 border-t pt-2" style={{ borderColor: 'var(--border-color)' }}>
              <div className="flex items-center gap-1 text-[10px] font-bold text-muted">Dispatch integration unavailable</div>
              <div className="text-[10px] font-bold text-muted">No live ETA</div>
            </div>
          </div>

          <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '16px', display: 'flex', flexDirection: 'column', gap: '8px' }}>
            <div className="flex items-center gap-2 font-bold text-sm text-dark">
              <svg viewBox="0 0 24 24" fill="none" stroke="var(--primary-color)" strokeWidth="2" width="14" height="14"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" /><polyline points="9 12 11 14 15 10" /></svg>
              Reporter credibility scoring (not connected)
            </div>
            <p className="text-xs text-muted leading-relaxed">This application does not calculate reporter trust or credibility scores.</p>
            <div className="flex justify-between items-center mt-2 text-[10px] font-bold">
              <div className="text-muted">False-positive rate: <span className="text-success">Unavailable</span></div>
              <div className="text-muted">Auto-approved: <span className="text-success">None</span></div>
            </div>
          </div>

          <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '16px', display: 'flex', flexDirection: 'column', gap: '8px' }}>
            <div className="flex items-center gap-2 font-bold text-sm text-danger">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" /><line x1="12" y1="9" x2="12" y2="13" /><line x1="12" y1="17" x2="12.01" y2="17" /></svg>
              Hazmat flag (sample only)
            </div>
            <p className="text-xs text-muted leading-relaxed">No hazard detection or emergency-unit dispatch integration is connected.</p>
            <div className="mt-1"><span style={{ backgroundColor: 'var(--danger-light)', color: 'var(--danger)', padding: '2px 6px', borderRadius: '4px', fontSize: '0.65rem', fontWeight: 'bold' }}>Not dispatched</span></div>
          </div>
          
          <div className="flex justify-between items-center text-[10px] font-bold" style={{ color: 'var(--primary-color)' }}>
            <span>Live model: Not connected</span>
            <span className="flex items-center gap-1">Sample content only</span>
          </div>
        </div>

        {/* Executive Actions */}
        <div className="card flex-col" style={{ gap: '16px' }}>
          <div className="flex items-center justify-between">
            <h3 className="font-bold text-md">Executive Ward Actions</h3>
            <svg viewBox="0 0 24 24" fill="none" stroke="var(--primary-color)" strokeWidth="2" width="16" height="16"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2" /></svg>
          </div>
          
          <button className="flex items-center justify-between p-3 rounded-lg text-white" style={{ backgroundColor: '#064e3b', cursor: 'pointer', border: 'none', textAlign: 'left' }}>
            <div className="flex items-center gap-3">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="18" height="18"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" /><polyline points="7 10 12 15 17 10" /><line x1="12" y1="15" x2="12" y2="3" /></svg>
              <div>
                <div className="text-sm font-bold">Export Daily Ward Report</div>
                <div className="text-[10px] text-white opacity-80">PDF, GeoJSON & CSV formats</div>
              </div>
            </div>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><path d="M9 18l6-6-6-6" /></svg>
          </button>
          
          <button className="flex items-center justify-between p-3 rounded-lg text-white" style={{ backgroundColor: '#b91c1c', cursor: 'pointer', border: 'none', textAlign: 'left' }}>
            <div className="flex items-center gap-3">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="18" height="18"><path d="M2 12h3" /><path d="M19 12h3" /><path d="M12 2v3" /><path d="M12 19v3" /><path d="M4.93 4.93l2.12 2.12" /><path d="M16.95 16.95l2.12 2.12" /><path d="M4.93 19.07l2.12-2.12" /><path d="M16.95 7.05l2.12-2.12" /></svg>
              <div>
                <div className="text-sm font-bold">Broadcast Alert to Field Squads</div>
                <div className="text-[10px] text-white opacity-80 line-clamp-1">Push radio & SMS prompt to all 18 units</div>
              </div>
            </div>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><path d="M9 18l6-6-6-6" /></svg>
          </button>

          <div className="flex items-center justify-between p-3 bg-gray-50 border rounded-lg">
            <div className="flex items-center gap-2">
              <svg viewBox="0 0 24 24" fill="none" stroke="var(--text-muted)" strokeWidth="2" width="16" height="16"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z" /></svg>
              <div className="text-xs font-bold text-muted">Emergency Municipal<br/>Toll:</div>
            </div>
            <div className="flex items-center gap-1">
              <div className="text-lg font-bold text-dark">1912</div>
              <div className="text-[10px] font-bold text-primary">Priority<br/>#1</div>
            </div>
          </div>
        </div>

        {/* Profile Card */}
        <div className="flex items-center gap-3 p-4 bg-primary-light rounded-xl mt-auto" style={{ backgroundColor: '#f0fdf4' }}>
          <div style={{ backgroundColor: 'var(--success-light)', color: 'var(--success)', padding: '8px', borderRadius: '8px' }}>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="18" height="18"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" /><path d="M9 12l2 2 4-4" /></svg>
          </div>
          <div className="flex-1">
            <div className="text-sm font-bold">Rajesh Kumar, Senior San.<br/>Officer</div>
            <div className="text-[10px] font-bold text-muted">BBMP East Jurisdiction ID:<br/>#EMP-8841</div>
          </div>
          <div style={{ backgroundColor: 'white', color: 'var(--success)', padding: '4px 8px', borderRadius: '4px', fontSize: '0.65rem', fontWeight: 'bold', border: '1px solid var(--border-color)' }}>
            On<br/>Duty
          </div>
        </div>
      </div>
    </div>
  );
};

export default DashboardView;
