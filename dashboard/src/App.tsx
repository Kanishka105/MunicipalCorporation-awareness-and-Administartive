import { useMemo, useState, useEffect, type ComponentType, type ReactNode } from "react";
import {
  Activity,
  AlertTriangle,
  BarChart3,
  Bell,
  Building2,
  CalendarDays,
  Check,
  CheckCircle2,
  ChevronDown,
  ChevronLeft,
  ChevronRight,
  CircleDot,
  ClipboardCheck,
  Clock3,
  Eye,
  EyeOff,
  FileCheck2,
  FileText,
  Filter,
  Gauge,
  History,
  LayoutDashboard,
  LockKeyhole,
  LogOut,
  Map,
  MapPin,
  Menu,
  MessageSquareText,
  MoreHorizontal,
  Paperclip,
  Plus,
  Search,
  Settings,
  ShieldCheck,
  SlidersHorizontal,
  TrendingDown,
  TrendingUp,
  UploadCloud,
  UserRound,
  Users,
  Wrench,
  X,
} from "lucide-react";

type Role = "local" | "high";
type Status = "Open" | "In Progress" | "Pending Approval" | "Resolved" | "Revision Required";
type Issue = {
  id: string;
  title: string;
  category: string;
  location: string;
  coordinates: string;
  date: string;
  priority: "Critical" | "High" | "Medium";
  status: Status;
  department: string;
  image: string;
  marker: [number, number];
};

const roadImage =
  "https://images.unsplash.com/photo-1783753445278-45ddfdf6eb8f?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&q=82&w=900";
const worksImage =
  "https://images.unsplash.com/photo-1558690194-5aaa922b59b6?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&q=82&w=900";
const waterImage =
  "https://images.unsplash.com/photo-1526898943670-92bfa9f94c12?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&q=82&w=900";

const initialIssues: Issue[] = [
  {
    id: "CT-2025-0842",
    title: "Severe road surface damage near school zone",
    category: "Road Damage",
    location: "Civic Center Rd, Ward 12",
    coordinates: "28.6139° N, 77.2090° E",
    date: "14 Jun 2025",
    priority: "Critical",
    status: "Open",
    department: "Public Works",
    image: roadImage,
    marker: [49, 38],
  },
  {
    id: "CT-2025-0837",
    title: "Main pipeline leakage flooding sidewalk",
    category: "Water Leakage",
    location: "Lake View Ave, Ward 09",
    coordinates: "28.6204° N, 77.2143° E",
    date: "13 Jun 2025",
    priority: "High",
    status: "In Progress",
    department: "Water Services",
    image: waterImage,
    marker: [69, 62],
  },
  {
    id: "CT-2025-0819",
    title: "Streetlights non-functional across two blocks",
    category: "Streetlight Failure",
    location: "Nehru Park, Ward 14",
    coordinates: "28.6081° N, 77.1988° E",
    date: "12 Jun 2025",
    priority: "Medium",
    status: "Pending Approval",
    department: "Electrical",
    image: worksImage,
    marker: [29, 67],
  },
  {
    id: "CT-2025-0808",
    title: "Blocked storm drain after heavy rainfall",
    category: "Drainage Problems",
    location: "Market St, Ward 11",
    coordinates: "28.6172° N, 77.2025° E",
    date: "10 Jun 2025",
    priority: "High",
    status: "Resolved",
    department: "Sanitation",
    image: roadImage,
    marker: [34, 29],
  },
];

const statusClass: Record<Status, string> = {
  Open: "status status-open",
  "In Progress": "status status-progress",
  "Pending Approval": "status status-pending",
  Resolved: "status status-resolved",
  "Revision Required": "status status-revision",
};

function Button({
  children,
  variant = "primary",
  icon: Icon,
  onClick,
  type = "button",
  disabled,
  className = "",
}: {
  children: ReactNode;
  variant?: "primary" | "secondary" | "ghost" | "danger";
  icon?: ComponentType<{ size?: number; strokeWidth?: number }>;
  onClick?: () => void;
  type?: "button" | "submit";
  disabled?: boolean;
  className?: string;
}) {
  return (
    <button className={`btn btn-${variant} ${className}`} onClick={onClick} type={type} disabled={disabled}>
      {Icon && <Icon size={16} strokeWidth={2} />}
      {children}
    </button>
  );
}

function Field({
  label,
  placeholder,
  type = "text",
  icon: Icon,
  value,
  onChange,
}: {
  label?: string;
  placeholder?: string;
  type?: string;
  icon?: ComponentType<{ size?: number }>;
  value?: string;
  onChange?: (value: string) => void;
}) {
  return (
    <label className="field">
      {label && <span className="field-label">{label}</span>}
      <span className="input-wrap">
        {Icon && <Icon size={17} />}
        <input
          type={type}
          placeholder={placeholder}
          value={value}
          onChange={(event) => onChange?.(event.target.value)}
        />
      </span>
    </label>
  );
}

function Brand({ dark = false }: { dark?: boolean }) {
  return (
    <div className={`brand ${dark ? "brand-dark" : ""}`}>
      <div className="brand-mark"><Building2 size={22} strokeWidth={2.2} /></div>
      <div>
        <div className="brand-name">CivicTrack</div>
        <div className="brand-sub">Smart Civic Management</div>
      </div>
    </div>
  );
}

