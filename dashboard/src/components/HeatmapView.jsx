import React from 'react';

const HeatmapView = () => {
  return (
    <div style={{ display: 'flex', gap: '24px', height: '100%', margin: '-24px' }}>
      {/* Map Area */}
      <div style={{ flex: 1, position: 'relative', overflow: 'hidden' }}>
        {/* Mock Map Background */}
        <div style={{ width: '100%', height: '100%', backgroundImage: 'url(https://images.unsplash.com/photo-1524661135-423995f22d0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80)', backgroundSize: 'cover', backgroundPosition: 'center', opacity: 0.6 }}>
          {/* Color overlays to simulate heatmap */}
          <div style={{ position: 'absolute', top: '40%', left: '30%', width: '150px', height: '150px', borderRadius: '50%', background: 'radial-gradient(circle, rgba(239,68,68,0.6) 0%, rgba(239,68,68,0) 70%)', filter: 'blur(20px)' }}></div>
          <div style={{ position: 'absolute', top: '60%', left: '50%', width: '200px', height: '200px', borderRadius: '50%', background: 'radial-gradient(circle, rgba(245,158,11,0.5) 0%, rgba(245,158,11,0) 70%)', filter: 'blur(20px)' }}></div>
          <div style={{ position: 'absolute', top: '30%', left: '60%', width: '100px', height: '100px', borderRadius: '50%', background: 'radial-gradient(circle, rgba(16,185,129,0.5) 0%, rgba(16,185,129,0) 70%)', filter: 'blur(15px)' }}></div>
        </div>

        {/* Map Controls */}
        <div style={{ position: 'absolute', top: '16px', left: '16px', display: 'flex', gap: '12px', alignItems: 'center' }}>
          <div className="flex bg-white rounded-lg shadow-md border overflow-hidden">
            <div className="flex items-center gap-2 px-3 py-2 bg-primary text-white text-xs font-bold" style={{ backgroundColor: '#065f46' }}>
              <svg viewBox="0 0 24 24" fill="currentColor" width="14" height="14"><path d="M17.5 19c-1.3 0-2.3-1-2.3-2.3a2.3 2.3 0 0 1 4.6 0c0 1.3-1 2.3-2.3 2.3z" /><path d="M6.5 19c-1.3 0-2.3-1-2.3-2.3a2.3 2.3 0 0 1 4.6 0c0 1.3-1 2.3-2.3 2.3z" /><path d="M12 5c-1.3 0-2.3-1-2.3-2.3a2.3 2.3 0 0 1 4.6 0c0 1.3-1 2.3-2.3 2.3z" /></svg>
              Hot Zones (Critical Waste Hubs)
              <span style={{ backgroundColor: 'var(--danger)', padding: '2px 6px', borderRadius: '4px', marginLeft: '4px' }}>48</span>
            </div>
            <div className="flex items-center gap-2 px-3 py-2 bg-white text-xs font-bold text-muted cursor-pointer hover:bg-gray-50">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z" /></svg>
              Cold Zones (Inspect Neglected)
              <span style={{ backgroundColor: '#e2e8f0', color: 'var(--text-dark)', padding: '2px 6px', borderRadius: '4px', marginLeft: '4px' }}>12</span>
            </div>
          </div>

          <div className="flex items-center gap-2 px-3 py-2 bg-white rounded-lg shadow-md border text-xs font-bold cursor-pointer">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><polygon points="12 2 2 7 12 12 22 7 12 2" /><polyline points="2 17 12 22 22 17" /><polyline points="2 12 12 17 22 12" /></svg>
            Layer: Sensory Composite Heatmap
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="12" height="12"><polyline points="6 9 12 15 18 9" /></svg>
          </div>
        </div>

        {/* Map Pointers (Mockup) */}
        <div style={{ position: 'absolute', top: '45%', left: '35%', backgroundColor: 'var(--danger)', color: 'white', padding: '4px 8px', borderRadius: '4px', fontSize: '10px', fontWeight: 'bold', display: 'flex', alignItems: 'center', gap: '4px' }}>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="10" height="10"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" /><line x1="12" y1="9" x2="12" y2="13" /><line x1="12" y1="17" x2="12.01" y2="17" /></svg>
          18
        </div>
        
        <div style={{ position: 'absolute', top: '65%', left: '55%', backgroundColor: 'var(--warning)', color: 'white', padding: '4px 8px', borderRadius: '4px', fontSize: '10px', fontWeight: 'bold', display: 'flex', alignItems: 'center', gap: '4px' }}>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="10" height="10"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" /></svg>
          4
        </div>
        
        <div style={{ position: 'absolute', top: '35%', left: '70%', backgroundColor: 'var(--success)', color: 'white', padding: '4px 8px', borderRadius: '100px', fontSize: '10px', fontWeight: 'bold', display: 'flex', alignItems: 'center', gap: '4px' }}>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="10" height="10"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" /><polyline points="22 4 12 14.01 9 11.01" /></svg>
          100% OK
        </div>

        {/* Right side floating controls */}
        <div style={{ position: 'absolute', top: '16px', right: '16px', display: 'flex', flexDirection: 'column', gap: '8px' }}>
          <div className="bg-white rounded-lg shadow-md border flex-col overflow-hidden">
            <button style={{ padding: '8px', border: 'none', background: 'none', cursor: 'pointer', borderBottom: '1px solid #e2e8f0' }}><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="16" height="16"><line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" /></svg></button>
            <button style={{ padding: '8px', border: 'none', background: 'none', cursor: 'pointer', borderBottom: '1px solid #e2e8f0' }}><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="16" height="16"><line x1="5" y1="12" x2="19" y2="12" /></svg></button>
            <button style={{ padding: '8px', border: 'none', background: 'none', cursor: 'pointer' }}><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="16" height="16"><circle cx="12" cy="12" r="10" /><circle cx="12" cy="12" r="3" /></svg></button>
          </div>
        </div>

        {/* Bottom Legend */}
        <div style={{ position: 'absolute', bottom: '16px', left: '16px', display: 'flex', gap: '16px', backgroundColor: 'white', padding: '12px', borderRadius: '12px', boxShadow: 'var(--shadow-md)', border: '1px solid var(--border-color)' }}>
          <div className="flex items-center gap-4 text-xs font-bold">
            <span className="text-muted">HEAT<br/>INDEX:</span>
            <div className="flex items-center gap-2"><div style={{width:12,height:12,borderRadius:'50%',backgroundColor:'var(--danger)'}}></div> Severe /<br/>Chronic</div>
            <div className="flex items-center gap-2"><div style={{width:12,height:12,borderRadius:'50%',backgroundColor:'var(--warning)'}}></div> Moderate<br/>Debris</div>
          </div>
          <div style={{ width: '1px', backgroundColor: 'var(--border-color)' }}></div>
          <div className="flex items-center gap-4">
            <div>
              <div className="text-[10px] font-bold text-muted">Ward Sanitation Index</div>
              <div className="flex items-end gap-2">
                <span className="text-lg font-bold">87.4 / 100</span>
                <span className="text-success text-xs font-bold mb-1 flex items-center"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" width="10" height="10"><polyline points="18 15 12 9 6 15" /></svg> +3.2%</span>
              </div>
            </div>
            <svg viewBox="0 0 100 30" width="80" height="24">
              <path d="M0,25 Q10,20 20,25 T40,20 T60,10 T80,15 T100,5" fill="none" stroke="var(--success)" strokeWidth="2" />
            </svg>
          </div>
        </div>
      </div>

      {/* Right Sidebar - GIS Filters */}
      <div style={{ width: '380px', backgroundColor: 'white', borderLeft: '1px solid var(--border-color)', display: 'flex', flexDirection: 'column', height: '100%', overflowY: 'auto' }}>
        <div className="p-5 border-b border-gray-200 sticky top-0 bg-white z-10 flex justify-between items-center">
          <div className="flex items-center gap-3">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="20" height="20"><polygon points="3 6 9 3 15 6 21 3 21 18 15 21 9 18 3 21" /><line x1="9" y1="3" x2="9" y2="18" /><line x1="15" y1="6" x2="15" y2="21" /></svg>
            <div>
              <h2 className="font-bold text-md">GIS Filters & Priority</h2>
              <p className="text-[10px] text-muted font-bold">वार्ड 142 • इन्दिरा नगर</p>
            </div>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="16" height="16" className="text-muted cursor-pointer"><path d="M21.5 2v6h-6M2.5 22v-6h6M2 11.5a10 10 0 0 1 18.8-4.3M22 12.5a10 10 0 0 1-18.8 4.3" /></svg>
        </div>

        <div className="p-5 flex-col" style={{ gap: '20px' }}>
          {/* Filters */}
          <div>
            <div className="text-[10px] font-bold text-muted uppercase mb-3">Waste Category</div>
            <div className="grid grid-cols-2 gap-2" style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '8px' }}>
              <div className="flex justify-center items-center gap-2 p-2 rounded-md font-bold text-xs cursor-pointer text-white" style={{ backgroundColor: 'var(--primary-color)' }}>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><line x1="8" y1="6" x2="21" y2="6" /><line x1="8" y1="12" x2="21" y2="12" /><line x1="8" y1="18" x2="21" y2="18" /><line x1="3" y1="6" x2="3.01" y2="6" /><line x1="3" y1="12" x2="3.01" y2="12" /><line x1="3" y1="18" x2="3.01" y2="18" /></svg>
                All Types
              </div>
              <div className="flex justify-center items-center gap-2 p-2 rounded-md font-bold text-xs cursor-pointer bg-white border text-muted">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><polyline points="3 6 5 6 21 6" /><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2" /></svg>
                Dumps
              </div>
              <div className="flex justify-center items-center gap-2 p-2 rounded-md font-bold text-xs cursor-pointer bg-white border text-muted">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z" /></svg>
                Overflow Bins
              </div>
              <div className="flex justify-center items-center gap-2 p-2 rounded-md font-bold text-xs cursor-pointer bg-white border text-muted">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><circle cx="12" cy="12" r="10" /><path d="M8 14s1.5 2 4 2 4-2 4-2" /><line x1="9" y1="9" x2="9.01" y2="9" /><line x1="15" y1="9" x2="15.01" y2="9" /></svg>
                Waste Burning
              </div>
              <div className="col-span-2 flex justify-center items-center gap-2 p-2 rounded-md font-bold text-xs cursor-pointer bg-red-50 text-danger border border-red-100" style={{ gridColumn: 'span 2' }}>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="14" height="14"><path d="M10 2v7.31M14 9.31V2M8.5 2h7M14 9.31L22.61 21A1 1 0 0 1 21.75 22H2.25a1 1 0 0 1-.86-1.5L10 9.31V2" /></svg>
                Hazardous / Medical Waste
              </div>
            </div>
          </div>

          <div>
            <div className="text-[10px] font-bold text-muted uppercase mb-3">Severity Level</div>
            <div className="flex rounded-md border overflow-hidden">
              <div className="flex-1 text-center py-2 text-xs font-bold bg-danger text-white cursor-pointer" style={{ backgroundColor: 'var(--danger)' }}>Critical (Red)</div>
              <div className="flex-1 text-center py-2 text-xs font-bold bg-white text-muted border-l border-r cursor-pointer hover:bg-gray-50">High (Amber)</div>
              <div className="flex-1 text-center py-2 text-xs font-bold bg-white text-muted cursor-pointer hover:bg-gray-50">Normal</div>
            </div>
          </div>

          <div>
            <div className="text-[10px] font-bold text-muted uppercase mb-3">Observation Window</div>
            <div className="flex rounded-md border overflow-hidden">
              <div className="flex-1 text-center py-2 text-xs font-bold text-white cursor-pointer" style={{ backgroundColor: 'var(--primary-color)' }}>Today (24h)</div>
              <div className="flex-1 text-center py-2 text-xs font-bold bg-white text-muted border-l border-r cursor-pointer hover:bg-gray-50">Past 7 Days</div>
              <div className="flex-1 text-center py-2 text-xs font-bold bg-white text-muted cursor-pointer hover:bg-gray-50">Custom</div>
            </div>
          </div>

          <hr style={{ borderColor: 'var(--border-color)', margin: '4px 0' }} />

          {/* Hotspots List */}
          <div>
            <div className="flex justify-between items-center mb-4">
              <div className="flex items-center gap-2">
                <svg viewBox="0 0 24 24" fill="currentColor" className="text-primary" width="16" height="16"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" /></svg>
                <span className="font-bold text-sm">Top 5 Municipal Hotspots</span>
              </div>
              <span className="text-[9px] font-bold text-muted">SLA PRIORITY</span>
            </div>

            <div className="flex-col" style={{ gap: '16px' }}>
              {/* Item 1 */}
              <div>
                <div className="flex items-start gap-3 mb-2">
                  <div style={{ width: 20, height: 20, borderRadius: '50%', backgroundColor: 'var(--danger)', color: 'white', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '10px', fontWeight: 'bold' }}>1</div>
                  <div className="flex-1">
                    <div className="flex justify-between items-start">
                      <div className="font-bold text-sm">CMH Road Vegetable Market</div>
                      <div style={{ backgroundColor: 'var(--danger-light)', color: 'var(--danger)', padding: '2px 6px', borderRadius: '4px', fontSize: '10px', fontWeight: 'bold' }}>Critical</div>
                    </div>
                    <div className="text-[10px] text-muted font-bold mt-1">Ward 142 • Main Cross Road</div>
                  </div>
                </div>
                <div className="flex items-center gap-3 pl-8">
                  <div className="flex items-center gap-1 text-[10px] font-bold text-muted"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="12" height="12"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg> 28 reports</div>
                  <div className="flex-1 h-1.5 bg-gray-200 rounded-full overflow-hidden">
                    <div style={{ width: '92%', height: '100%', backgroundColor: 'var(--primary-color)' }}></div>
                  </div>
                  <div className="text-[10px] font-bold text-success">92% cleared</div>
                </div>
              </div>

              {/* Item 2 */}
              <div>
                <div className="flex items-start gap-3 mb-2">
                  <div style={{ width: 20, height: 20, borderRadius: '50%', backgroundColor: 'var(--warning)', color: 'white', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '10px', fontWeight: 'bold' }}>2</div>
                  <div className="flex-1">
                    <div className="flex justify-between items-start">
                      <div className="font-bold text-sm">100ft Road Metro Pillar 84</div>
                      <div style={{ backgroundColor: 'var(--warning-light)', color: '#b45309', padding: '2px 6px', borderRadius: '4px', fontSize: '10px', fontWeight: 'bold' }}>High</div>
                    </div>
                    <div className="text-[10px] text-muted font-bold mt-1">Ward 142 • Underpass Junction</div>
                  </div>
                </div>
                <div className="flex items-center gap-3 pl-8">
                  <div className="flex items-center gap-1 text-[10px] font-bold text-muted"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="12" height="12"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg> 19 reports</div>
                  <div className="flex-1 h-1.5 bg-gray-200 rounded-full overflow-hidden">
                    <div style={{ width: '84%', height: '100%', backgroundColor: 'var(--primary-color)' }}></div>
                  </div>
                  <div className="text-[10px] font-bold text-success">84% cleared</div>
                </div>
              </div>

              {/* Item 3 */}
              <div>
                <div className="flex items-start gap-3 mb-2">
                  <div style={{ width: 20, height: 20, borderRadius: '50%', backgroundColor: 'var(--primary-color)', color: 'white', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '10px', fontWeight: 'bold' }}>3</div>
                  <div className="flex-1">
                    <div className="flex justify-between items-start">
                      <div className="font-bold text-sm">Indiranagar Club Periphery</div>
                      <div style={{ backgroundColor: 'var(--success-light)', color: 'var(--success)', padding: '2px 6px', borderRadius: '4px', fontSize: '10px', fontWeight: 'bold' }}>Medium</div>
                    </div>
                    <div className="text-[10px] text-muted font-bold mt-1">Ward 142 • Residential Link</div>
                  </div>
                </div>
                <div className="flex items-center gap-3 pl-8">
                  <div className="flex items-center gap-1 text-[10px] font-bold text-muted"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="12" height="12"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg> 14 reports</div>
                  <div className="flex-1 h-1.5 bg-gray-200 rounded-full overflow-hidden">
                    <div style={{ width: '100%', height: '100%', backgroundColor: 'var(--primary-color)' }}></div>
                  </div>
                  <div className="text-[10px] font-bold text-success">100% cleared</div>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Action Panel */}
        <div className="p-5 mt-auto bg-gray-50 border-t border-gray-200" style={{ position: 'sticky', bottom: 0 }}>
          <div className="flex justify-between items-center mb-3">
            <span className="text-[10px] font-bold text-muted">Target Selected:</span>
            <span className="text-xs font-bold text-dark">CMH Road Vegetable Market</span>
          </div>
          <button className="w-full flex items-center justify-center gap-2 py-3 rounded-md text-white font-bold text-sm cursor-pointer shadow-sm hover:opacity-90 transition-opacity" style={{ backgroundColor: 'var(--primary-color)', border: 'none' }}>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" width="18" height="18"><rect x="1" y="3" width="15" height="13"></rect><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon><circle cx="5.5" cy="18.5" r="2.5"></circle><circle cx="18.5" cy="18.5" r="2.5"></circle></svg>
            Deploy Sanitation Sweeper
          </button>
          <p className="text-[9px] text-muted text-center mt-3 font-semibold">Dispatches Tier-1 Municipal Rapid Response Squad</p>
        </div>
      </div>
    </div>
  );
};

export default HeatmapView;
