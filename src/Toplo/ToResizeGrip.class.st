Class {
	#name : #ToResizeGrip,
	#superclass : #ToElement,
	#instVars : [
		'thickness',
		'initialDragPosition',
		'initialPosition',
		'initialExtent'
	],
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #initialization }
ToResizeGrip class >> initializeToRawTheme: aTheme [

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme addTokenNamed: #'window-corner-grips-size' withValue: 12.

	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme
				when: ToInstallSkinEvent
				do: [ :e |
				e addStyleSheetProperty: (ToFeatureProperty name: #thickness) ].
			aTheme
				when: ToInstallSkinEvent
				write: #thickness asWritableProperty
				with: [ :e | e valueOfTokenNamed: #'window-corner-grips-size' ].
			aTheme
				when: ToHoveredSkinEvent
				write: #mouseCursor asWritableProperty
				with: [ :e | e resizeCursor ].
			aTheme
				when: ToLeftSkinEvent
				write: #mouseCursor asWritableProperty
				with: [ :e | Cursor normal ] ]
]

{ #category : #initialization }
ToResizeGrip >> attachTo: anElement [

	self addEventHandler: (ToResizeGripEventHandler new gripTarget: anElement)
]

{ #category : #'api - attaching / detaching' }
ToResizeGrip >> attachToParent: anElement [

	self attachTo: anElement.
	anElement addChild: self
]

{ #category : #initialization }
ToResizeGrip >> defaultThickness [

	^ 7
]

{ #category : #'mouse processing' }
ToResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	self subclassResponsibility 
]

{ #category : #accessing }
ToResizeGrip >> initialDragPosition [

	^ initialDragPosition
]

{ #category : #accessing }
ToResizeGrip >> initialDragPosition: aPoint [

	initialDragPosition := aPoint
]

{ #category : #accessing }
ToResizeGrip >> initialExtent [ 

	^ initialExtent 
]

{ #category : #accessing }
ToResizeGrip >> initialExtent: aPoint [

	initialExtent := aPoint
]

{ #category : #accessing }
ToResizeGrip >> initialPosition [ 

	^ initialPosition 
]

{ #category : #accessing }
ToResizeGrip >> initialPosition: aPoint [

	initialPosition := aPoint
]

{ #category : #initialization }
ToResizeGrip >> initialize [

	super initialize.
	
	self thickness: self defaultThickness.
	self constraintsDo: [ :c | c ignoreByLayout ]

]

{ #category : #'as yet unclassified' }
ToResizeGrip >> resizeCursor [

	^ self subclassResponsibility
]

{ #category : #initialization }
ToResizeGrip >> thickness [

	^ thickness
]

{ #category : #initialization }
ToResizeGrip >> thickness: aNumber [

	thickness := aNumber
]
