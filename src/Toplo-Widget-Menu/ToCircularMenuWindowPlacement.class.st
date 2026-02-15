Class {
	#name : #ToCircularMenuWindowPlacement,
	#superclass : #ToElementCustomPlacement,
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #'api - displaying' }
ToCircularMenuWindowPlacement >> positionElement: aWindow onEvent: anEvent context: aBlElementBoundsUpdateContext [
	" The window placing is at top right or bottom left according to menu or the menubar "

	| root menuItem pos |
	root := aWindow anchorRoot.
	menuItem := aWindow menuItem.
	menuItem isSubmenu ifTrue: [
			menuItem parentMenuDo: [ :pm |
					| center |
					center := pm menuWindow measuredBounds center.
					aWindow position: center - (aWindow measuredExtent // 2).
					^ self ] ].
	menuItem isMenuPaneMenu ifTrue: [
			menuItem menuPaneDo: [ :mp |
					| center |
					center := mp measuredBounds center.
					aWindow position: center - (aWindow measuredExtent // 2).
					^ self ] ].
	pos := (menuItem measuredBounds inParent: root) bottomLeft.
	aWindow position: pos
]
