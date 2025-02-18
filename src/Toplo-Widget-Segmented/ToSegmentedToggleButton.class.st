"
I'm a menu item with toggle behavior. 
I'm one of the leave of menu composite.
"
Class {
	#name : #ToSegmentedToggleButton,
	#superclass : #ToItemToggleButton,
	#traits : 'TToLabeledIcon',
	#classTraits : 'TToLabeledIcon classTrait',
	#category : #'Toplo-Widget-Segmented-Button'
}

{ #category : #skin }
ToSegmentedToggleButton >> newRawSkin [ 

	^ ToSegmentedToggleButtonSkin new
]

{ #category : #'adding-removing' }
ToSegmentedToggleButton >> onAddedInItemBarOwner: aSegmentedElement [

	aSegmentedElement onAddedSegmentedButton: self
]

{ #category : #'adding-removing' }
ToSegmentedToggleButton >> onRemovedFromItemBarOwner: aSegmentedElement [

	aSegmentedElement onRemovedSegmentedButton: self
]
