Class {
	#name : #ToListDataEmptinessChangeEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-infinite'
}

{ #category : #sending }
ToListDataEmptinessChangeEvent >> sendTo: anObject [

	anObject listDataEmptinessChangeEvent: self
]
