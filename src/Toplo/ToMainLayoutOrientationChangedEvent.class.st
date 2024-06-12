Class {
	#name : #ToMainLayoutOrientationChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'root'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToMainLayoutOrientationChangedEvent >> root [

	^ root
]

{ #category : #accessing }
ToMainLayoutOrientationChangedEvent >> root: anElement [

	root := anElement
]

{ #category : #sending }
ToMainLayoutOrientationChangedEvent >> sendTo: anObject [

	anObject mainLayoutOrientationChangedEvent: self
]
