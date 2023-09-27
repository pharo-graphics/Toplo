Class {
	#name : #ToListDataEmptinessChangeEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List'
}

{ #category : #sending }
ToListDataEmptinessChangeEvent >> sendTo: anObject [

	anObject listDataEmptinessChangeEvent: self
]
