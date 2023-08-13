Class {
	#name : #ToMiddleSizing,
	#superclass : #ToControlSizing,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'private geometry' }
ToMiddleSizing >> applyOn: anElement [

	anElement skinDo: [ :s | s applyMiddleSizing: self on: anElement ]
]

{ #category : #'private geometry' }
ToMiddleSizing >> heightOn: anElement [

	^ anElement toTheme controlHeight
]

{ #category : #'private geometry' }
ToMiddleSizing >> shapingRadiusIn: anElement [

		^ anElement toTheme borderRadius
]
