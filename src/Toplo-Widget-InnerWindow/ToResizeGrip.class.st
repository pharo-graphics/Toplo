Class {
	#name : #ToResizeGrip,
	#superclass : #ToElement,
	#instVars : [
		'thickness',
		'initialDragPosition',
		'initialPosition',
		'initialExtent'
	],
	#category : #'Toplo-Widget-InnerWindow-Support'
}

{ #category : #initialization }
ToResizeGrip class >> initializeToRawTheme: aTheme [

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme addWritableProperty: (ToFeatureProperty name: #thickness).
	aTheme addTokenNamed: #'window-corner-grips-size' withValue: 12.

	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #geometry)
				with: [ :e |
						BlRoundedRectangleGeometry cornerRadius:
							(e valueOfTokenNamed: #'window-corner-grips-size') ].
			aTheme
				when: ToHoveredSkinEvent 
				write: (aTheme property: #border)
				with: [ :e | BlBorder paint: (Color lightGray alpha: 0.2)].
			aTheme
				when: ToHoveredSkinEvent 
				write: (aTheme property: #background)
				with: [ :e | Color lightGray alpha: 0.1 ].
			aTheme
				when: ToHoveredSkinEvent
				write: (aTheme property: #mouseCursor)
				with: [ :e | e resizeCursor ].

			aTheme
				when: ToLeftSkinEvent 
				write: (aTheme property: #border)
				with: [ :e | BlBorder empty].
			aTheme
				when: ToLeftSkinEvent 
				write: (aTheme property: #mouseCursor)
				with: [ :e | Cursor normal ].
			aTheme
				when: ToLeftSkinEvent 
				write: (aTheme property: #background)
				with: [ :e | Color transparent].
				
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #thickness)
				with: [ :e | e valueOfTokenNamed: #'window-corner-grips-size' ] ]
]

{ #category : #accessing }
ToResizeGrip >> cursorSelector [

	^ self subclassResponsibility 
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
ToResizeGrip >> initialExtent: aPoint [

	initialExtent := aPoint
]

{ #category : #accessing }
ToResizeGrip >> initialPosition: aPoint [

	initialPosition := aPoint
]

{ #category : #accessing }
ToResizeGrip >> initialSize: aPoint [

	self
		deprecated: 'Use initialExtent: instead'
		transformWith:
			'`@receiver initialSize: `@argument'
			-> '`@receiver initialExtent: `@argument'.

	self initialExtent: aPoint
]

{ #category : #initialization }
ToResizeGrip >> initialize [

	super initialize.
	
	self thickness: self defaultThickness.
	self constraintsDo: [ :c | c ignoreByLayout ]

]

{ #category : #'mouse processing' }
ToResizeGrip >> layoutIn: anElement [

	self subclassResponsibility 
]

{ #category : #accessing }
ToResizeGrip >> resizeCursor [

	^ Cursor perform: self cursorSelector
]

{ #category : #initialization }
ToResizeGrip >> target: anElement [

	self layoutIn: anElement.
	self addEventHandler: (ToResizeGripEventHandler new gripTarget: anElement)
]

{ #category : #initialization }
ToResizeGrip >> thickness [

	^ thickness
]

{ #category : #initialization }
ToResizeGrip >> thickness: aNumber [

	thickness := aNumber
]
