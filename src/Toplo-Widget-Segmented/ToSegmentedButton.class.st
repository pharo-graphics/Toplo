Class {
	#name : #ToSegmentedButton,
	#superclass : #ToToggleButton,
	#traits : 'TToItem',
	#classTraits : 'TToItem classTrait',
	#category : #'Toplo-Widget-Segmented-Button'
}

{ #category : #initialization }
ToSegmentedButton >> initialize [ 

	super initialize.
	self matchParent
]

{ #category : #skin }
ToSegmentedButton >> newRawSkin [

	^ ToSegmentedButtonSkin new
]

{ #category : #'adding-removing' }
ToSegmentedButton >> onAddedInItemBarOwner: aSegmentedElement [

	aSegmentedElement onAddedSegmentedButton: self
	
]

{ #category : #'adding-removing' }
ToSegmentedButton >> onRemovedFromItemBarOwner: aSegmentedElement [

	aSegmentedElement onRemovedSegmentedButton: self
	
]