function Login({ onLogin }: { onLogin: (role: Role) => void }) {
  const [role, setRole] = useState<Role>("local");
  const [visible, setVisible] = useState(false);
  return (
    <main className="login-page">
      <section className="login-story">
        <div className="login-story-inner">
          <Brand dark />
          <div className="story-copy">
            <div className="eyebrow light">OFFICIAL GOVERNMENT PLATFORM</div>
            <div className="display-title">Stronger communities,<br />resolved together.</div>
            <p>
              A unified command center for faster, transparent and accountable civic issue resolution.
            </p>
          </div>
          <div className="trust-row">
            <div><ShieldCheck size={20} /><span><b>Secure access</b><small>Role-verified authentication</small></span></div>
            <div><Activity size={20} /><span><b>Full auditability</b><small>Every action is recorded</small></span></div>
          </div>
        </div>
      </section>
      <section className="login-panel">
        <div className="login-card">
          <div className="mobile-brand"><Brand /></div>
          <div className="login-heading">
            <div className="eyebrow">AUTHORIZED PERSONNEL</div>
            <div className="title-xl">Welcome back</div>
            <p>Sign in to access your administrative workspace.</p>
          </div>
          <div className="role-switch" aria-label="Select authority role">
            <button className={role === "local" ? "active" : ""} onClick={() => setRole("local")}>
              <MapPin size={17} />Local Authority
            </button>
            <button className={role === "high" ? "active" : ""} onClick={() => setRole("high")}>
              <ShieldCheck size={17} />High Authority
            </button>
          </div>
          <form onSubmit={(event) => { event.preventDefault(); onLogin(role); }}>
            <Field label="Official email or user ID" icon={UserRound} placeholder="officer@civic.gov" />
            <label className="field">
              <span className="field-label">Password</span>
              <span className="input-wrap">
                <LockKeyhole size={17} />
                <input type={visible ? "text" : "password"} placeholder="Enter your password" />
                <button type="button" className="icon-btn" onClick={() => setVisible(!visible)} aria-label="Toggle password visibility">
                  {visible ? <EyeOff size={17} /> : <Eye size={17} />}
                </button>
              </span>
            </label>
            <div className="form-meta">
              <label><input type="checkbox" /> Keep me signed in</label>
              <button type="button">Forgot password?</button>
            </div>
            <Button type="submit" className="full">Sign in securely <ChevronRight size={17} /></Button>
          </form>
          <div className="security-note">
            <LockKeyhole size={16} />
            <span><b>Authorized access only.</b> Your role and permissions are verified by the secure identity service after authentication.</span>
          </div>
          <div className="login-footer">CivicTrack Government Cloud • Privacy • Help desk</div>
        </div>
      </section>
    </main>
  );
}

const localNav = [
  ["Overview", LayoutDashboard],
  ["Issue Map", Map],
  ["All Issues", ClipboardCheck],
  ["Assigned Issues", Wrench],
  ["Resolution Submissions", FileCheck2],
  ["Revision Required", AlertTriangle],
  ["Activity History", History],
] as const;
const highNav = [
  ["Executive Overview", LayoutDashboard],
  ["Analytics", BarChart3],
  ["Regional Performance", Map],
  ["Department Performance", Gauge],
  ["Resolution Approvals", ClipboardCheck],
  ["Review History", History],
  ["Audit Logs", FileText],
] as const;

function Sidebar({
  role,
  active,
  setActive,
  collapsed,
  setCollapsed,
  logout,
}: {
  role: Role;
  active: string;
  setActive: (value: string) => void;
  collapsed: boolean;
  setCollapsed: (value: boolean) => void;
  logout: () => void;
}) {
  const nav = role === "local" ? localNav : highNav;
  return (
    <>
      <aside className={`sidebar ${collapsed ? "collapsed" : ""}`}>
        <div className="sidebar-top">
          <Brand dark />
          <button className="collapse-btn" onClick={() => setCollapsed(!collapsed)} aria-label="Collapse sidebar">
            <ChevronLeft size={17} />
          </button>
        </div>
        <div className="scope-label">{role === "local" ? "LOCAL OPERATIONS" : "EXECUTIVE COMMAND"}</div>
        <nav className="nav-list">
          {nav.map(([label, Icon]) => (
            <button key={label} className={active === label ? "active" : ""} onClick={() => setActive(label)}>
              <Icon size={18} /><span>{label}</span>
              {label === "Resolution Approvals" && <small>12</small>}
              {label === "Revision Required" && <small>3</small>}
            </button>
          ))}
        </nav>
        <div className="sidebar-bottom">
          <button onClick={() => setActive("Profile and Settings")}><Settings size={18} /><span>Profile & Settings</span></button>
          <button onClick={logout}><LogOut size={18} /><span>Sign out</span></button>
          <div className="user-mini">
            <div className="avatar">{role === "local" ? "AK" : "MR"}</div>
            <span><b>{role === "local" ? "Ananya Kapoor" : "Meera Rao"}</b><small>{role === "local" ? "Municipal Officer" : "Regional Commissioner"}</small></span>
            <MoreHorizontal size={17} />
          </div>
        </div>
      </aside>
      {collapsed && <button className="expand-btn" onClick={() => setCollapsed(false)}><Menu size={18} /></button>}
    </>
  );
}

function Topbar({
  role,
  onNotifications,
}: {
  role: Role;
  onNotifications: () => void;
}) {
  return (
    <header className="topbar">
      <div className="mobile-logo"><Building2 size={19} /> CivicTrack</div>
      <div className="global-search"><Search size={17} /><input placeholder="Search issues, submissions or locations…" /></div>
      <div className="top-actions">
        <div className="live-pill"><span /> Systems operational</div>
        <button className="icon-square" onClick={onNotifications} aria-label="Open notifications"><Bell size={18} /><i>4</i></button>
        <div className="authority-chip">
          <div className="avatar">{role === "local" ? "AK" : "MR"}</div>
          <span><b>{role === "local" ? "Ananya Kapoor" : "Meera Rao"}</b><small>{role === "local" ? "Central Zone Authority" : "Office of Commissioner"}</small></span>
          <ChevronDown size={15} />
        </div>
      </div>
    </header>
  );
}

function Badge({ status }: { status: Status }) {
  return <span className={statusClass[status]}><i />{status}</span>;
}

