Class {
	#name : #ToMiddleSizing,
	#superclass : #ToControlSizing,
	#category : 'Toplo-Theme-Skin-dep'
}

{ #category : #'private geometry' }
ToMiddleSizing >> applyOn: anElement [

	anElement skinDo: [ :s | s applyMiddleSizing: self on: anElement ]
]

{ #category : #'private geometry' }
ToMiddleSizing >> heightOn: anElement [

	^ anElement middleHeight
]

{ #category : #'private geometry' }
ToMiddleSizing >> shapingRadiusIn: anElement [

	^ anElement toTheme borderRadius
]
