Class {
	#name : #ToMainResizerChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'root'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToMainResizerChangedEvent >> root [

	^ root
]

{ #category : #accessing }
ToMainResizerChangedEvent >> root: anElement [

	root := anElement
]

{ #category : #sending }
ToMainResizerChangedEvent >> sendTo: anObject [

	anObject mainResizerChangedEvent: self
]
