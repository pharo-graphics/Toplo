"
I describe the package `Toplo-Widget-Pane`: the panes that structure a window, the dividers that resize their children, and the placeholder layers and scrollable elements that go with them.

Start from `ToPane` and `ToPaneDivider`. `ToDivider` is the common part of dividers, also used by tables. `ToPlaceholderLayer` and `ToScrollableElement` serve other widgets, lists first. The edge pane classes (`ToEdgePane`, `ToEdgePaneOverlay`) are unfinished.

I also include metadata used by the code quality tools.
"
Class {
	#name : #ManifestToploWidgetPane,
	#superclass : #PackageManifest,
	#category : #'Toplo-Widget-Pane-Manifest'
}
