Class {
	#name : #ToLargeSizing,
	#superclass : #ToControlSizing,
	#category : #'Toplo-Core-Theme-skins'
}

{ #category : #hook }
ToLargeSizing >> applyOn: anElement [

	anElement skinDo: [ :s | s applyLargeSizing: self on: anElement ]
]

{ #category : #'private geometry' }
ToLargeSizing >> heightOn: anElement [

	^ anElement largeHeight
]

{ #category : #'private geometry' }
ToLargeSizing >> shapingRadiusIn: anElement [

	^ anElement toTheme borderRadiusLG
]
