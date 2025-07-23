Class {
	#name : #ToItemAddedInBarEvent,
	#superclass : #ToBarItemEvent,
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #sending }
ToItemAddedInBarEvent >> sendTo: anObject [

	anObject itemAddedInBarEvent: self
]
