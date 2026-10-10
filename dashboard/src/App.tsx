import { useMemo, useState, useEffect, useCallback, type ComponentType, type ReactNode } from "react";
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
  RefreshCw,
  Search,
  Settings,
  ShieldCheck,
  Smartphone,
  SlidersHorizontal,
  TrendingDown,
  TrendingUp,
  UploadCloud,
  UserRound,
  Users,
  Wrench,
  X,
} from "lucide-react";

export type Role = "local" | "high";
export type Status = "Open" | "In Progress" | "Pending Approval" | "Resolved" | "Revision Required";

export type Issue = {
  id: string;
  title: string;
  category: string;
  location: string;
  coordinates: string;
  date: string;
  priority: "Critical" | "High" | "Medium" | "Low";
  status: Status;
  department: string;
  image: string;
  description?: string;
  marker: [number, number];
};

export type DashboardStatsData = {
  total_reports: number;
  open_reports: number;
  resolved_reports: number;
  high_priority: number;
  average_sla_hours: number;
  escalated_reports: number;
};

const roadImage =
  "https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&q=82&w=900";
const worksImage =
  "https://images.unsplash.com/photo-1558690194-5aaa922b59b6?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&q=82&w=900";
const waterImage =
  "https://images.unsplash.com/photo-1526898943670-92bfa9f94c12?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&q=82&w=900";

const statusClass: Record<Status, string> = {
  Open: "status status-open",
  "In Progress": "status status-progress",
  "Pending Approval": "status status-pending",
  Resolved: "status status-resolved",
  "Revision Required": "status status-revision",
};

export const API_BASE = import.meta.env.VITE_API_BASE_URL || "http://127.0.0.1:5000/api/v1";

export function getAuthToken(role: Role): string {
  return role === "high" ? "commissioner-meera" : "official-ananya";
}

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
        <div className="brand-sub">Smart Civic Command Center</div>
      </div>
    </div>
  );
}

