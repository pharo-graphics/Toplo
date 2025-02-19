"
I'm a menu item with toggle behavior. 
I'm one of the leave of menu composite.
"
Class {
	#name : #ToSegmentedToggleButton,
	#superclass : #ToItemToggleButton,
	#category : #'Toplo-Widget-Segmented-Button'
}

{ #category : #skin }
ToSegmentedToggleButton >> newRawSkin [ 

	^ ToSegmentedToggleButtonSkin new
]
