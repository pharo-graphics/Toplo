Class {
	#name : #ToSegmentedButton,
	#superclass : #ToToggleButton,
	#category : #'Toplo-Widget-Segmented-Button'
}

{ #category : #'t - checkable  - protocol' }
ToSegmentedButton >> checkableEventHandlerClass [

	^ ToSegmentedButtonEventHandler 
]

{ #category : #skin }
ToSegmentedButton >> newRawSkin [

	^ ToSegmentedButtonSkin new
]
