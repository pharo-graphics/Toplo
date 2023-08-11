Class {
	#name : #ToSmallSizing,
	#superclass : #ToControlSizing,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'private geometry' }
ToSmallSizing >> heightOn: anElement [

	^ anElement toTheme controlHeightSM
]

{ #category : #'private geometry' }
ToSmallSizing >> shapingRadiusIn: anElement [

		^ anElement toTheme borderRadiusSM
]
