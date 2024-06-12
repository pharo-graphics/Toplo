Class {
	#name : #ToMainLayoutDirectionChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'root'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToMainLayoutDirectionChangedEvent >> root [

	^ root
]

{ #category : #accessing }
ToMainLayoutDirectionChangedEvent >> root: anElement [

	root := anElement
]

{ #category : #sending }
ToMainLayoutDirectionChangedEvent >> sendTo: anObject [

	anObject mainLayoutDirectionChangedEvent: self
]