function KpiCard({
  label,
  value,
  note,
  icon: Icon,
  tone = "blue",
  trend,
}: {
  label: string;
  value: string;
  note: string;
  icon: ComponentType<{ size?: number }>;
  tone?: string;
  trend?: "up" | "down";
}) {
  return (
    <div className="kpi-card">
      <div className={`kpi-icon ${tone}`}><Icon size={20} /></div>
      <div className="kpi-label">{label}</div>
      <div className="kpi-value">{value}</div>
      <div className={`kpi-note ${trend || ""}`}>
        {trend === "up" && <TrendingUp size={13} />}
        {trend === "down" && <TrendingDown size={13} />}
        {note}
      </div>
    </div>
  );
}

function PageHeading({ title, subtitle, action }: { title: string; subtitle: string; action?: ReactNode }) {
  return (
    <div className="page-heading">
      <div><div className="title-lg">{title}</div><p>{subtitle}</p></div>
      {action}
    </div>
  );
}

function MiniMap({ issues, selected, onSelect }: { issues: Issue[]; selected?: Issue; onSelect: (issue: Issue) => void }) {
  return (
    <div className="map-canvas">
      <svg className="map-lines" viewBox="0 0 800 460" preserveAspectRatio="none" aria-hidden="true">
        <path d="M-20 110 C170 145, 250 68, 420 120 S650 180, 830 85" />
        <path d="M80 -20 C120 95, 180 170, 130 265 S150 390, 220 490" />
        <path d="M385 -20 C370 100, 430 155, 395 250 S410 370, 510 480" />
        <path d="M620 -20 C560 105, 690 165, 650 255 S590 380, 680 480" />
        <path d="M-20 355 C120 315, 210 390, 345 350 S630 290, 830 365" />
        <path className="minor" d="M0 210 L800 250 M260 0 L290 460 M520 0 L570 460" />
      </svg>
      <div className="map-search"><Search size={16} /><input placeholder="Search location…" /></div>
      <div className="map-zoom"><button><Plus size={16} /></button><button>−</button></div>
      {issues.map((issue) => (
        <button
          key={issue.id}
          className={`map-marker marker-${issue.status.toLowerCase().replaceAll(" ", "-")} ${selected?.id === issue.id ? "selected" : ""}`}
          style={{ left: `${issue.marker[0]}%`, top: `${issue.marker[1]}%` }}
          onClick={() => onSelect(issue)}
          aria-label={`Open ${issue.title}`}
        >
          <MapPin size={20} fill="currentColor" />
        </button>
      ))}
      <div className="map-label label-a">CENTRAL CIVIC DISTRICT</div>
      <div className="map-label label-b">WARD 09</div>
      <div className="map-label label-c">NEHRU PARK</div>
      {selected && (
        <div className="map-popup">
          <img src={selected.image} alt="" />
          <div><b>{selected.id}</b><span>{selected.title}</span><small>{selected.location}</small></div>
          <ChevronRight size={16} />
        </div>
      )}
      <div className="map-legend">
        <span><i className="dot red" />Open</span><span><i className="dot blue" />In progress</span>
        <span><i className="dot amber" />Pending</span><span><i className="dot green" />Resolved</span>
      </div>
    </div>
  );
}

