import { useState } from "preact/hooks";

export interface ResearchLink {
	label: string;
	href: string;
}

interface NavbarProps {
	homeHref?: string;
	research?: ResearchLink[];
}

export default function Navbar({ homeHref, research }: NavbarProps) {
	const [active, setActive] = useState(false);

	const hasDropdown = (research?.length ?? 0) > 0;
	if (!homeHref && !hasDropdown) return null;

	return (
		<nav class="navbar" aria-label="main navigation">
			<div class="navbar-brand">
				<button
					type="button"
					class={`navbar-burger${active ? " is-active" : ""}`}
					aria-label="menu"
					aria-expanded={active}
					onClick={() => setActive(!active)}
				>
					<span aria-hidden="true"></span>
					<span aria-hidden="true"></span>
					<span aria-hidden="true"></span>
				</button>
			</div>
			<div class={`navbar-menu${active ? " is-active" : ""}`}>
				<div
					class="navbar-start"
					style="flex-grow: 1; justify-content: center;"
				>
					{homeHref && (
						<a class="navbar-item" href={homeHref}>
							<span class="icon">
								<i class="fas fa-home"></i>
							</span>
						</a>
					)}

					{hasDropdown && (
						<div class="navbar-item has-dropdown">
							<span class="navbar-link">More Research</span>
							<div class="navbar-dropdown">
								{research!.map(({ label, href }) => (
									<a class="navbar-item" href={href}>
										{label}
									</a>
								))}
							</div>
						</div>
					)}
				</div>
			</div>
		</nav>
	);
}
