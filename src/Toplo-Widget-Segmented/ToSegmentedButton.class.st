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

{ #category : #'adding-removing' }
ToSegmentedButton >> onAddedInItemBar: aSegmentedItemBar [

	aSegmentedItemBar onAddedSegmentedButton: self
	
]

{ #category : #'adding-removing' }
ToSegmentedButton >> onRemovedFromItemBar: aSegmentedBar [

	aSegmentedBar onRemovedSegmentedButton: self
	
]
