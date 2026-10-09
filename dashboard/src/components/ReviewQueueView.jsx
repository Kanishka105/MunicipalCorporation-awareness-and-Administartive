import React from 'react';

const ReviewQueueView = () => {
  return (
    <div style={{ display: 'flex', gap: '24px', height: '100%', margin: '-24px' }}>
      
      {/* Main Column */}
      <div style={{ flex: 1, padding: '24px', display: 'flex', flexDirection: 'column', overflowY: 'auto' }}>
        
        {/* Header Banner */}
        <div style={{ padding: '20px', backgroundColor: 'white', borderRadius: '12px', boxShadow: 'var(--shadow-sm)', border: '1px solid var(--border-color)', marginBottom: '24px' }}>
          <div className="flex items-center gap-3 mb-2">
            <div style={{ backgroundColor: 'var(--danger-light)', color: 'var(--danger)', padding: '8px', borderRadius: '8px' }}>
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="20" height="20"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" /><line x1="12" y1="9" x2="12" y2="13" /><line x1="12" y1="17" x2="12.01" y2="17" /></svg>
            </div>
            <div>
              <h2 className="font-bold text-lg">AI Review Queue <span className="text-sm font-normal text-muted">/ एआई समीक्षा कतार</span></h2>
              <p className="text-sm text-muted">Low-confidence multi-modal computer vision detections awaiting human sanitary officer adjudication.</p>
            </div>
          </div>
          <div className="flex items-center gap-4 mt-4">
            <div className="flex items-center gap-2 px-3 py-1.5 bg-red-50 text-danger text-xs font-bold rounded-full border border-red-100">
              <div style={{width:6,height:6,borderRadius:'50%',backgroundColor:'var(--danger)'}}></div>
              24 Pending Human Verifications
            </div>
            <div className="flex items-center gap-2 text-xs font-bold text-muted">
              Batch SLA Expiring: <span className="bg-gray-100 px-2 py-1 rounded-md text-dark">01:42:18</span>
            </div>
            <button className="flex items-center gap-2 ml-auto px-4 py-1.5 bg-white border border-gray-200 rounded-md text-xs font-bold text-primary shadow-sm hover:bg-gray-50 cursor-pointer">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12" /></svg>
              Audit Log
            </button>
          </div>
        </div>

        {/* Filters */}
        <div style={{ backgroundColor: 'white', padding: '16px', borderRadius: '12px', border: '1px solid var(--border-color)', marginBottom: '24px' }}>
          <div className="flex gap-4 items-center">
            <div className="flex-1 relative">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="16" height="16" className="absolute left-3 top-1/2" style={{ transform: 'translateY(-50%)', color: 'var(--text-muted)' }}><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
              <input type="text" placeholder="Search Incident ID, Ward, Landmark or Label..." style={{ width: '100%', padding: '10px 10px 10px 36px', borderRadius: '8px', border: 'none', backgroundColor: 'var(--bg-color)', fontSize: '0.85rem' }} />
            </div>
            <div className="flex items-center gap-2 text-xs font-bold text-muted">
              SORT:
              <select style={{ padding: '8px 12px', borderRadius: '8px', border: 'none', backgroundColor: 'var(--bg-color)', fontSize: '0.85rem', fontWeight: 'bold' }}>
                <option>Highest Risk</option>
              </select>
            </div>
          </div>
          
          <div className="flex items-center gap-4 mt-4 text-sm font-semibold">
            <div className="flex items-center gap-2">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14" className="text-muted"><rect x="3" y="11" width="18" height="11" rx="2" ry="2" /><path d="M7 11V7a5 5 0 0 1 10 0v4" /></svg>
              <span className="text-muted text-xs">Confidence:</span>
              <select style={{ border: 'none', outline: 'none', backgroundColor: 'transparent', fontWeight: 'bold', fontSize: '0.8rem', cursor: 'pointer' }}><option>All Low Conf (&lt;70%)</option></select>
            </div>
            <div className="flex items-center gap-2">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14" className="text-muted"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" /></svg>
              <span className="text-muted text-xs">Reporter Trust:</span>
              <select style={{ border: 'none', outline: 'none', backgroundColor: 'transparent', fontWeight: 'bold', fontSize: '0.8rem', cursor: 'pointer' }}><option>All Levels (Tier 1-4)</option></select>
            </div>
            <div className="flex items-center gap-2">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14" className="text-muted"><circle cx="12" cy="12" r="10" /><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" /><path d="M2 12h20" /></svg>
              <span className="text-muted text-xs">Zone:</span>
              <select style={{ border: 'none', outline: 'none', backgroundColor: 'transparent', fontWeight: 'bold', fontSize: '0.8rem', cursor: 'pointer' }}><option>East Zone (Indiranagar / HAL)</option></select>
            </div>
            
            <button className="ml-auto text-primary text-xs font-bold bg-transparent border-none cursor-pointer flex items-center gap-1">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="12" height="12"><path d="M3 12a9 9 0 1 0 9-9 9.75 9.75 0 0 0-6.74 2.74L3 8" /><path d="M3 3v5h5" /></svg>
              Reset Filters
            </button>
          </div>
        </div>

        {/* Table List */}
        <div style={{ backgroundColor: 'white', borderRadius: '12px', border: '1px solid var(--border-color)', flex: 1 }}>
          <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left', fontSize: '0.8rem' }}>
            <thead>
              <tr style={{ borderBottom: '1px solid var(--border-color)', backgroundColor: 'var(--bg-color)' }}>
                <th style={{ padding: '12px 16px', fontWeight: 700, color: 'var(--text-muted)' }}>EVIDENCE</th>
                <th style={{ padding: '12px 16px', fontWeight: 700, color: 'var(--text-muted)' }}>TICKET ID</th>
                <th style={{ padding: '12px 16px', fontWeight: 700, color: 'var(--text-muted)' }}>AUTO AI LABELS</th>
                <th style={{ padding: '12px 16px', fontWeight: 700, color: 'var(--text-muted)' }}>AI CONF.</th>
                <th style={{ padding: '12px 16px', fontWeight: 700, color: 'var(--text-muted)' }}>LOCATION / WARD</th>
                <th style={{ padding: '12px 16px', fontWeight: 700, color: 'var(--text-muted)' }}>TRUST SCORE</th>
                <th style={{ padding: '12px 16px', fontWeight: 700, color: 'var(--text-muted)', textAlign: 'center' }}>QUICK ACTION</th>
              </tr>
            </thead>
            <tbody>
              {/* Row 1 (Active) */}
              <tr style={{ backgroundColor: '#f0fdf4', borderBottom: '1px solid var(--border-color)', position: 'relative' }}>
                <td style={{ padding: '12px 16px' }}>
                  <div style={{ position: 'relative', width: '48px', height: '48px', borderRadius: '6px', overflow: 'hidden' }}>
                    <img src="https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80" alt="ev" style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                    <div style={{ position: 'absolute', bottom: 0, right: 0, backgroundColor: 'var(--primary-color)', color: 'white', fontSize: '8px', fontWeight: 'bold', padding: '2px 4px', borderRadius: '4px 0 0 0' }}>#1</div>
                  </div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="font-bold text-primary">#CC-<br/>84950</div>
                  <div className="text-[10px] text-muted mt-1">12m ago</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="font-bold">Construction Debris / Pothole?</div>
                  <div className="text-[10px] text-muted">मलबा या गड्ढा?</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div style={{ backgroundColor: 'var(--warning-light)', color: '#b45309', padding: '4px 8px', borderRadius: '6px', fontSize: '10px', fontWeight: 'bold', display: 'inline-block' }}>64%<br/>Conf</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="font-bold">6th Main Indiranagar</div>
                  <div className="text-[10px] text-muted">Ward 142 • Pole #E-94</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="flex items-center gap-1">
                    <svg viewBox="0 0 24 24" fill="none" stroke="var(--success)" strokeWidth="2" width="14" height="14"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" /></svg>
                    <div>
                      <div className="font-bold text-success text-xs">98%</div>
                      <div className="text-[9px] text-muted leading-tight">High<br/>Trust</div>
                    </div>
                  </div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="flex items-center justify-center gap-2">
                    <button style={{ width: '28px', height: '28px', borderRadius: '6px', border: 'none', backgroundColor: 'var(--primary-color)', color: 'white', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center' }}><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" width="14" height="14"><polyline points="20 6 9 17 4 12" /></svg></button>
                    <button style={{ width: '28px', height: '28px', borderRadius: '6px', border: '1px solid var(--border-color)', backgroundColor: 'var(--bg-color)', color: 'var(--text-muted)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center' }}><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><line x1="18" y1="6" x2="6" y2="18" /><line x1="6" y1="6" x2="18" y2="18" /></svg></button>
                  </div>
                </td>
              </tr>
              
              {/* Row 2 */}
              <tr style={{ borderBottom: '1px solid var(--border-color)' }}>
                <td style={{ padding: '12px 16px' }}>
                  <div style={{ width: '48px', height: '48px', borderRadius: '6px', overflow: 'hidden' }}>
                    <img src="https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80" alt="ev" style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                  </div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="font-bold text-primary">#CC-<br/>84952</div>
                  <div className="text-[10px] text-muted mt-1">26m ago</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="font-bold">Waste Burning or Steam?</div>
                  <div className="text-[10px] text-muted">कचरा दहन या भाप?</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div style={{ backgroundColor: 'var(--warning-light)', color: '#b45309', padding: '4px 8px', borderRadius: '6px', fontSize: '10px', fontWeight: 'bold', display: 'inline-block' }}>58%<br/>Conf</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="font-bold">HAL 2nd Stage</div>
                  <div className="text-[10px] text-muted">Ward 113 • Metro Pillar 84</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="flex items-center gap-1">
                    <svg viewBox="0 0 24 24" fill="none" stroke="var(--success)" strokeWidth="2" width="14" height="14"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" /></svg>
                    <div>
                      <div className="font-bold text-success text-xs">74%</div>
                      <div className="text-[9px] text-muted leading-tight">Med<br/>Trust</div>
                    </div>
                  </div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="flex items-center justify-center gap-2">
                    <button style={{ width: '28px', height: '28px', borderRadius: '6px', border: '1px solid var(--border-color)', backgroundColor: 'var(--bg-color)', color: 'var(--text-muted)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center' }}><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><polyline points="20 6 9 17 4 12" /></svg></button>
                    <button style={{ width: '28px', height: '28px', borderRadius: '6px', border: '1px solid var(--border-color)', backgroundColor: 'var(--bg-color)', color: 'var(--text-muted)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center' }}><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><line x1="18" y1="6" x2="6" y2="18" /><line x1="6" y1="6" x2="18" y2="18" /></svg></button>
                  </div>
                </td>
              </tr>

              {/* Row 3 */}
              <tr style={{ borderBottom: '1px solid var(--border-color)' }}>
                <td style={{ padding: '12px 16px' }}>
                  <div style={{ width: '48px', height: '48px', borderRadius: '6px', overflow: 'hidden' }}>
                    <img src="https://images.unsplash.com/photo-1621360670891-945f3a0937a5?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80" alt="ev" style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                  </div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="font-bold text-primary">#CC-<br/>84955</div>
                  <div className="text-[10px] text-muted mt-1">41m ago</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="font-bold">Chemical Liquid or Water Puddle?</div>
                  <div className="text-[10px] text-muted">रासायनिक रिसाव या पानी?</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div style={{ backgroundColor: 'var(--warning-light)', color: '#b45309', padding: '4px 8px', borderRadius: '6px', fontSize: '10px', fontWeight: 'bold', display: 'inline-block' }}>61%<br/>Conf</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="font-bold">Domlur Flyover Ramp</div>
                  <div className="text-[10px] text-muted">Ward 112 • Service Road</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="flex items-center gap-1">
                    <svg viewBox="0 0 24 24" fill="none" stroke="var(--success)" strokeWidth="2" width="14" height="14"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" /></svg>
                    <div>
                      <div className="font-bold text-success text-xs">92%</div>
                      <div className="text-[9px] text-muted leading-tight">High<br/>Trust</div>
                    </div>
                  </div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="flex items-center justify-center gap-2">
                    <button style={{ width: '28px', height: '28px', borderRadius: '6px', border: '1px solid var(--border-color)', backgroundColor: 'var(--bg-color)', color: 'var(--text-muted)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center' }}><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><polyline points="20 6 9 17 4 12" /></svg></button>
                    <button style={{ width: '28px', height: '28px', borderRadius: '6px', border: '1px solid var(--border-color)', backgroundColor: 'var(--bg-color)', color: 'var(--text-muted)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center' }}><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><line x1="18" y1="6" x2="6" y2="18" /><line x1="6" y1="6" x2="18" y2="18" /></svg></button>
                  </div>
                </td>
              </tr>
              
              {/* Row 4 */}
              <tr>
                <td style={{ padding: '12px 16px' }}>
                  <div style={{ width: '48px', height: '48px', borderRadius: '6px', overflow: 'hidden' }}>
                    <img src="https://images.unsplash.com/photo-1550989460-0adf9ea622e2?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80" alt="ev" style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                  </div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="font-bold text-primary">#CC-<br/>84960</div>
                  <div className="text-[10px] text-muted mt-1">1h 05m ago</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="font-bold text-danger">Animal Carcass or Stray Dog?</div>
                  <div className="text-[10px] text-muted">मृत पशु या श्वान?</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div style={{ backgroundColor: 'var(--danger-light)', color: 'var(--danger)', padding: '4px 8px', borderRadius: '6px', fontSize: '10px', fontWeight: 'bold', display: 'inline-block' }}>52%<br/>Conf</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="font-bold">Ulsoor Lake Road</div>
                  <div className="text-[10px] text-muted">Ward 110 • Promenade Gate</div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="flex items-center gap-1">
                    <svg viewBox="0 0 24 24" fill="none" stroke="var(--warning)" strokeWidth="2" width="14" height="14"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" /></svg>
                    <div>
                      <div className="font-bold text-warning text-xs" style={{color: 'var(--text-dark)'}}>65%</div>
                      <div className="text-[9px] text-muted leading-tight">Med<br/>Trust</div>
                    </div>
                  </div>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <div className="flex items-center justify-center gap-2">
                    <button style={{ width: '28px', height: '28px', borderRadius: '6px', border: '1px solid var(--border-color)', backgroundColor: 'var(--bg-color)', color: 'var(--text-muted)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center' }}><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><polyline points="20 6 9 17 4 12" /></svg></button>
                    <button style={{ width: '28px', height: '28px', borderRadius: '6px', border: '1px solid var(--border-color)', backgroundColor: 'var(--bg-color)', color: 'var(--text-muted)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center' }}><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><line x1="18" y1="6" x2="6" y2="18" /><line x1="6" y1="6" x2="18" y2="18" /></svg></button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
          
          <div className="flex items-center justify-between p-3 border-t border-gray-200 bg-gray-50 rounded-b-xl">
            <span className="text-xs font-bold text-muted">Showing 4 of 24 triage tickets requiring officer inspection</span>
            <div className="flex gap-1">
              <button className="px-3 py-1 bg-white border border-gray-200 rounded text-xs font-bold text-muted">Previous</button>
              <button className="px-3 py-1 bg-primary text-white rounded text-xs font-bold border-none" style={{ backgroundColor: 'var(--primary-color)' }}>1</button>
              <button className="px-3 py-1 bg-white border border-gray-200 rounded text-xs font-bold text-muted">2</button>
              <button className="px-3 py-1 bg-white border border-gray-200 rounded text-xs font-bold text-muted">3</button>
              <button className="px-3 py-1 bg-white border border-gray-200 rounded text-xs font-bold text-muted">Next</button>
            </div>
          </div>
        </div>

        <div className="mt-4 p-4 flex gap-3 rounded-xl border border-gray-200 bg-gray-50">
          <svg viewBox="0 0 24 24" fill="none" stroke="var(--primary-color)" strokeWidth="2" width="20" height="20" style={{marginTop: '2px'}}><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" /><polyline points="9 12 11 14 15 10" /></svg>
          <div>
            <h4 className="text-xs font-bold mb-1">BBMP Civic AI Protocol 4.2</h4>
            <p className="text-xs text-muted leading-relaxed">When reviewing confidence scores below 65%, check camera accelerometer metadata. High reporter trust (&gt;90%) indicates human consistency and qualifies for immediate rapid-squad deployment.</p>
          </div>
        </div>
      </div>

      {/* Right Sidebar - Detail View */}
      <div style={{ width: '400px', backgroundColor: 'var(--sidebar-bg)', borderLeft: '1px solid var(--border-color)', display: 'flex', flexDirection: 'column', height: '100%', overflowY: 'auto' }}>
        <div className="p-5 flex-col" style={{ gap: '20px' }}>
          
          <div className="flex justify-between items-start">
            <div>
              <div className="flex items-center gap-2 mb-1">
                <h2 className="text-2xl font-bold">#CC-84950</h2>
                <span className="bg-primary-light text-primary px-3 py-1 rounded-full text-[10px] font-bold" style={{ backgroundColor: 'var(--success-light)', color: 'var(--success)' }}>Inspection Detail</span>
              </div>
              <p className="text-xs font-bold text-dark">Uploaded today at 09:42 AM via Citizen App</p>
            </div>
            <div className="flex gap-2">
              <button className="w-8 h-8 rounded-full bg-white border border-gray-200 flex items-center justify-center"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><path d="M15 3h6v6M9 21H3v-6M21 3l-7 7M3 21l7-7" /></svg></button>
              <button className="w-8 h-8 rounded-full bg-white border border-gray-200 flex items-center justify-center"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4M7 10l5 5 5-5M12 15V3" /></svg></button>
            </div>
          </div>

          {/* AI Image Analysis */}
          <div style={{ position: 'relative', borderRadius: '12px', overflow: 'hidden', height: '240px' }}>
            <img src="https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Detail" style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
            
            {/* Top tabs */}
            <div className="absolute top-0 left-0 w-full flex bg-white opacity-90 text-[10px] font-bold text-muted">
              <div className="px-3 py-1.5 border-r border-b border-primary text-primary" style={{ borderBottomColor: 'var(--primary-color)' }}>Visual Inspection</div>
              <div className="px-3 py-1.5 border-r border-gray-200">Low Priority</div>
              <div className="px-3 py-1.5">Flagged</div>
            </div>

            {/* Bounding Boxes */}
            <div className="absolute" style={{ top: '30%', left: '20%', width: '120px', height: '80px', border: '2px solid var(--warning)', backgroundColor: 'rgba(245,158,11,0.2)' }}>
              <div className="absolute -top-6 left-0 bg-warning text-white text-[9px] font-bold px-2 py-1" style={{ backgroundColor: 'var(--warning)', whiteSpace: 'nowrap' }}>BOX 01: Crushed Concrete (64.2%)</div>
            </div>
            
            <div className="absolute" style={{ top: '55%', left: '50%', width: '100px', height: '50px', border: '2px solid var(--primary-color)', backgroundColor: 'rgba(12,106,70,0.2)' }}>
              <div className="absolute -top-4 left-0 text-white text-[9px] font-bold px-2 py-1" style={{ backgroundColor: 'var(--primary-color)', whiteSpace: 'nowrap' }}>BOX 02: Pothole Pit (31.8%)</div>
            </div>

            <div className="absolute" style={{ top: '45%', left: '42%' }}>
              <svg viewBox="0 0 24 24" fill="none" stroke="white" strokeWidth="2" width="16" height="16"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" /><line x1="12" y1="9" x2="12" y2="13" /><line x1="12" y1="17" x2="12.01" y2="17" /></svg>
            </div>

            {/* Bottom Overlay */}
            <div className="absolute bottom-0 left-0 w-full flex justify-between items-center px-3 py-2 bg-slate-800 text-white text-[10px] font-bold" style={{ backgroundColor: 'rgba(30,41,59,0.9)' }}>
              <div className="flex items-center gap-2">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="12" height="12"><polygon points="12 2 2 7 12 12 22 7 12 2" /><polyline points="2 17 12 22 22 17" /><polyline points="2 12 12 17 22 12" /></svg>
                Model Layer: YOLOv9-Civic
              </div>
              <div className="flex items-center gap-3">
                <div className="flex items-center gap-1"><div className="w-3 h-3 bg-white flex items-center justify-center rounded-sm"><svg viewBox="0 0 24 24" fill="none" stroke="black" strokeWidth="3" width="8" height="8"><polyline points="20 6 9 17 4 12" /></svg></div> BBox</div>
                <div className="flex items-center gap-1"><div className="w-3 h-3 bg-white flex items-center justify-center rounded-sm"><svg viewBox="0 0 24 24" fill="none" stroke="black" strokeWidth="3" width="8" height="8"><polyline points="20 6 9 17 4 12" /></svg></div> Heatmap</div>
              </div>
            </div>
          </div>

          {/* AI Logic Stats */}
          <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
            <div className="flex justify-between items-center p-3 border-b border-gray-200">
              <div className="flex items-center gap-2 font-bold text-sm">
                <svg viewBox="0 0 24 24" fill="none" stroke="var(--primary-color)" strokeWidth="2" width="16" height="16"><circle cx="12" cy="12" r="10" /><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" /><path d="M2 12h20" /></svg>
                AI Classification Logic
              </div>
              <div className="text-[10px] text-right">
                <div className="text-muted font-bold mb-1">Infer-Latency:</div>
                <div className="font-bold">142ms</div>
              </div>
            </div>
            <div className="p-4 flex-col gap-3">
              <div>
                <div className="flex justify-between text-xs font-bold mb-1">
                  <span>Primary: Crushed Concrete / Debris</span>
                  <span className="text-warning" style={{ color: '#b45309' }}>64.2%</span>
                </div>
                <div className="w-full h-1.5 bg-gray-100 rounded-full overflow-hidden">
                  <div className="h-full bg-warning" style={{ width: '64.2%', backgroundColor: 'var(--warning)' }}></div>
                </div>
              </div>
              <div>
                <div className="flex justify-between text-xs font-bold mb-1 mt-3">
                  <span>Secondary: Asphalt Pothole</span>
                  <span className="text-muted">31.8%</span>
                </div>
                <div className="w-full h-1.5 bg-gray-100 rounded-full overflow-hidden">
                  <div className="h-full bg-gray-300" style={{ width: '31.8%' }}></div>
                </div>
              </div>
            </div>
            <div className="p-3 bg-gray-50 border-t border-gray-200 flex items-start gap-2">
              <svg viewBox="0 0 24 24" fill="none" stroke="var(--success)" strokeWidth="2" width="16" height="16" className="mt-0.5"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" /><polyline points="22 4 12 14.01 9 11.01" /></svg>
              <div>
                <div className="text-[10px] font-bold">Camera Integrity: Live Capture Verified</div>
                <div className="text-[9px] text-muted font-bold">EXIF GPS, Gyro & Accelerometer matched (No screen spoofing)</div>
              </div>
            </div>
          </div>

          {/* Trust Profile */}
          <div className="bg-white rounded-xl border border-gray-200 p-4">
            <h4 className="text-[10px] font-bold text-muted uppercase mb-3">REPORTER TRUST PROFILE</h4>
            <div className="flex items-center gap-3 mb-4">
              <div className="w-10 h-10 rounded-full bg-primary flex items-center justify-center text-white font-bold" style={{ backgroundColor: 'var(--primary-color)' }}>PS</div>
              <div className="flex-1">
                <div className="flex items-center gap-1 font-bold text-sm">
                  Priya Sharma
                  <svg viewBox="0 0 24 24" fill="none" stroke="var(--success)" strokeWidth="2" width="14" height="14"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" /><polyline points="22 4 12 14.01 9 11.01" /></svg>
                </div>
                <div className="text-[10px] text-muted font-bold mt-1">Resident • 142 Indiranagar • 6th Main</div>
              </div>
              <div className="text-right">
                <div className="text-[10px] font-bold text-success">Level 4<br/>Citizen</div>
                <div className="text-xs font-bold mt-1">98% Trust</div>
              </div>
            </div>
            
            <div className="grid grid-cols-3 gap-2 border-t border-gray-100 pt-3" style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr' }}>
              <div className="text-center">
                <div className="font-bold text-sm">32</div>
                <div className="text-[9px] font-bold text-muted mt-1">Verified</div>
              </div>
              <div className="text-center border-l border-r border-gray-100">
                <div className="font-bold text-sm text-success">0</div>
                <div className="text-[9px] font-bold text-muted mt-1">False / Spam</div>
              </div>
              <div className="text-center">
                <div className="font-bold text-sm">2.4 hr</div>
                <div className="text-[9px] font-bold text-muted mt-1">Avg Resolve</div>
              </div>
            </div>
          </div>
        </div>

        {/* Action Buttons Fixed at Bottom */}
        <div className="p-5 mt-auto bg-white border-t border-gray-200 flex flex-col gap-3" style={{ position: 'sticky', bottom: 0 }}>
          <button className="w-full flex items-center justify-center gap-2 py-3 rounded-md text-white font-bold text-sm cursor-pointer border-none shadow-md hover:opacity-90" style={{ backgroundColor: 'var(--primary-color)' }}>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="16" height="16"><line x1="22" y1="2" x2="11" y2="13" /><polygon points="22 2 15 22 11 13 2 9 22 2" /></svg>
            Approve & Dispatch Squad
          </button>
          <div className="flex gap-3">
            <button className="flex-1 flex items-center justify-center gap-2 py-2 rounded-md bg-red-50 text-danger font-bold text-xs cursor-pointer border border-red-100">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><circle cx="12" cy="12" r="10" /><line x1="4.93" y1="4.93" x2="19.07" y2="19.07" /></svg>
              Reject as Spam
            </button>
            <button className="flex-1 flex items-center justify-center gap-2 py-2 rounded-md bg-indigo-50 text-indigo-900 font-bold text-xs cursor-pointer border border-indigo-100" style={{ color: '#312e81' }}>
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><line x1="8" y1="6" x2="21" y2="6" /><line x1="8" y1="12" x2="21" y2="12" /><line x1="8" y1="18" x2="21" y2="18" /><line x1="3" y1="6" x2="3.01" y2="6" /><line x1="3" y1="12" x2="3.01" y2="12" /><line x1="3" y1="18" x2="3.01" y2="18" /></svg>
              Re-classify
            </button>
          </div>
        </div>
      </div>

    </div>
  );
};

export default ReviewQueueView;
