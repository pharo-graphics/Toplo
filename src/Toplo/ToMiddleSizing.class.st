Class {
	#name : #ToMiddleSizing,
	#superclass : #ToControlSizing,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'private geometry' }
ToMiddleSizing >> heightOn: anElement [

	^ anElement toTheme controlHeight
]

{ #category : #'private geometry' }
ToMiddleSizing >> shapingRadiusIn: anElement [

		^ anElement toTheme borderRadius
]
