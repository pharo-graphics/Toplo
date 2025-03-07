Class {
	#name : #ToSegmentedCheckbox,
	#superclass : #ToSegmentedToggleButton,
	#category : #'Toplo-Widget-Segmented-Button'
}

{ #category : #skin }
ToSegmentedCheckbox >> newRawSkin [ 

	^ ToSegmentedCheckboxSkin new
]

{ #category : #skin }
ToSegmentedCheckbox >> uninstallRawStyle [

	super uninstallRawStyle.
	self icon: nil
]
