Class {
	#name : #ToCircularMenuWindowMeasurement,
	#superclass : #ToElementCustomMeasurement,
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #api }
ToCircularMenuWindowMeasurement >> onMeasure: anExtentMeasurementSpec element: anElement onEvent: anEvent [

	| menuItem radius |
	menuItem := anElement anchorElement.
	radius := menuItem radius.
	menuItem encompassing ifTrue: [
			(menuItem isSubmenu or: [ menuItem isMenuPaneMenu ]) ifTrue: [
					| ratio |
					menuItem allParentMenusOrMenuPaneDo: [ :m |
							| parentElement |
							radius := radius + m radius.
							parentElement := menuItem isSubmenu
								                 ifTrue: [ menuItem parentMenu menuWindow ]
								                 ifFalse: [ menuItem menuPane ].
							ratio := parentElement measuredExtent x / 2 / radius.
							menuItem innerRadius: ratio asFloat ] ] ].
	anExtentMeasurementSpec widthSpec beExact: radius * 2.
	anExtentMeasurementSpec heightSpec beExact: radius * 2
]