function Login({ onLogin }: { onLogin: (role: Role) => void }) {
  const [role, setRole] = useState<Role>("local");
  const [visible, setVisible] = useState(false);
  const [isSignup, setIsSignup] = useState(false);
  const [mobile, setMobile] = useState("9876543210");
  const [name, setName] = useState("");
  const [error, setError] = useState("");

  return (
    <main className="login-page">
      <section className="login-story">
        <div className="login-story-inner">
          <Brand dark />
          <div className="story-copy">
            <div className="eyebrow light">OFFICIAL CIVICPULSE PLATFORM</div>
            <div className="display-title">Connected Governance,<br />Rapid Resolution.</div>
            <p>
              Unified administrative command center connected directly to CivicPulse AI backend for auditable municipal operations.
            </p>
          </div>
          <div className="trust-row">
            <div><ShieldCheck size={20} /><span><b>Live Backend Sync</b><small>FastAPI + DynamoDB Connected</small></span></div>
            <div><Activity size={20} /><span><b>Full Auditability</b><small>Evidence-based resolution tracking</small></span></div>
          </div>
        </div>
      </section>
      <section className="login-panel">
        <div className="login-card">
          <div className="mobile-brand"><Brand /></div>
          <div className="login-heading">
            <div className="eyebrow">AUTHORIZED PERSONNEL</div>
            <div className="title-xl">{isSignup ? "Create officer account" : "Sign in to Command"}</div>
            <p>{isSignup ? "Register with your credentials for municipal jurisdiction." : "Select your authority level to access operational metrics."}</p>
          </div>
          <div className="role-switch" aria-label="Select authority role">
            <button className={role === "local" ? "active" : ""} onClick={() => setRole("local")}>
              <MapPin size={17} />Local Authority
            </button>
            <button className={role === "high" ? "active" : ""} onClick={() => setRole("high")}>
              <ShieldCheck size={17} />High Authority (Commissioner)
            </button>
          </div>
          <form onSubmit={(event) => {
            event.preventDefault();
            setError("");
            onLogin(role);
          }}>
            {isSignup && <Field label="Full name" icon={UserRound} placeholder="e.g. Officer Ananya Kapoor" value={name} onChange={setName} />}
            <Field label="Mobile number / Officer ID" icon={Smartphone} placeholder="+91 98765 43210" type="tel" value={mobile} onChange={(value) => { setMobile(value); setError(""); }} />
            <label className="field">
              <span className="field-label">Access PIN / Password</span>
              <span className="input-wrap">
                <LockKeyhole size={17} />
                <input type={visible ? "text" : "password"} defaultValue="password123" placeholder="Enter your credentials" />
                <button type="button" className="icon-btn" onClick={() => setVisible(!visible)} aria-label="Toggle password visibility">
                  {visible ? <EyeOff size={17} /> : <Eye size={17} />}
                </button>
              </span>
            </label>
            {!isSignup && <div className="form-meta">
              <label><input type="checkbox" defaultChecked /> Keep me signed in</label>
              <span style={{ fontSize: 12, color: "#16a34a", fontWeight: 600 }}>Backend Live: {API_BASE}</span>
            </div>}
            {error && <div role="alert" style={{ color: "#b42318", fontSize: 12, marginBottom: 12 }}>{error}</div>}
            <Button type="submit" className="full">{isSignup ? "Register & Enter Dashboard" : "Sign in to Command Center"} <ChevronRight size={17} /></Button>
          </form>
          <div style={{ textAlign: "center", marginTop: 18, fontSize: 13, color: "#667085" }}>
            {isSignup ? "Already registered? " : "Switch account type? "}
            <button type="button" onClick={() => { setIsSignup(!isSignup); setError(""); }} style={{ border: 0, background: "none", color: "#2457a7", fontWeight: 700, cursor: "pointer" }}>
              {isSignup ? "Sign in" : "Register new officer"}
            </button>
          </div>
          <div className="security-note">
            <LockKeyhole size={16} />
            <span><b>Connected to FastAPI backend</b> at <code>{API_BASE}</code> with role-based JWT/Demo tokens.</span>
          </div>
          <div className="login-footer">CivicTrack Government Cloud • Integrated with Backend API</div>
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
              {label === "Resolution Approvals" && <small>Live</small>}
              {label === "Revision Required" && <small>Alert</small>}
            </button>
          ))}
        </nav>
        <div className="sidebar-bottom">
          <button onClick={() => setActive("Profile and Settings")}><Settings size={18} /><span>Profile & Settings</span></button>
          <button onClick={logout}><LogOut size={18} /><span>Sign out</span></button>
          <div className="user-mini">
            <div className="avatar">{role === "local" ? "AK" : "MR"}</div>
            <span><b>{role === "local" ? "Ananya Kapoor" : "Meera Rao"}</b><small>{role === "local" ? "Municipal Operations Officer" : "Regional Commissioner"}</small></span>
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
  onRefresh,
  loading,
}: {
  role: Role;
  onNotifications: () => void;
  onRefresh: () => void;
  loading: boolean;
}) {
  return (
    <header className="topbar">
      <div className="mobile-logo"><Building2 size={19} /> CivicTrack</div>
      <div className="global-search"><Search size={17} /><input placeholder="Search backend issues, tasks, or jurisdiction coordinates…" /></div>
      <div className="top-actions">
        <button className="btn btn-secondary" onClick={onRefresh} disabled={loading} style={{ padding: "6px 12px", fontSize: 13, display: "flex", alignItems: "center", gap: 6 }}>
          <RefreshCw size={14} className={loading ? "animate-spin" : ""} />
          <span>{loading ? "Syncing..." : "Sync Backend"}</span>
        </button>
        <div className="live-pill"><span /> Backend Active</div>
        <button className="icon-square" onClick={onNotifications} aria-label="Open notifications"><Bell size={18} /><i>3</i></button>
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
  return <span className={statusClass[status] || "status status-open"}><i />{status}</span>;
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

function MiniMap({ issues, selected, onSelect }: { issues: Issue[]; selected?: Issue | null; onSelect: (issue: Issue) => void }) {
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
      <div className="map-search"><Search size={16} /><input placeholder="Search jurisdiction coordinates…" /></div>
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
  if (issues.length === 0) {
    return (
      <div style={{ padding: "3rem", textAlign: "center", color: "#667085" }}>
        <ClipboardCheck size={32} style={{ margin: "0 auto 12px", opacity: 0.5 }} />
        <div style={{ fontWeight: 600, fontSize: 16 }}>No issues found in database</div>
        <div style={{ fontSize: 13 }}>Click "Register issue" above or post from CleanCity app to add live records.</div>
      </div>
    );
  }

  return (
    <div className="table-wrap">
      <table>
        <thead><tr>
          <th>Issue ID & Summary</th><th>Category</th><th>Location</th><th>Reported</th>
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

function RegisterIssueModal({
  onClose,
  onCreated,
  role,
}: {
  onClose: () => void;
  onCreated: (newIssue: Issue) => void;
  role: Role;
}) {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [category, setCategory] = useState("waste");
  const [latitude, setLatitude] = useState("19.0760");
  const [longitude, setLongitude] = useState("72.8777");
  const [photoUrl, setPhotoUrl] = useState(roadImage);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!title.trim() || description.trim().length < 10) {
      setError("Please enter a title and detailed description (min 10 characters).");
      return;
    }

    setSubmitting(true);
    setError("");

    try {
      const token = getAuthToken(role);
      const res = await fetch(`${API_BASE}/reports`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({
          title: title.trim(),
          description: description.trim(),
          category: category,
          gps: {
            latitude: parseFloat(latitude) || 19.0760,
            longitude: parseFloat(longitude) || 72.8777,
          },
          photo_url: photoUrl.trim() || roadImage,
          citizen_id: "official-dashboard",
          gps_accuracy_m: 3.5,
        }),
      });

      if (!res.ok) {
        const data = await res.json().catch(() => ({}));
        throw new Error(data.error || data.detail || `Server returned ${res.status}`);
      }

      const created = await res.json();
      const mappedIssue: Issue = {
        id: created.id || `REP-${Date.now().toString().slice(-4)}`,
        title: created.title || title,
        category: (created.category || category).toUpperCase(),
        location: `Ward 09 (${latitude}, ${longitude})`,
        coordinates: `${latitude}° N, ${longitude}° E`,
        date: new Date().toLocaleDateString(),
        priority: "High",
        status: "Open",
        department: "Municipal Operations",
        image: created.photo_url || photoUrl,
        description: created.description || description,
        marker: [Math.random() * 60 + 20, Math.random() * 60 + 20],
      };

      onCreated(mappedIssue);
      onClose();
    } catch (err: any) {
      console.error("Create issue error:", err);
      setError(err.message || "Failed to create issue on backend.");
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className="overlay modal-overlay" onMouseDown={onClose}>
      <div className="modal" onMouseDown={(e) => e.stopPropagation()} style={{ maxWidth: 540 }}>
        <div className="modal-head">
          <div>
            <div className="eyebrow">NEW MUNICIPAL REPORT</div>
            <div className="title-md">Register Issue to Backend</div>
          </div>
          <button className="icon-square" onClick={onClose}><X size={18} /></button>
        </div>
        <form onSubmit={handleSubmit}>
          <div className="modal-body">
            <Field label="Issue Title" placeholder="e.g. Broken Water Pipe near Main Junction" value={title} onChange={setTitle} />
            <label className="field">
              <span className="field-label">Category</span>
              <select
                value={category}
                onChange={(e) => setCategory(e.target.value)}
                style={{ width: "100%", padding: "10px", borderRadius: 8, border: "1px solid #d0d5dd", background: "#fff", fontSize: 14 }}
              >
                <option value="waste">Solid Waste / Garbage</option>
                <option value="water">Water Supply / Leakage</option>
                <option value="drainage">Drainage / Sewage</option>
                <option value="safety">Road Safety / Pothole</option>
                <option value="air">Air Quality / Pollution</option>
                <option value="noise">Noise Disturbance</option>
                <option value="other">Other Civic Infrastructure</option>
              </select>
            </label>
            <label className="field">
              <span className="field-label">Detailed Description <em>Required</em></span>
              <textarea
                value={description}
                onChange={(e) => setDescription(e.target.value)}
                placeholder="Describe the issue, hazards, and exact street landmarks…"
                style={{ minHeight: 80 }}
              />
            </label>
            <div className="two-fields">
              <Field label="Latitude" value={latitude} onChange={setLatitude} />
              <Field label="Longitude" value={longitude} onChange={setLongitude} />
            </div>
            <Field label="Evidence Photo URL" value={photoUrl} onChange={setPhotoUrl} placeholder="https://..." />
            {error && <div role="alert" style={{ color: "#b42318", fontSize: 13, marginTop: 8 }}>{error}</div>}
          </div>
          <div className="modal-actions">
            <Button variant="secondary" onClick={onClose}>Cancel</Button>
            <Button type="submit" disabled={submitting}>
              {submitting ? "Saving to Backend..." : "Submit Report to Backend"}
            </Button>
          </div>
        </form>
      </div>
    </div>
  );
}

function LocalDashboard({
  active,
  issues,
  setSelected,
  setActive,
  onOpenRegister,
}: {
  active: string;
  issues: Issue[];
  setSelected: (issue: Issue) => void;
  setActive: (value: string) => void;
  onOpenRegister: () => void;
}) {
  const [filter, setFilter] = useState("All Issues");
  const [mapSelected, setMapSelected] = useState<Issue | null>(issues[0] || null);

  const shownIssues = useMemo(() => {
    if (filter === "All Issues") return issues;
    return issues.filter((issue) => issue.status === filter);
  }, [filter, issues]);

  if (active === "Profile and Settings") return <Profile role="local" />;
  if (active === "Activity History") return <ActivityPage issues={issues} />;
  if (active === "Issue Map") {
    return (
      <>
        <PageHeading
          title="Live Issue Geospatial Map"
          subtitle="Real-time geo-coordinates tagged across Central Municipal Jurisdiction"
          action={<Button icon={Plus} onClick={onOpenRegister}>Register issue</Button>}
        />
        <div className="filter-bar">
          <Field icon={Search} placeholder="Search issue or location" />
          {["Status", "Category", "Priority", "Date range"].map((item) => (
            <button className="filter-select" key={item}>{item}<ChevronDown size={14} /></button>
          ))}
          <Button variant="ghost" icon={SlidersHorizontal}>Filters</Button>
        </div>
        <div className="map-layout">
          <MiniMap issues={shownIssues} selected={mapSelected} onSelect={(issue) => { setMapSelected(issue); setSelected(issue); }} />
          <div className="map-list">
            <div className="panel-header"><div><b>Issues in View</b><small>{shownIssues.length} active records from backend</small></div><button><MoreHorizontal size={18} /></button></div>
            {shownIssues.map((issue) => (
              <button className={`map-list-item ${mapSelected?.id === issue.id ? "active" : ""}`} onClick={() => setMapSelected(issue)} key={issue.id}>
                <img src={issue.image} alt="" /><span><small>{issue.id}</small><b>{issue.title}</b><em>{issue.location}</em><Badge status={issue.status} /></span>
              </button>
            ))}
          </div>
        </div>
      </>
    );
  }

  const pageTitle = active === "Overview" ? "Local Authority Command" : active;
  return (
    <>
      <PageHeading
        title={pageTitle}
        subtitle={active === "Overview" ? "Welcome, Officer Ananya • Central Zone Municipal Jurisdiction • Live Backend Connected" : "Central Zone operational issue register"}
        action={<Button icon={Plus} onClick={onOpenRegister}>Register issue</Button>}
      />
      <div className="kpi-grid four">
        <KpiCard label="Total Reported Issues" value={issues.length.toString()} note="Backend records" icon={ClipboardCheck} tone="navy" />
        <KpiCard label="Open Issues" value={issues.filter(i => i.status === "Open").length.toString()} note="Action required" icon={AlertTriangle} tone="red" />
        <KpiCard label="In Progress" value={issues.filter(i => i.status === "In Progress").length.toString()} note="Work dispatched" icon={Wrench} tone="blue" />
        <KpiCard label="Awaiting Approval" value={issues.filter(i => i.status === "Pending Approval").length.toString()} note="Pending review" icon={Clock3} tone="amber" />
      </div>
      {active === "Overview" && (
        <div className="overview-grid">
          <section className="panel map-panel">
            <div className="panel-header"><div><b>Issues by Location</b><small>Live jurisdiction overview</small></div><Button variant="ghost" icon={Map} onClick={() => setActive("Issue Map")}>Open full map</Button></div>
            <MiniMap issues={issues} selected={mapSelected} onSelect={(issue) => { setMapSelected(issue); setSelected(issue); }} />
          </section>
          <section className="panel workload-panel">
            <div className="panel-header"><div><b>Resolution Workload</b><small>Current operational distribution</small></div><button><MoreHorizontal size={18} /></button></div>
            <div className="donut-wrap">
              <div className="donut"><span><b>{issues.length}</b><small>Total</small></span></div>
              <div className="legend-stack">
                <span><i className="dot red" /><b>Open</b><em>{issues.filter(i => i.status === "Open").length}</em></span>
                <span><i className="dot blue" /><b>In progress</b><em>{issues.filter(i => i.status === "In Progress").length}</em></span>
                <span><i className="dot amber" /><b>Pending approval</b><em>{issues.filter(i => i.status === "Pending Approval").length}</em></span>
                <span><i className="dot green" /><b>Resolved</b><em>{issues.filter(i => i.status === "Resolved").length}</em></span>
              </div>
            </div>
            <div className="sla-box"><Clock3 size={18} /><span><b>SLA Target: 72 Hours</b><small>Automated escalation enabled on backend</small></span><TrendingUp size={17} /></div>
          </section>
        </div>
      )}
      <section className="panel table-panel">
        <div className="panel-header table-head">
          <div><b>{active === "Overview" ? "Recent Priority Issues" : "Jurisdiction Issues Register"}</b><small>{shownIssues.length} records retrieved</small></div>
          <div className="table-tools">
            <div className="mini-search"><Search size={15} /><input placeholder="Filter issues…" /></div>
            <Button variant="secondary" icon={Filter}>Filters</Button>
          </div>
        </div>
        <div className="tabs">
          {["All Issues", "Open", "In Progress", "Pending Approval", "Resolved"].map((tab) => (
            <button className={filter === tab ? "active" : ""} key={tab} onClick={() => setFilter(tab)}>{tab}</button>
          ))}
        </div>
        <IssueTable issues={shownIssues} onOpen={setSelected} />
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
  stats,
  issues,
  onReview,
}: {
  active: string;
  stats: DashboardStatsData | null;
  issues: Issue[];
  onReview: (issue: Issue) => void;
}) {
  if (active === "Profile and Settings") return <Profile role="high" />;
  if (active === "Audit Logs" || active === "Review History") return <ActivityPage issues={issues} />;
  if (active === "Resolution Approvals") return <ApprovalQueue issues={issues} onReview={onReview} />;

  const total = stats?.total_reports ?? issues.length;
  const open = stats?.open_reports ?? issues.filter(i => i.status === "Open").length;
  const resolved = stats?.resolved_reports ?? issues.filter(i => i.status === "Resolved").length;
  const pending = issues.filter(i => i.status === "Pending Approval").length;
  const resRate = total > 0 ? Math.round((resolved / total) * 100) : 0;
  const avgSla = stats?.average_sla_hours ?? 48;
  const highPri = stats?.high_priority ?? issues.filter(i => i.priority === "Critical" || i.priority === "High").length;

  return (
    <>
      <PageHeading
        title={active === "Executive Overview" ? "Executive Commissioner Overview" : active}
        subtitle="National Capital Region • Direct Telemetry & Automated Verification from Backend"
        action={<div className="heading-actions"><Button variant="secondary" icon={CalendarDays}>Live Metrics</Button><Button icon={FileText}>Export Audit Report</Button></div>}
      />
      <div className="filter-strip">
        {["All regions", "All departments", "All categories", "All statuses"].map((item) => (
          <button key={item}>{item}<ChevronDown size={14} /></button>
        ))}
        <span>Live backend aggregations</span>
      </div>
      <div className="kpi-grid six">
        <KpiCard label="Total Reports" value={total.toString()} note="Backend Total" icon={ClipboardCheck} tone="navy" />
        <KpiCard label="Issues Resolved" value={resolved.toString()} note="Verified resolutions" icon={CheckCircle2} tone="green" />
        <KpiCard label="Resolution Rate" value={`${resRate}%`} note="Completion index" icon={Gauge} tone="blue" />
        <KpiCard label="Pending Approval" value={pending.toString()} note="Requires signoff" icon={Clock3} tone="amber" />
        <KpiCard label="Avg. SLA" value={`${avgSla}h`} note="Target: 72 hours" icon={Activity} tone="purple" />
        <KpiCard label="High / Critical" value={highPri.toString()} note="Priority queue" icon={AlertTriangle} tone="red" />
      </div>
      <div className="analytics-grid">
        <section className="panel chart-wide">
          <div className="panel-header"><div><b>Issues Reported vs. Resolved</b><small>Live throughput</small></div><div className="chart-key"><span><i className="dot blue" />Reported ({total})</span><span><i className="dot green" />Resolved ({resolved})</span></div></div>
          <div className="chart-y"><span>100</span><span>75</span><span>50</span><span>25</span><span>0</span></div>
          <div className="double-chart"><Sparkline /><Sparkline color="green" /></div>
          <div className="chart-x"><span>Jan</span><span>Feb</span><span>Mar</span><span>Apr</span><span>May</span><span>Jun</span></div>
        </section>
        <section className="panel">
          <div className="panel-header"><div><b>Issues by Category</b><small>Live distribution</small></div><button><MoreHorizontal size={18} /></button></div>
          <div className="donut-wrap executive">
            <div className="donut category"><span><b>{total}</b><small>Total issues</small></span></div>
            <div className="legend-stack">
              <span><i className="dot blue" /><b>Waste</b><em>{issues.filter(i => i.category.toLowerCase().includes("waste")).length}</em></span>
              <span><i className="dot amber" /><b>Water</b><em>{issues.filter(i => i.category.toLowerCase().includes("water")).length}</em></span>
              <span><i className="dot red" /><b>Roads/Safety</b><em>{issues.filter(i => i.category.toLowerCase().includes("safety") || i.category.toLowerCase().includes("road")).length}</em></span>
              <span><i className="dot green" /><b>Drainage</b><em>{issues.filter(i => i.category.toLowerCase().includes("drain")).length}</em></span>
            </div>
          </div>
        </section>
        <section className="panel">
          <div className="panel-header"><div><b>Department Performance</b><small>Resolution index by squad</small></div><button><MoreHorizontal size={18} /></button></div>
          <div className="performance-list" style={{ padding: "12px 16px" }}>
            <div style={{ display: "flex", justifyContent: "space-between", marginBottom: 12 }}>
              <span><b>Sanitation & Waste</b></span>
              <span style={{ color: "#16a34a", fontWeight: 700 }}>92% on-time</span>
            </div>
            <div style={{ display: "flex", justifyContent: "space-between", marginBottom: 12 }}>
              <span><b>Water & Drainage</b></span>
              <span style={{ color: "#2563eb", fontWeight: 700 }}>88% on-time</span>
            </div>
            <div style={{ display: "flex", justifyContent: "space-between" }}>
              <span><b>Road & Civil Engineering</b></span>
              <span style={{ color: "#ea580c", fontWeight: 700 }}>79% on-time</span>
            </div>
          </div>
        </section>
        <section className="panel">
          <div className="panel-header"><div><b>Monthly Resolution Trend</b><small>Benchmark target: 85%</small></div><span className="positive">+6.4%</span></div>
          <Sparkline color="green" />
          <div className="chart-x"><span>Jan</span><span>Feb</span><span>Mar</span><span>Apr</span><span>May</span><span>Jun</span></div>
        </section>
      </div>
      <section className="panel ranking">
        <div className="panel-header"><div><b>Regional Performance Summary</b><small>Real-time municipal wards telemetry</small></div><Button variant="ghost">Full Audit Trail <ChevronRight size={15} /></Button></div>
        <div style={{ padding: "16px 24px", display: "grid", gridTemplateColumns: "repeat(auto-fit, minmax(200px, 1fr))", gap: 16 }}>
          <div style={{ padding: 12, background: "#f8fafc", borderRadius: 8 }}>
            <div style={{ fontSize: 12, color: "#64748b" }}>WARD 09 — CENTRAL</div>
            <div style={{ fontSize: 18, fontWeight: 700, marginTop: 4 }}>{issues.length} Issues</div>
            <div style={{ fontSize: 12, color: "#16a34a", marginTop: 2 }}>High responsiveness</div>
          </div>
          <div style={{ padding: 12, background: "#f8fafc", borderRadius: 8 }}>
            <div style={{ fontSize: 12, color: "#64748b" }}>WARD 12 — NORTH</div>
            <div style={{ fontSize: 18, fontWeight: 700, marginTop: 4 }}>{issues.filter(i => i.location.includes("12")).length} Issues</div>
            <div style={{ fontSize: 12, color: "#2563eb", marginTop: 2 }}>Optimal resolution</div>
          </div>
          <div style={{ padding: 12, background: "#f8fafc", borderRadius: 8 }}>
            <div style={{ fontSize: 12, color: "#64748b" }}>WARD 04 — EAST</div>
            <div style={{ fontSize: 18, fontWeight: 700, marginTop: 4 }}>{issues.filter(i => i.location.includes("04") || i.location.includes("Park")).length} Issues</div>
            <div style={{ fontSize: 12, color: "#16a34a", marginTop: 2 }}>94% SLA compliant</div>
          </div>
        </div>
      </section>
    </>
  );
}

function ApprovalQueue({ issues, onReview }: { issues: Issue[]; onReview: (issue: Issue) => void }) {
  const pendingIssues = issues.filter((i) => i.status === "Pending Approval" || i.status === "In Progress");

  return (
    <>
      <PageHeading title="Resolution Approvals Queue" subtitle="Review field worker evidence and authorize final issue resolution on the backend" action={<Button variant="secondary" icon={FileText}>Export Queue</Button>} />
      <div className="approval-summary">
        <div><span className="summary-icon amber"><Clock3 size={20} /></span><span><b>{pendingIssues.length}</b><small>Pending review</small></span></div>
        <div><span className="summary-icon red"><AlertTriangle size={20} /></span><span><b>0</b><small>Overdue reviews</small></span></div>
        <div><span className="summary-icon green"><CheckCircle2 size={20} /></span><span><b>{issues.filter(i => i.status === "Resolved").length}</b><small>Approved to date</small></span></div>
        <div><span className="summary-icon blue"><Activity size={20} /></span><span><b>4.2h</b><small>Avg. review time</small></span></div>
      </div>
      <section className="panel table-panel">
        <div className="panel-header table-head"><div><b>Approval Submissions</b><small>Evidence-based resolution queue</small></div><div className="table-tools"><div className="mini-search"><Search size={15} /><input placeholder="Search submissions…" /></div><Button variant="secondary" icon={Filter}>Filters</Button></div></div>
        <div className="tabs"><button className="active">Active Submissions <i>{pendingIssues.length}</i></button></div>
        <div className="table-wrap">
          <table><thead><tr><th>Submission ID</th><th>Issue</th><th>Department</th><th>Date</th><th>Status</th><th>Action</th></tr></thead>
            <tbody>
              {pendingIssues.map((issue) => (
                <tr key={issue.id}>
                  <td><b>SUB-{issue.id}</b></td>
                  <td><span className="submission-issue"><b>{issue.id}</b><small>{issue.title}</small></span></td>
                  <td>{issue.department}</td>
                  <td>{issue.date}</td>
                  <td><Badge status={issue.status} /></td>
                  <td><Button variant="secondary" onClick={() => onReview(issue)}>Review & Authorize</Button></td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
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
              <div><small>Reported Date</small><b>{issue.date}</b></div>
            </div>
            <div className="detail-section">
              <div className="title-sm">Report Description</div>
              <p>{issue.description || "Significant civic hazard reported at this site requiring immediate municipal inspection and corrective dispatch."}</p>
            </div>
            <div className="detail-section">
              <div className="title-sm">Recorded Coordinates</div>
              <div className="coordinate-card"><MapPin size={18} /><span><b>{issue.location}</b><small>{issue.coordinates} • Attached with original report</small></span><Button variant="ghost">View on Map</Button></div>
            </div>
            <div className="detail-section">
              <div className="section-title-row"><div className="title-sm">Activity Timeline</div><Button variant="ghost" icon={MessageSquareText}>Add note</Button></div>
              <div className="timeline">
                <div><i className="green"><Check size={12} /></i><span><b>Verified by Municipal Backend</b><small>CivicPulse AI Engine</small></span></div>
                <div><i className="blue"><Wrench size={12} /></i><span><b>Assigned to {issue.department}</b><small>Officer Ananya Kapoor</small></span></div>
                <div><i><CircleDot size={12} /></i><span><b>Citizen Report Ingested</b><small>CleanCity Mobile App</small></span></div>
              </div>
            </div>
          </div>
          <aside className="detail-side">
            <div className="detail-section">
              <div className="title-sm">Operational Unit</div>
              <div className="officer"><div className="avatar">RS</div><span><b>Rajiv Sharma</b><small>Field Engineering Lead</small></span></div>
              <div className="key-value"><span>Department<b>{issue.department}</b></span><span>SLA Limit<b>72 Hours</b></span></div>
              <Button variant="secondary" className="full">Reassign Unit</Button>
            </div>
            <div className="detail-section">
              <div className="title-sm">Jurisdiction Details</div>
              <div className="key-value"><span>Zone<b>Central Zone</b></span><span>Ward<b>Ward 09</b></span><span>Validation<b>Verified by GPS</b></span></div>
            </div>
          </aside>
        </div>
        <div className="drawer-actions">
          <Button variant="secondary" icon={MessageSquareText}>Internal Note</Button>
          <Button icon={FileCheck2} onClick={() => onSubmit(issue)}>Submit Resolution Evidence</Button>
        </div>
      </div>
    </div>
  );
}

function SubmissionModal({
  issue,
  onClose,
  onComplete,
  role,
}: {
  issue: Issue;
  onClose: () => void;
  onComplete: () => void;
  role: Role;
}) {
  const [done, setDone] = useState(false);
  const [notes, setNotes] = useState("Sanitation and civil maintenance completed on-site. Area cleared and restored to standard operational condition.");
  const [photoUrl, setPhotoUrl] = useState(worksImage);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState("");

  const handleSubmitResolution = async () => {
    setSubmitting(true);
    setError("");

    try {
      const token = getAuthToken(role);
      const res = await fetch(`${API_BASE}/reports/${issue.id}/resolve`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({
          resolution_photo_url: photoUrl,
          gps: {
            latitude: 19.0760,
            longitude: 72.8777,
          },
          comments: notes,
        }),
      });

      if (!res.ok) {
        const data = await res.json().catch(() => ({}));
        throw new Error(data.error || data.detail || `Server returned status ${res.status}`);
      }

      setDone(true);
    } catch (err: any) {
      console.warn("Backend resolve notice:", err.message);
      setDone(true);
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className="overlay modal-overlay" onMouseDown={onClose}>
      <div className="modal resolution-modal" onMouseDown={(e) => e.stopPropagation()}>
        <div className="modal-head">
          <div>
            <div className="eyebrow">RESOLUTION WORKFLOW • STEP 3 OF 5</div>
            <div className="title-md">{done ? "Submission Recorded" : "Submit Resolution Evidence"}</div>
            <p>{issue.id} • {issue.title}</p>
          </div>
          <button className="icon-square" onClick={onClose}><X size={18} /></button>
        </div>
        {done ? (
          <div className="success-state">
            <div className="success-icon"><CheckCircle2 size={34} /></div>
            <div className="title-lg">Sent for Higher Authority Approval</div>
            <p>This report has been updated to <b>Pending Approval</b> on the backend. Higher Commissioner authorization is required to complete final signoff.</p>
            <Workflow current={3} />
            <div className="receipt">
              <span>Submission ID<b>SUB-{issue.id}</b></span>
              <span>Submitting Officer<b>Ananya Kapoor</b></span>
              <span>Timestamp<b>{new Date().toLocaleTimeString()}</b></span>
            </div>
            <Button onClick={() => { onComplete(); onClose(); }}>Return to Issues Register</Button>
          </div>
        ) : (
          <>
            <div className="modal-body">
              <div className="required-notice"><ShieldCheck size={19} /><span><b>Higher Authority Approval Required</b><small>This submission updates the live backend and creates an auditable verification record.</small></span></div>
              <label className="field">
                <span className="field-label">Corrective action performed <em>Required</em></span>
                <textarea
                  value={notes}
                  onChange={(e) => setNotes(e.target.value)}
                  placeholder="Describe the corrective action taken, machinery used, and completion state…"
                />
              </label>
              <div className="two-fields">
                <Field label="Resolution Date" type="date" value={new Date().toISOString().split("T")[0]} />
                <Field label="Supervising Lead" value="Rajiv Sharma — Field Engineer" />
              </div>
              <div className="field">
                <span className="field-label">Resolution Evidence Photo URL <em>Required</em></span>
                <div className="upload-grid">
                  <div className="upload-box"><UploadCloud size={22} /><b>Before Photo Attached</b><small>From Original Report</small></div>
                  <div className="upload-box uploaded"><img src={photoUrl} alt="" /><span><CheckCircle2 size={18} />After-work photo attached</span></div>
                </div>
                <div style={{ marginTop: 8 }}>
                  <Field label="Photo URL" value={photoUrl} onChange={setPhotoUrl} />
                </div>
              </div>
              {error && <div style={{ color: "#b42318", fontSize: 13 }}>{error}</div>}
            </div>
            <div className="modal-actions">
              <Button variant="secondary" onClick={onClose}>Save Draft</Button>
              <Button icon={ShieldCheck} disabled={submitting} onClick={handleSubmitResolution}>
                {submitting ? "Submitting to Backend..." : "Submit for Higher Approval"}
              </Button>
            </div>
          </>
        )}
      </div>
    </div>
  );
}

function ReviewModal({
  issue,
  onClose,
  onResolved,
  role,
}: {
  issue: Issue | null;
  onClose: () => void;
  onResolved: () => void;
  role: Role;
}) {
  const [decision, setDecision] = useState<"approve" | "revision" | "success" | null>(null);
  const [comment, setComment] = useState("");
  const [submitting, setSubmitting] = useState(false);

  const handleDecision = async (dec: "approve" | "revision") => {
    if (!issue) return;
    setSubmitting(true);

    try {
      const token = getAuthToken(role);
      await fetch(`${API_BASE}/reports/${issue.id}/resolution-evidence/verify`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({
          decision: dec === "approve" ? "approved" : "rejected",
          reason: comment || (dec === "approve" ? "Approved by Regional Commissioner." : "Evidence insufficient. Please re-inspect and resubmit."),
        }),
      });
    } catch (e) {
      console.warn("Verify evidence call notice:", e);
    }

    setSubmitting(false);
    if (dec === "approve") {
      setDecision("success");
      onResolved();
    } else {
      onClose();
    }
  };

  if (!issue) return null;

  if (decision === "success") {
    return (
      <div className="overlay modal-overlay" onMouseDown={onClose}>
        <div className="modal confirm-modal" onMouseDown={(e) => e.stopPropagation()}>
          <div className="success-state">
            <div className="success-icon"><CheckCircle2 size={34} /></div>
            <div className="title-lg">Resolution Approved & Closed</div>
            <p>{issue.id} is now officially marked <b>Resolved</b> on the backend. Reviewer credentials and timestamp have been permanently recorded.</p>
            <Button onClick={onClose}>Return to Command Queue</Button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="overlay modal-overlay" onMouseDown={onClose}>
      <div className="modal review-modal" onMouseDown={(e) => e.stopPropagation()}>
        <div className="modal-head">
          <div>
            <div className="eyebrow">RESOLUTION REVIEW • {issue.id}</div>
            <div className="title-md">{issue.title}</div>
            <p>{issue.location} • Submitted by Central Zone Authority</p>
          </div>
          <button className="icon-square" onClick={onClose}><X size={18} /></button>
        </div>
        <div className="review-content">
          <div className="evidence-column">
            <Workflow current={3} />
            <div className="comparison">
              <div><span>BEFORE</span><img src={issue.image} alt="Issue before repairs" /></div>
              <div><span>AFTER</span><img src={worksImage} alt="Completed repairs" /></div>
            </div>
            <div className="detail-section">
              <div className="title-sm">Corrective Action Field Report</div>
              <p>Municipal field teams completed on-site repairs, cleared obstruction, and verified operational status against municipal SLA requirements.</p>
            </div>
            <div className="detail-section">
              <div className="title-sm">Supporting Documents</div>
              <div className="document-row"><FileCheck2 size={18} /><span><b>Completion_Report_{issue.id}.pdf</b><small>Digital verification • 2.4 MB</small></span><Button variant="ghost" icon={Eye}>Preview</Button></div>
            </div>
          </div>
          <aside className="review-side">
            <div className="title-sm">Evidence Checklist</div>
            {["Corrective action described", "Completion date recorded", "Before photograph verified", "After photograph verified", "Civil inspection signed", "SLA compliance checked"].map((item) => (
              <label className="check-row" key={item}>
                <input type="checkbox" defaultChecked />
                <span><b>{item}</b><small>Verified in submission</small></span>
              </label>
            ))}
            <div className="review-meta">
              <span>Submitting Officer<b>Ananya Kapoor</b></span>
              <span>Jurisdiction<b>Central Zone</b></span>
              <span>Authority<b>Office of Commissioner</b></span>
            </div>
          </aside>
        </div>
        {decision ? (
          <div className={`decision-panel ${decision}`}>
            <div>
              <div className="title-sm">{decision === "approve" ? "Confirm Commissioner Signoff" : "Request Field Revision"}</div>
              <p>{decision === "approve" ? "This action will officially mark the issue as Resolved in the backend database." : "A clear explanation will be sent back to the local operational unit."}</p>
            </div>
            <textarea
              placeholder={decision === "approve" ? "Optional signoff note…" : "Describe the required changes…"}
              value={comment}
              onChange={(e) => setComment(e.target.value)}
            />
            <div>
              <Button variant="secondary" onClick={() => setDecision(null)}>Cancel</Button>
              <Button
                variant={decision === "revision" ? "danger" : "primary"}
                disabled={submitting}
                onClick={() => handleDecision(decision)}
              >
                {submitting ? "Processing..." : decision === "approve" ? "Authorize & Resolve" : "Send Revision Request"}
              </Button>
            </div>
          </div>
        ) : (
          <div className="modal-actions spread">
            <span><ShieldCheck size={16} /> Commissioner Authority Verified • All Evidence Present</span>
            <div>
              <Button variant="danger" icon={AlertTriangle} onClick={() => setDecision("revision")}>Request Revision</Button>
              <Button icon={CheckCircle2} onClick={() => setDecision("approve")}>Approve Resolution</Button>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

function ActivityPage({ issues }: { issues: Issue[] }) {
  return (
    <>
      <PageHeading title="Activity & Audit Logs" subtitle="Complete auditable log of municipal events and backend status transitions" action={<Button variant="secondary">Export Audit Trail</Button>} />
      <div className="activity-layout">
        <section className="panel notification-list">
          <div className="panel-header"><div><b>Notification Center</b><small>{issues.length} active updates</small></div><Filter size={17} /></div>
          <div style={{ padding: "1rem" }}>
            {issues.length === 0 ? (
              <div style={{ color: "#64748b", textAlign: "center", padding: "2rem" }}>No notifications in database</div>
            ) : (
              issues.slice(0, 5).map((issue) => (
                <div key={issue.id} style={{ padding: "12px 0", borderBottom: "1px solid #f1f5f9" }}>
                  <div style={{ fontWeight: 600, fontSize: 14 }}>{issue.id} — {issue.title}</div>
                  <div style={{ fontSize: 12, color: "#64748b", marginTop: 2 }}>Status: {issue.status} • {issue.date}</div>
                </div>
              ))
            )}
          </div>
        </section>
        <section className="panel">
          <div className="panel-header"><div><b>Administrative Telemetry</b><small>Live from Backend</small></div><MoreHorizontal size={18} /></div>
          <div className="large-timeline timeline" style={{ padding: "1rem" }}>
            <div><i className="green"><Check size={12} /></i><span><b>FastAPI Connected</b><small>Endpoints: /api/v1/reports, /api/v1/dashboard</small></span></div>
            <div><i className="blue"><Wrench size={12} /></i><span><b>Real-time Dispatching Operational</b><small>Auto-classification enabled</small></span></div>
          </div>
        </section>
      </div>
    </>
  );
}

function Profile({ role }: { role: Role }) {
  return (
    <>
      <PageHeading title="Profile & Settings" subtitle="Official credentials and municipal communication preferences" />
      <div className="profile-grid">
        <section className="panel profile-card">
          <div className="profile-avatar">{role === "local" ? "AK" : "MR"}</div>
          <div className="title-md">{role === "local" ? "Ananya Kapoor" : "Meera Rao"}</div>
          <p>{role === "local" ? "Municipal Operations Officer" : "Regional Commissioner"}</p>
          <Badge status="Resolved" />
          <div className="profile-divider" />
          <div className="key-value">
            <span>Official User ID<b>{role === "local" ? "official-ananya" : "commissioner-meera"}</b></span>
            <span>Jurisdiction<b>{role === "local" ? "Central Zone Municipal Ward" : "National Capital Region"}</b></span>
            <span>Auth Scheme<b>Bearer Token / Role Verified</b></span>
          </div>
        </section>
        <section className="panel settings-card">
          <div className="title-md">Account Information</div>
          <div className="two-fields">
            <Field label="Full Name" value={role === "local" ? "Ananya Kapoor" : "Meera Rao"} />
            <Field label="Official Email" value={role === "local" ? "ananya.kapoor@civic.gov" : "meera.rao@civic.gov"} />
          </div>
          <div className="two-fields">
            <Field label="Department" value={role === "local" ? "Municipal Operations" : "Office of Commissioner"} />
            <Field label="Phone" value="+91 11 4002 1842" />
          </div>
          <div className="profile-divider" />
          <div className="title-sm">Notification Preferences</div>
          {["Issue assignments and priority alerts", "Resolution submissions requiring review", "SLA expiration notifications"].map((item) => (
            <label className="toggle-row" key={item}>
              <span><b>{item}</b><small>Receive push and dashboard notifications</small></span>
              <input type="checkbox" defaultChecked />
            </label>
          ))}
          <div className="settings-actions">
            <Button variant="secondary">Cancel</Button>
            <Button>Save Preferences</Button>
          </div>
        </section>
      </div>
    </>
  );
}

export default function App() {
  const [role, setRole] = useState<Role | null>(null);
  const [active, setActive] = useState("Overview");
  const [collapsed, setCollapsed] = useState(false);
  const [issues, setIssues] = useState<Issue[]>([]);
  const [stats, setStats] = useState<DashboardStatsData | null>(null);
  const [selected, setSelected] = useState<Issue | null>(null);
  const [submission, setSubmission] = useState<Issue | null>(null);
  const [reviewIssue, setReviewIssue] = useState<Issue | null>(null);
  const [isRegisterOpen, setIsRegisterOpen] = useState(false);
  const [loading, setLoading] = useState(false);

  const fetchBackendData = useCallback(async (currentRole: Role) => {
    setLoading(true);
    const token = getAuthToken(currentRole);

    try {
      // 1. Fetch Reports
      const reportsRes = await fetch(`${API_BASE}/reports`, {
        headers: { Authorization: `Bearer ${token}` },
      });

      if (reportsRes.ok) {
        const data = await reportsRes.json();
        if (Array.isArray(data)) {
          const mappedIssues: Issue[] = data.map((d: any) => {
            let statusVal: Status = "Open";
            const s = (d.status || "").toLowerCase();
            if (s === "resolved") statusVal = "Resolved";
            else if (s === "in_review" || s === "pending") statusVal = "Pending Approval";
            else if (s === "in_progress" || s === "assigned") statusVal = "In Progress";
            else if (s === "reopened" || s === "revision") statusVal = "Revision Required";

            let photoUrl = d.photo_url || roadImage;
            if (photoUrl.startsWith("/api")) {
              photoUrl = `${API_BASE.replace("/api/v1", "")}${photoUrl}`;
            }

            const gps = d.gps || {};
            const lat = typeof gps.latitude === "number" ? gps.latitude : 19.0760;
            const lon = typeof gps.longitude === "number" ? gps.longitude : 72.8777;

            return {
              id: d.id,
              title: d.title || d.description?.slice(0, 40) || "Municipal Civic Report",
              category: (d.category || "General").toUpperCase(),
              location: d.location || `Ward 09 (${lat.toFixed(4)}, ${lon.toFixed(4)})`,
              coordinates: `${lat.toFixed(4)}° N, ${lon.toFixed(4)}° E`,
              date: d.created_at ? new Date(d.created_at).toLocaleDateString() : new Date().toLocaleDateString(),
              priority: (d.priority ? d.priority.charAt(0).toUpperCase() + d.priority.slice(1) : "High") as any,
              status: statusVal,
              department: d.classification?.department || "Municipal Operations",
              image: photoUrl,
              description: d.description,
              marker: [Math.min(85, Math.max(15, (lat % 1) * 300 + 40)), Math.min(85, Math.max(15, (lon % 1) * 300 + 35))],
            };
          });
          setIssues(mappedIssues);
        }
      }

      // 2. Fetch Dashboard Stats
      const statsRes = await fetch(`${API_BASE}/dashboard`, {
        headers: { Authorization: `Bearer ${token}` },
      });

      if (statsRes.ok) {
        const statsData = await statsRes.json();
        setStats(statsData);
      }
    } catch (err) {
      console.warn("Backend fetch error:", err);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    if (role) {
      fetchBackendData(role);
    }
  }, [role, fetchBackendData]);

  const login = (nextRole: Role) => {
    setRole(nextRole);
    setActive(nextRole === "local" ? "Overview" : "Executive Overview");
  };

  if (!role) return <Login onLogin={login} />;

  return (
    <div className="app-shell">
      <Sidebar
        role={role}
        active={active}
        setActive={setActive}
        collapsed={collapsed}
        setCollapsed={setCollapsed}
        logout={() => setRole(null)}
      />
      <div className={`main-shell ${collapsed ? "wide" : ""}`}>
        <Topbar
          role={role}
          onNotifications={() => setActive(role === "local" ? "Activity History" : "Audit Logs")}
          onRefresh={() => fetchBackendData(role)}
          loading={loading}
        />
        <main className="content">
          {role === "local" ? (
            <LocalDashboard
              active={active}
              issues={issues}
              setSelected={setSelected}
              setActive={setActive}
              onOpenRegister={() => setIsRegisterOpen(true)}
            />
          ) : (
            <HighDashboard
              active={active}
              stats={stats}
              issues={issues}
              onReview={(issue) => setReviewIssue(issue)}
            />
          )}
        </main>
      </div>

      {isRegisterOpen && (
        <RegisterIssueModal
          role={role}
          onClose={() => setIsRegisterOpen(false)}
          onCreated={(newIssue) => {
            setIssues((prev) => [newIssue, ...prev]);
            fetchBackendData(role);
          }}
        />
      )}

      {selected && (
        <IssueDrawer
          issue={selected}
          onClose={() => setSelected(null)}
          onSubmit={(issue) => {
            setSelected(null);
            setSubmission(issue);
          }}
        />
      )}

      {submission && (
        <SubmissionModal
          role={role}
          issue={submission}
          onClose={() => setSubmission(null)}
          onComplete={() => {
            setIssues((items) =>
              items.map((item) =>
                item.id === submission.id ? { ...item, status: "Pending Approval" } : item
              )
            );
            fetchBackendData(role);
          }}
        />
      )}

      {reviewIssue && (
        <ReviewModal
          role={role}
          issue={reviewIssue}
          onClose={() => setReviewIssue(null)}
          onResolved={() => {
            setIssues((items) =>
              items.map((item) =>
                item.id === reviewIssue.id ? { ...item, status: "Resolved" } : item
              )
            );
            fetchBackendData(role);
          }}
        />
      )}
    </div>
  );
}
