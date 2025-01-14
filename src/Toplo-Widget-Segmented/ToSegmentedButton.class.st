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
ToSegmentedButton >> onAddedInItemBar: aSegmentedElement [

	aSegmentedElement onAddedSegmentedButton: self
	
]

{ #category : #'adding-removing' }
ToSegmentedButton >> onRemovedFromItemBar: aSegmentedElement [

	aSegmentedElement onRemovedSegmentedButton: self
	
]
