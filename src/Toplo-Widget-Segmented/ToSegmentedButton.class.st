Class {
	#name : #ToSegmentedButton,
	#superclass : #ToToggleButton,
	#traits : 'TToItem',
	#classTraits : 'TToItem classTrait',
	#category : #'Toplo-Widget-Segmented-Button'
}

{ #category : #skin }
ToSegmentedButton >> newRawSkin [

	^ ToSegmentedButtonSkin new
]
