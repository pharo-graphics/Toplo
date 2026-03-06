Class {
	#name : #ToHandle,
	#superclass : #ToElement,
	#instVars : [
		'thickness',
		'initialDragPosition',
		'initialPosition',
		'initialExtent',
		'gripTarget'
	],
	#category : #'Toplo-Layout-Support-Handles'
}

{ #category : #initialization }
ToHandle class >> initializeToRawTheme: aTheme [

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme addTokenNamed: #'window-corner-grips-size' withValue: 6.

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
				with: [ :e | e handleCursor ].
			aTheme
				when: ToLeftSkinEvent
				write: #mouseCursor asWritableProperty
				with: [ :e | Cursor normal ] ]
]

{ #category : #configuration }
ToHandle >> applyConfiguration [

	super applyConfiguration.
	gripTarget ifNil: [ Error signal: 'a grip target must be set' ]
]

{ #category : #'api - attaching / detaching' }
ToHandle >> attachTo: anElement [

	gripTarget ifNotNil: [ (BlImmutableObjectChangeError object: self) signal ].
	gripTarget := anElement.
	self addEventHandler: ToHandleEventHandler new.
	self requestConfiguration 
]

{ #category : #'api - attaching / detaching' }
ToHandle >> attachToParent: anElement [

	self attachTo: anElement.
	anElement addChild: self
]

{ #category : #initialization }
ToHandle >> defaultThickness [

	^ 6
]

{ #category : #'mouse processing' }
ToHandle >> dragBy: deltaFromInitialPosition [

	self subclassResponsibility 
]

{ #category : #accessing }
ToHandle >> gripTarget [

	^ gripTarget
]

{ #category : #accessing }
ToHandle >> handleCursor [

	^ nil
]

{ #category : #private }
ToHandle >> initialDragPosition [

	^ initialDragPosition
]

{ #category : #private }
ToHandle >> initialDragPosition: aPoint [

	initialDragPosition := aPoint
]

{ #category : #private }
ToHandle >> initialExtent [ 

	^ initialExtent 
]

{ #category : #private }
ToHandle >> initialExtent: aPoint [

	initialExtent := aPoint
]

{ #category : #private }
ToHandle >> initialPosition [ 

	^ initialPosition 
]

{ #category : #private }
ToHandle >> initialPosition: aPoint [

	initialPosition := aPoint
]

{ #category : #initialization }
ToHandle >> initialize [

	super initialize.
	self thickness: self defaultThickness
]

{ #category : #accessing }
ToHandle >> thickness [

	^ thickness
]

{ #category : #accessing }
ToHandle >> thickness: aNumber [

	thickness = aNumber ifTrue: [ ^ self ].
	thickness := aNumber.
	self requestConfiguration 
]
