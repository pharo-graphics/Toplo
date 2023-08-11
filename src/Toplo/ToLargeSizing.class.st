Class {
	#name : #ToLargeSizing,
	#superclass : #ToControlSizing,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'private geometry' }
ToLargeSizing >> heightOn: anElement [

	^ anElement toTheme controlHeightLG
]

{ #category : #'private geometry' }
ToLargeSizing >> shapingRadiusIn: anElement [

		^ anElement toTheme borderRadiusLG
]
