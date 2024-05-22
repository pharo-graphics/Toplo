Class {
	#name : #ToElementBarSelectionChangedDep,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #sending }
ToElementBarSelectionChangedDep >> sendTo: anObject [

	anObject elementBarSelectionChanged: self
]
