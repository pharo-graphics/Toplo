Class {
	#name : #ToCircularMenuWindowMeasurement,
	#superclass : #ToElementCustomMeasurement,
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #api }
ToCircularMenuWindowMeasurement >> onMeasure: anExtentMeasurementSpec element: anElement onEvent: anEvent [

	| menuItem radius |
	menuItem := anElement anchorElement.
	radius := menuItem layoutRadius.

	" if encompassing, then the inner radius ratio 
	and the radius ((which is greater that the parent menu radius) 
	depend on the parent menu radius "
	menuItem encompassing ifTrue: [
			(menuItem isSubmenu or: [ menuItem isMenuPaneMenu ]) ifTrue: [
					| ratio parentElement |
					menuItem allParentMenusOrMenuPaneDo: [ :m |
						radius := radius + (m layoutRadius * m outerRadialRatio) ].
					parentElement := menuItem isSubmenu
						                 ifTrue: [ menuItem parentMenu menuWindow ]
						                 ifFalse: [ menuItem menuPane ].
					ratio := parentElement measuredExtent x / 2
					         / (radius * menuItem outerRadialRatio).
					menuItem innerRadialRatio: ratio asFloat.
					menuItem startAngle: menuItem holder nodeContainer startAngle ] ].
	anExtentMeasurementSpec widthSpec beExact: radius * 2.
	anExtentMeasurementSpec heightSpec beExact: radius * 2
]