function IssueTable({
  issues,
  onOpen,
  compact = false,
}: {
  issues: Issue[];
  onOpen: (issue: Issue) => void;
  compact?: boolean;
}) {
  return (
    <div className="table-wrap">
      <table>
        <thead><tr>
          <th>Issue</th><th>Category</th><th>Location</th><th>Reported</th>
          {!compact && <th>Priority</th>}<th>Status</th><th>Department</th><th></th>
        </tr></thead>
        <tbody>
          {issues.map((issue) => (
            <tr key={issue.id} onClick={() => onOpen(issue)}>
              <td><div className="issue-cell"><img src={issue.image} alt="" /><span><b>{issue.id}</b><small>{issue.title}</small></span></div></td>
              <td>{issue.category}</td><td><span className="location-cell"><MapPin size={14} />{issue.location}</span></td>
              <td>{issue.date}</td>
              {!compact && <td><span className={`priority priority-${issue.priority.toLowerCase()}`}>{issue.priority}</span></td>}
              <td><Badge status={issue.status} /></td><td>{issue.department}</td>
              <td><button className="table-action">View details <ChevronRight size={14} /></button></td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

function LocalDashboard({
  active,
  issues,
  setSelected,
  setActive,
}: {
  active: string;
  issues: Issue[];
  setSelected: (issue: Issue) => void;
  setActive: (value: string) => void;
}) {
  const [filter, setFilter] = useState("All Issues");
  const [mapSelected, setMapSelected] = useState<Issue>(issues[0]);
  const shownIssues = useMemo(() => {
    if (filter === "All Issues") return issues;
    return issues.filter((issue) => issue.status === filter);
  }, [filter, issues]);

  if (active === "Profile and Settings") return <Profile role="local" />;
  if (active === "Activity History") return <ActivityPage />;
  if (active === "Issue Map") {
    return (
      <>
        <PageHeading title="Issue Map" subtitle="Live geospatial view • Central Zone Municipal Authority" action={<Button icon={Plus}>Register issue</Button>} />
        <div className="filter-bar">
          <Field icon={Search} placeholder="Search issue or location" />
          {["Status", "Category", "Priority", "Date range"].map((item) => <button className="filter-select" key={item}>{item}<ChevronDown size={14} /></button>)}
          <Button variant="ghost" icon={SlidersHorizontal}>More filters</Button>
        </div>
        <div className="map-layout">
          <MiniMap issues={shownIssues} selected={mapSelected} onSelect={(issue) => { setMapSelected(issue); setSelected(issue); }} />
          <div className="map-list">
            <div className="panel-header"><div><b>Issues in view</b><small>{shownIssues.length} active records</small></div><button><MoreHorizontal size={18} /></button></div>
            {shownIssues.map((issue) => (
              <button className={`map-list-item ${mapSelected.id === issue.id ? "active" : ""}`} onClick={() => setMapSelected(issue)} key={issue.id}>
                <img src={issue.image} alt="" /><span><small>{issue.id}</small><b>{issue.title}</b><em>{issue.location}</em><Badge status={issue.status} /></span>
              </button>
            ))}
          </div>
        </div>
      </>
    );
  }

  const pageTitle = active === "Overview" ? "Local Authority Dashboard" : active;
  return (
    <>
      <PageHeading
        title={pageTitle}
        subtitle={active === "Overview" ? "Welcome back, Ananya • Central Zone Municipal Authority • Updated 10 minutes ago" : "Central Zone operational issue register"}
        action={<Button icon={Plus}>Register issue</Button>}
      />
      <div className="kpi-grid four">
        <KpiCard label="Total Reported Issues" value="1,284" note="8.4% this month" icon={ClipboardCheck} tone="navy" trend="up" />
        <KpiCard label="Open Issues" value="186" note="14 critical priority" icon={AlertTriangle} tone="red" />
        <KpiCard label="In Progress" value="94" note="32 due this week" icon={Wrench} tone="blue" />
        <KpiCard label="Awaiting Approval" value="27" note="5 submitted today" icon={Clock3} tone="amber" />
      </div>
      {active === "Overview" && (
        <div className="overview-grid">
          <section className="panel map-panel">
            <div className="panel-header"><div><b>Issues by location</b><small>Live jurisdiction overview</small></div><Button variant="ghost" icon={Map} onClick={() => setActive("Issue Map")}>Open full map</Button></div>
            <MiniMap issues={issues} selected={mapSelected} onSelect={(issue) => { setMapSelected(issue); setSelected(issue); }} />
          </section>
          <section className="panel workload-panel">
            <div className="panel-header"><div><b>Resolution workload</b><small>Current operational distribution</small></div><button><MoreHorizontal size={18} /></button></div>
            <div className="donut-wrap">
              <div className="donut"><span><b>307</b><small>Active</small></span></div>
              <div className="legend-stack">
                <span><i className="dot red" /><b>Open</b><em>186</em></span>
                <span><i className="dot blue" /><b>In progress</b><em>94</em></span>
                <span><i className="dot amber" /><b>Pending approval</b><em>27</em></span>
              </div>
            </div>
            <div className="sla-box"><Clock3 size={18} /><span><b>82% within SLA</b><small>6% improvement from last month</small></span><TrendingUp size={17} /></div>
          </section>
        </div>
      )}
      <section className="panel table-panel">
        <div className="panel-header table-head">
          <div><b>{active === "Overview" ? "Recent priority issues" : "All jurisdiction issues"}</b><small>{shownIssues.length} of 1,284 records</small></div>
          <div className="table-tools">
            <div className="mini-search"><Search size={15} /><input placeholder="Search issues…" /></div>
            <Button variant="secondary" icon={Filter}>Filters</Button>
          </div>
        </div>
        <div className="tabs">
          {["All Issues", "Open", "In Progress", "Pending Approval", "Resolved"].map((tab) => <button className={filter === tab ? "active" : ""} key={tab} onClick={() => setFilter(tab)}>{tab}</button>)}
        </div>
        <IssueTable issues={shownIssues} onOpen={setSelected} />
        <div className="pagination"><span>Showing 1–{shownIssues.length} of 1,284</span><div><button><ChevronLeft size={15} /></button><button className="active">1</button><button>2</button><button>3</button><button><ChevronRight size={15} /></button></div></div>
      </section>
    </>
  );
}

function Sparkline({ color = "blue", bars = false }: { color?: string; bars?: boolean }) {
  if (bars) return <div className="bars">{[42, 67, 52, 83, 63, 91, 74].map((h, i) => <i key={i} style={{ height: `${h}%` }} />)}</div>;
  return (
    <svg className={`sparkline ${color}`} viewBox="0 0 500 140" preserveAspectRatio="none">
      <path className="area" d="M0,110 C60,85 75,102 125,72 S210,96 250,60 S330,75 370,38 S445,48 500,20 L500,140 L0,140Z" />
      <path className="line" d="M0,110 C60,85 75,102 125,72 S210,96 250,60 S330,75 370,38 S445,48 500,20" />
    </svg>
  );
}

function HighDashboard({
  active,
  onReview,
}: {
  active: string;
  onReview: () => void;
}) {
  if (active === "Profile and Settings") return <Profile role="high" />;
  if (active === "Audit Logs" || active === "Review History") return <ActivityPage />;
  if (active === "Resolution Approvals") return <ApprovalQueue onReview={onReview} />;
  return (
    <>
      <PageHeading
        title={active === "Executive Overview" ? "Executive Overview" : active}
        subtitle="National Capital Region • Performance as of 14 June 2025, 09:40"
        action={<div className="heading-actions"><Button variant="secondary" icon={CalendarDays}>Last 30 days <ChevronDown size={14} /></Button><Button icon={FileText}>Export report</Button></div>}
      />
      <div className="filter-strip">
        {["All regions", "All departments", "All categories", "All statuses"].map((item) => <button key={item}>{item}<ChevronDown size={14} /></button>)}
        <span>Filters apply to all metrics</span>
      </div>
      <div className="kpi-grid six">
        <KpiCard label="Total Issues" value="24,892" note="12.6% vs last period" icon={ClipboardCheck} tone="navy" trend="up" />
        <KpiCard label="Issues Resolved" value="21,406" note="14.2% vs last period" icon={CheckCircle2} tone="green" trend="up" />
        <KpiCard label="Resolution Rate" value="86.0%" note="Target 85%" icon={Gauge} tone="blue" trend="up" />
        <KpiCard label="Pending Approval" value="128" note="12 require attention" icon={Clock3} tone="amber" />
        <KpiCard label="Avg. Resolution" value="4.2d" note="0.6d faster" icon={Activity} tone="purple" trend="down" />
        <KpiCard label="Overdue Issues" value="342" note="18 added this week" icon={AlertTriangle} tone="red" />
      </div>
      <div className="analytics-grid">
        <section className="panel chart-wide">
          <div className="panel-header"><div><b>Issues reported vs. resolved</b><small>Monthly issue throughput</small></div><div className="chart-key"><span><i className="dot blue" />Reported</span><span><i className="dot green" />Resolved</span></div></div>
          <div className="chart-y"><span>3k</span><span>2k</span><span>1k</span><span>0</span></div>
          <div className="double-chart"><Sparkline /><Sparkline color="green" /></div>
          <div className="chart-x"><span>Jan</span><span>Feb</span><span>Mar</span><span>Apr</span><span>May</span><span>Jun</span></div>
        </section>
        <section className="panel">
          <div className="panel-header"><div><b>Issues by category</b><small>Distribution this period</small></div><button><MoreHorizontal size={18} /></button></div>
          <div className="donut-wrap executive">
            <div className="donut category"><span><b>24.9k</b><small>Total issues</small></span></div>
            <div className="legend-stack">
              <span><i className="dot blue" /><b>Road damage</b><em>32%</em></span>
              <span><i className="dot purple" /><b>Sanitation</b><em>24%</em></span>
              <span><i className="dot amber" /><b>Water</b><em>18%</em></span>
              <span><i className="dot green" /><b>Streetlights</b><em>14%</em></span>
              <span><i className="dot gray" /><b>Other</b><em>12%</em></span>
            </div>
          </div>
        </section>
        <section className="panel">
          <div className="panel-header"><div><b>Department performance</b><small>Resolution rate by department</small></div><button><MoreHorizontal size={18} /></button></div>
          <div className="performance-list">
            {[["Public Works", 91], ["Water Services", 87], ["Sanitation", 84], ["Electrical", 79]].map(([name, score], i) => (
              <div key={name as string}><span><i>{i + 1}</i><b>{name}</b></span><div><em style={{ width: `${score}%` }} /></div><strong>{score}%</strong></div>
            ))}
          </div>
        </section>
        <section className="panel">
          <div className="panel-header"><div><b>Monthly resolution rate</b><small>Target benchmark: 85%</small></div><span className="positive">+4.8%</span></div>
          <Sparkline color="green" />
          <div className="chart-x"><span>Jan</span><span>Feb</span><span>Mar</span><span>Apr</span><span>May</span><span>Jun</span></div>
        </section>
      </div>
      <section className="panel ranking">
        <div className="panel-header"><div><b>Regional performance overview</b><small>Ranked by resolution rate and average completion time</small></div><Button variant="ghost">View full report <ChevronRight size={15} /></Button></div>
        <div className="region-grid">
          {[["1", "Central Zone", "94.2%", "2.8 days", "8"], ["2", "North District", "90.8%", "3.4 days", "14"], ["3", "East District", "87.1%", "4.1 days", "21"], ["4", "South District", "82.6%", "5.2 days", "36"]].map((r) => (
            <div className="region-row" key={r[0]}><i>{r[0]}</i><span><b>{r[1]}</b><small>Municipal jurisdiction</small></span><span><small>Resolution rate</small><b>{r[2]}</b></span><span><small>Avg. resolution</small><b>{r[3]}</b></span><span><small>Pending approvals</small><b>{r[4]}</b></span><ChevronRight size={16} /></div>
          ))}
        </div>
      </section>
    </>
  );
}

function ApprovalQueue({ onReview }: { onReview: () => void }) {
  return (
    <>
      <PageHeading title="Resolution Approvals" subtitle="Review evidence and authorize final issue resolution" action={<Button variant="secondary" icon={FileText}>Export queue</Button>} />
      <div className="approval-summary">
        <div><span className="summary-icon amber"><Clock3 size={20} /></span><span><b>128</b><small>Pending review</small></span></div>
        <div><span className="summary-icon red"><AlertTriangle size={20} /></span><span><b>12</b><small>Overdue reviews</small></span></div>
        <div><span className="summary-icon green"><CheckCircle2 size={20} /></span><span><b>842</b><small>Approved this month</small></span></div>
        <div><span className="summary-icon blue"><Activity size={20} /></span><span><b>8.4h</b><small>Avg. review time</small></span></div>
      </div>
      <section className="panel table-panel">
        <div className="panel-header table-head"><div><b>Approval submissions</b><small>Evidence-based resolution queue</small></div><div className="table-tools"><div className="mini-search"><Search size={15} /><input placeholder="Search submissions…" /></div><Button variant="secondary" icon={Filter}>Filters</Button></div></div>
        <div className="tabs"><button className="active">Pending Review <i>128</i></button><button>Approved</button><button>Revision Required</button></div>
        <div className="table-wrap">
          <table><thead><tr><th>Submission</th><th>Issue</th><th>Local Authority</th><th>Department</th><th>Submitted</th><th>Documents</th><th>Status</th><th></th></tr></thead>
            <tbody>
              {[
                ["SUB-2025-0412", "CT-2025-0819", "Streetlights restored across two blocks", "Central Zone", "Electrical", "14 Jun, 08:32", "5 files"],
                ["SUB-2025-0409", "CT-2025-0794", "Damaged pedestrian bridge repaired", "North District", "Public Works", "13 Jun, 16:18", "8 files"],
                ["SUB-2025-0407", "CT-2025-0776", "Waste accumulation cleared", "East District", "Sanitation", "13 Jun, 14:02", "4 files"],
                ["SUB-2025-0401", "CT-2025-0751", "Water main leakage contained", "South District", "Water Services", "12 Jun, 11:47", "6 files"],
              ].map((row) => <tr key={row[0]}><td><b>{row[0]}</b></td><td><span className="submission-issue"><b>{row[1]}</b><small>{row[2]}</small></span></td><td>{row[3]}</td><td>{row[4]}</td><td>{row[5]}</td><td><span className="doc-count"><Paperclip size={14} />{row[6]}</span></td><td><Badge status="Pending Approval" /></td><td><Button variant="secondary" onClick={onReview}>Review</Button></td></tr>)}
            </tbody>
          </table>
        </div>
        <div className="pagination"><span>Showing 1–4 of 128 submissions</span><div><button><ChevronLeft size={15} /></button><button className="active">1</button><button>2</button><button>3</button><button><ChevronRight size={15} /></button></div></div>
      </section>
    </>
  );
}

function Workflow({ current }: { current: number }) {
  return (
    <div className="workflow">
      {["Issue received", "Work in progress", "Evidence submitted", "Authority review", "Final resolution"].map((label, i) => (
        <div className={i < current ? "done" : i === current ? "current" : ""} key={label}>
          <span>{i < current ? <Check size={14} /> : i + 1}</span><b>{label}</b>{i < 4 && <i />}
        </div>
      ))}
    </div>
  );
}

function IssueDrawer({
  issue,
  onClose,
  onSubmit,
}: {
  issue: Issue;
  onClose: () => void;
  onSubmit: (issue: Issue) => void;
}) {
  return (
    <div className="overlay" onMouseDown={onClose}>
      <div className="drawer" onMouseDown={(e) => e.stopPropagation()}>
        <div className="drawer-head">
          <div><span>{issue.id}</span><div className="title-md">{issue.title}</div></div>
          <button className="icon-square" onClick={onClose}><X size={18} /></button>
        </div>
        <Workflow current={issue.status === "Pending Approval" ? 3 : issue.status === "Resolved" ? 5 : 1} />
        <div className="drawer-body">
          <div className="detail-main">
            <img className="hero-image" src={issue.image} alt="Reported civic issue" />
            <div className="detail-meta">
              <div><small>Status</small><Badge status={issue.status} /></div>
              <div><small>Priority</small><span className={`priority priority-${issue.priority.toLowerCase()}`}>{issue.priority}</span></div>
              <div><small>Category</small><b>{issue.category}</b></div>
              <div><small>Reported</small><b>{issue.date}, 08:45</b></div>
            </div>
            <div className="detail-section"><div className="title-sm">Citizen report</div><p>Significant damage has developed at this location and is creating a safety risk for vehicles and pedestrians. The problem has worsened following recent rainfall and requires urgent inspection.</p></div>
            <div className="detail-section"><div className="title-sm">Recorded location</div><div className="coordinate-card"><MapPin size={18} /><span><b>{issue.location}</b><small>{issue.coordinates} • Coordinates recorded with original post</small></span><Button variant="ghost">Open map</Button></div></div>
            <div className="detail-section"><div className="section-title-row"><div className="title-sm">Activity timeline</div><Button variant="ghost" icon={MessageSquareText}>Add internal note</Button></div>
              <div className="timeline">
                <div><i className="green"><Check size={12} /></i><span><b>Issue verified by field officer</b><small>R. Sharma • 14 Jun 2025, 10:22</small></span></div>
                <div><i className="blue"><Wrench size={12} /></i><span><b>Assigned to {issue.department}</b><small>Ananya Kapoor • 14 Jun 2025, 09:15</small></span></div>
                <div><i><CircleDot size={12} /></i><span><b>Citizen report received</b><small>System • 14 Jun 2025, 08:45</small></span></div>
              </div>
            </div>
          </div>
          <aside className="detail-side">
            <div className="detail-section"><div className="title-sm">Assignment</div><div className="officer"><div className="avatar">RS</div><span><b>Rajiv Sharma</b><small>Senior Field Engineer</small></span></div><div className="key-value"><span>Department<b>{issue.department}</b></span><span>SLA deadline<b>16 Jun 2025</b></span></div><Button variant="secondary" className="full">Reassign department</Button></div>
            <div className="detail-section"><div className="title-sm">Reporter details</div><div className="key-value"><span>Name<b>Priya Mehta</b></span><span>Supporting reports<b>24 citizens</b></span><span>Contact<b>Verified • Protected</b></span></div></div>
            <div className="detail-section"><div className="title-sm">Documents</div><div className="document-row"><FileText size={18} /><span><b>Field inspection.pdf</b><small>1.8 MB • PDF</small></span><Eye size={16} /></div></div>
          </aside>
        </div>
        <div className="drawer-actions"><Button variant="secondary" icon={MessageSquareText}>Add note</Button><Button icon={FileCheck2} onClick={() => onSubmit(issue)}>Submit resolution evidence</Button></div>
      </div>
    </div>
  );
}

function SubmissionModal({ issue, onClose, onComplete }: { issue: Issue; onClose: () => void; onComplete: () => void }) {
  const [done, setDone] = useState(false);
  return (
    <div className="overlay modal-overlay">
      <div className="modal resolution-modal">
        <div className="modal-head"><div><div className="eyebrow">RESOLUTION WORKFLOW • STEP 3 OF 5</div><div className="title-md">{done ? "Submission received" : "Submit resolution evidence"}</div><p>{issue.id} • {issue.title}</p></div><button className="icon-square" onClick={onClose}><X size={18} /></button></div>
        {done ? (
          <div className="success-state"><div className="success-icon"><CheckCircle2 size={34} /></div><div className="title-lg">Sent for authority approval</div><p>This issue is now <b>Pending Higher Authority Approval</b>. It cannot be marked as resolved until the submitted evidence is approved.</p><Workflow current={3} /><div className="receipt"><span>Submission ID<b>SUB-2025-0412</b></span><span>Submitted by<b>Ananya Kapoor</b></span><span>Timestamp<b>14 Jun 2025, 10:46</b></span></div><Button onClick={() => { onComplete(); onClose(); }}>Return to issue register</Button></div>
        ) : (
          <>
            <div className="modal-body">
              <div className="required-notice"><ShieldCheck size={19} /><span><b>Higher authority approval is mandatory</b><small>This submission creates a permanent, auditable record. The issue will not be resolved until approved.</small></span></div>
              <label className="field"><span className="field-label">Corrective action performed <em>Required</em></span><textarea placeholder="Describe the work completed, methods used, and outcome…" /></label>
              <div className="two-fields"><Field label="Resolution date" type="date" value="2025-06-14" /><Field label="Responsible officer" value="Rajiv Sharma — Field Engineer" /></div>
              <div className="field"><span className="field-label">Before and after photographs <em>Required</em></span><div className="upload-grid"><div className="upload-box"><UploadCloud size={22} /><b>Upload before photo</b><small>JPG or PNG, max. 10 MB</small></div><div className="upload-box uploaded"><img src={worksImage} alt="" /><span><CheckCircle2 size={18} />After-work photo uploaded</span></div></div></div>
              <div className="field"><span className="field-label">Supporting evidence documents <em>Required</em></span><div className="document-row"><FileCheck2 size={19} /><span><b>Completion_Report_CT0819.pdf</b><small>2.4 MB • Uploaded just now</small></span><button><X size={15} /></button></div><Button variant="ghost" icon={Paperclip}>Add another document</Button></div>
              <label className="field"><span className="field-label">Additional remarks</span><textarea className="short" placeholder="Add context for the reviewing authority…" /></label>
            </div>
            <div className="modal-actions"><Button variant="secondary" onClick={onClose}>Save draft</Button><Button icon={ShieldCheck} onClick={() => setDone(true)}>Submit for approval</Button></div>
          </>
        )}
      </div>
    </div>
  );
}

function ReviewModal({ onClose }: { onClose: () => void }) {
  const [decision, setDecision] = useState<"approve" | "revision" | "success" | null>(null);
  if (decision === "success") {
    return <div className="overlay modal-overlay"><div className="modal confirm-modal"><div className="success-state"><div className="success-icon"><CheckCircle2 size={34} /></div><div className="title-lg">Resolution approved</div><p>CT-2025-0819 is now marked <b>Resolved</b>. The decision, reviewer identity, and timestamp have been added to the permanent audit history.</p><Button onClick={onClose}>Return to approval queue</Button></div></div></div>;
  }
  return (
    <div className="overlay modal-overlay">
      <div className="modal review-modal">
        <div className="modal-head"><div><div className="eyebrow">RESOLUTION REVIEW • SUB-2025-0412</div><div className="title-md">Streetlights restored across two blocks</div><p>CT-2025-0819 • Submitted by Central Zone Authority</p></div><button className="icon-square" onClick={onClose}><X size={18} /></button></div>
        <div className="review-content">
          <div className="evidence-column">
            <Workflow current={3} />
            <div className="comparison"><div><span>BEFORE</span><img src={roadImage} alt="Issue before repairs" /></div><div><span>AFTER</span><img src={worksImage} alt="Completed repairs" /></div></div>
            <div className="detail-section"><div className="title-sm">Corrective action report</div><p>Electrical maintenance teams replaced six damaged luminaires, repaired underground cabling at two junction points, and completed illumination testing across both affected blocks. All assets are operational.</p></div>
            <div className="detail-section"><div className="title-sm">Supporting documents</div><div className="document-row"><FileCheck2 size={18} /><span><b>Completion_Report_CT0819.pdf</b><small>Signed completion report • 2.4 MB</small></span><Button variant="ghost" icon={Eye}>Preview</Button></div><div className="document-row"><FileText size={18} /><span><b>Electrical_Test_Certificate.pdf</b><small>Certified inspection • 1.2 MB</small></span><Button variant="ghost" icon={Eye}>Preview</Button></div></div>
          </div>
          <aside className="review-side">
            <div className="title-sm">Evidence checklist</div>
            {["Corrective action described", "Completion date recorded", "Before photograph provided", "After photograph provided", "Signed completion report", "Technical certificate valid"].map((item) => <label className="check-row" key={item}><input type="checkbox" defaultChecked /><span><b>{item}</b><small>Verified in submission</small></span></label>)}
            <div className="review-meta"><span>Submitting officer<b>Ananya Kapoor</b></span><span>Submission date<b>14 Jun, 08:32</b></span><span>Previous revisions<b>None</b></span></div>
          </aside>
        </div>
        {decision ? (
          <div className={`decision-panel ${decision}`}>
            <div><div className="title-sm">{decision === "approve" ? "Confirm approval" : "Request revision"}</div><p>{decision === "approve" ? "This action will mark the issue as Resolved and cannot be undone." : "A reason is required and will be sent to the local authority."}</p></div>
            <textarea placeholder={decision === "approve" ? "Optional review comment…" : "Describe the required corrections…"} />
            <div><Button variant="secondary" onClick={() => setDecision(null)}>Cancel</Button><Button variant={decision === "revision" ? "danger" : "primary"} onClick={() => decision === "approve" ? setDecision("success") : onClose()}>{decision === "approve" ? "Approve and resolve" : "Send revision request"}</Button></div>
          </div>
        ) : (
          <div className="modal-actions spread"><span><ShieldCheck size={16} /> Permission verified • All required evidence present</span><div><Button variant="danger" icon={AlertTriangle} onClick={() => setDecision("revision")}>Request revision</Button><Button icon={CheckCircle2} onClick={() => setDecision("approve")}>Approve resolution</Button></div></div>
        )}
      </div>
    </div>
  );
}

function ActivityPage() {
  return (
    <>
      <PageHeading title="Notifications & Activity" subtitle="A complete record of alerts and administrative actions" action={<Button variant="secondary">Mark all as read</Button>} />
      <div className="activity-layout">
        <section className="panel notification-list"><div className="panel-header"><div><b>Notification center</b><small>4 unread updates</small></div><Filter size={17} /></div>
          {[
            ["revision", "Revision requested", "Submission SUB-2025-0398 requires updated completion photographs.", "8 min ago"],
            ["approval", "Resolution approved", "Issue CT-2025-0791 was approved and marked resolved.", "32 min ago"],
            ["assignment", "New issue assigned", "Critical road damage in Ward 12 has been assigned to your team.", "1 hr ago"],
            ["overdue", "SLA deadline approaching", "Three high-priority issues are due within the next 24 hours.", "3 hrs ago"],
          ].map((n) => <button className="notification-item" key={n[1]}><span className={`notification-icon ${n[0]}`}><Bell size={17} /></span><span><b>{n[1]}</b><small>{n[2]}</small><em>{n[3]}</em></span><i /></button>)}
        </section>
        <section className="panel"><div className="panel-header"><div><b>Administrative activity</b><small>Today, 14 June 2025</small></div><MoreHorizontal size={18} /></div><div className="large-timeline timeline">
          {["Resolution evidence submitted for CT-2025-0819", "Field officer assigned to CT-2025-0842", "Status changed to In Progress", "Internal note added by Rajiv Sharma", "Issue CT-2025-0808 marked Resolved"].map((item, i) => <div key={item}><i className={i === 0 ? "blue" : i === 4 ? "green" : ""}>{i === 4 ? <Check size={12} /> : <CircleDot size={12} />}</i><span><b>{item}</b><small>{i % 2 ? "Ananya Kapoor" : "System"} • {10 - i}:2{i}</small></span></div>)}
        </div></section>
      </div>
    </>
  );
}

function Profile({ role }: { role: Role }) {
  return (
    <>
      <PageHeading title="Profile & Settings" subtitle="Manage your official account and notification preferences" />
      <div className="profile-grid">
        <section className="panel profile-card"><div className="profile-avatar">{role === "local" ? "AK" : "MR"}</div><div className="title-md">{role === "local" ? "Ananya Kapoor" : "Meera Rao"}</div><p>{role === "local" ? "Municipal Operations Officer" : "Regional Commissioner"}</p><Badge status="Resolved" /><div className="profile-divider" /><div className="key-value"><span>Official user ID<b>{role === "local" ? "LA-CZ-1042" : "HA-NCR-0021"}</b></span><span>Jurisdiction<b>{role === "local" ? "Central Zone" : "National Capital Region"}</b></span><span>Role verified<b>{role === "local" ? "Local Authority" : "High Authority"}</b></span></div></section>
        <section className="panel settings-card"><div className="title-md">Account information</div><div className="two-fields"><Field label="Full name" value={role === "local" ? "Ananya Kapoor" : "Meera Rao"} /><Field label="Official email" value={role === "local" ? "ananya.kapoor@civic.gov" : "meera.rao@civic.gov"} /></div><div className="two-fields"><Field label="Department" value={role === "local" ? "Municipal Operations" : "Office of Commissioner"} /><Field label="Phone" value="+91 11 4002 1842" /></div><div className="profile-divider" /><div className="title-sm">Notification preferences</div>{["Issue assignments and status changes", "Resolution submission decisions", "SLA and overdue alerts"].map((item) => <label className="toggle-row" key={item}><span><b>{item}</b><small>Receive in-app and email notifications</small></span><input type="checkbox" defaultChecked /></label>)}<div className="settings-actions"><Button variant="secondary">Cancel</Button><Button>Save changes</Button></div></section>
      </div>
    </>
  );
}

export default function App() {
  const [role, setRole] = useState<Role | null>(null);
  const [active, setActive] = useState("Overview");
  const [collapsed, setCollapsed] = useState(false);
  const [issues, setIssues] = useState<Issue[]>(initialIssues);
  const [selected, setSelected] = useState<Issue | null>(null);
  const [submission, setSubmission] = useState<Issue | null>(null);
  const [review, setReview] = useState(false);

  // We statically imported useEffect at the top of the file
  useEffect(() => {
    const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://localhost:5000/api/v1';
    
    fetch(`${API_BASE}/reports`, {
      headers: { 'Authorization': 'Bearer citizen-123' } // Demo officer token
    })
    .then(res => res.json())
    .then((data: any[]) => {
      if (Array.isArray(data) && data.length > 0) {
        const apiIssues = data.map(d => ({
          id: d.id,
          title: d.description || d.category || "Reported Issue",
          category: d.category || "General",
          location: d.address || "Unknown Location",
          coordinates: `${d.latitude?.toFixed(4) || 0}° N, ${d.longitude?.toFixed(4) || 0}° E`,
          date: new Date(d.created_at).toLocaleDateString(),
          priority: d.priority || "Medium",
          status: d.status || "Open",
          department: "Municipal Operations",
          image: d.photo_url ? `${API_BASE.replace('/api/v1', '')}${d.photo_url}` : roadImage,
          marker: [Math.random() * 80 + 10, Math.random() * 80 + 10] as [number, number]
        }));
        setIssues([...apiIssues, ...initialIssues]);
      }
    })
    .catch(err => console.error("Failed to load real issues", err));
  }, []);

  const login = (nextRole: Role) => {
    setRole(nextRole);
    setActive(nextRole === "local" ? "Overview" : "Executive Overview");
  };
  if (!role) return <Login onLogin={login} />;
  return (
    <div className="app-shell">
      <Sidebar role={role} active={active} setActive={setActive} collapsed={collapsed} setCollapsed={setCollapsed} logout={() => setRole(null)} />
      <div className={`main-shell ${collapsed ? "wide" : ""}`}>
        <Topbar role={role} onNotifications={() => setActive(role === "local" ? "Activity History" : "Audit Logs")} />
        <main className="content">
          {role === "local" ? (
            <LocalDashboard active={active} issues={issues} setSelected={setSelected} setActive={setActive} />
          ) : (
            <HighDashboard active={active} onReview={() => setReview(true)} />
          )}
        </main>
      </div>
      {selected && <IssueDrawer issue={selected} onClose={() => setSelected(null)} onSubmit={(issue) => { setSelected(null); setSubmission(issue); }} />}
      {submission && <SubmissionModal issue={submission} onClose={() => setSubmission(null)} onComplete={() => setIssues((items) => items.map((item) => item.id === submission.id ? { ...item, status: "Pending Approval" } : item))} />}
      {review && <ReviewModal onClose={() => setReview(false)} />}
    </div>
  );
}
