Class {
	#name : #ToLargeSizing,
	#superclass : #ToControlSizing,
	#category : #'Toplo-Core-Theme'
}

{ #category : #hook }
ToLargeSizing >> applyOn: anElement [

	anElement skinDo: [ :s | s applyLargeSizing: self on: anElement ]
]

{ #category : #'private geometry' }
ToLargeSizing >> heightOn: anElement [

	^ anElement toTheme controlHeightLG
]

{ #category : #'private geometry' }
ToLargeSizing >> shapingRadiusIn: anElement [

		^ anElement toTheme borderRadiusLG
]
