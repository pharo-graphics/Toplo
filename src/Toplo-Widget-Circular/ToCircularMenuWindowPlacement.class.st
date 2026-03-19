Class {
	#name : #ToCircularMenuWindowPlacement,
	#superclass : #ToElementCustomPlacement,
	#category : #'Toplo-Widget-Circular-Menu'
}

{ #category : #'api - displaying' }
ToCircularMenuWindowPlacement >> positionElement: aWindow onEvent: anEvent context: aBlElementBoundsUpdateContext [
	" The window placing is at top right or bottom left according to menu or the menubar "

	| root menuItem pos |
	root := aWindow anchorRoot.
	menuItem := aWindow menuItem.

	" if encompassing, the the submenu is place at the center 
	of the parent menu menuwindow or menu pane "
	menuItem encompassing ifTrue: [
			menuItem isSubmenu ifTrue: [
					menuItem parentMenuDo: [ :pm |
							aWindow constraintsDo: [ :c |
									c ignoreByLayout.
									c anchors removeAll.
									c anchors add:
										(c anchors centerAnchor on: pm menuWindow centerAnchor) ].
							^ self ] ].
			menuItem isMenuPaneMenu ifTrue: [
					menuItem menuPaneDo: [ :mp |
							aWindow constraintsDo: [ :c |
									c ignoreByLayout.
									c anchors removeAll.
									c anchors add: (c anchors centerAnchor on: mp centerAnchor) ].
							^ self ] ] ].

	pos := (menuItem measuredBounds inParent: root) bottomLeft.
	aWindow position: pos
]
