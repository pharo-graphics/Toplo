Class {
	#name : #ToLayoutRootElementConstraintsChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'root'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToLayoutRootElementConstraintsChangedEvent >> root [

	^ root
]

{ #category : #accessing }
ToLayoutRootElementConstraintsChangedEvent >> root: anElement [

	root := anElement
]
