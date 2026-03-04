Class {
	#name : #ToScrollbarThumbElement,
	#superclass : #ToElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#category : #'Toplo-Core-Scrollbar'
}

{ #category : #initialization }
ToScrollbarThumbElement class >> initializeToRawTheme: aTheme [

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme
		addTokenNamed: #'scrollbar-thumb-background'
		withValue: (Color veryLightGray alpha: 0.8).

	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme when: ToInstallSkinEvent do: [ :e |
					| breadth |
					breadth := e valueOfTokenNamed: #'scrollbar-breadth'.
					e isHorizontal
						ifTrue: [ e height: breadth ]
						ifFalse: [ e width: breadth ] ].
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #geometry)
				with: [ :e | BlStadiumGeometry new ].
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #background)
				with: [ :e | e valueOfTokenNamed: #'scrollbar-thumb-background' ] ]
]

{ #category : #configuration }
ToScrollbarThumbElement >> applyConfiguration [

	super applyConfiguration.
	self isHorizontal
		ifTrue: [ self constraintsDo: [ :c | c minWidth: 20.0 ] ]
		ifFalse: [ self constraintsDo: [ :c | c minHeight: 20.0 ] ]
]

{ #category : #initialization }
ToScrollbarThumbElement >> defaultLayout [ 

	^ BlLinearLayout new
]

{ #category : #initialization }
ToScrollbarThumbElement >> initialize [

	super initialize.
	self layout: self defaultLayout
]
