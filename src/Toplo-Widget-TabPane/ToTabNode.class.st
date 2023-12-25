Class {
	#name : #ToTabNode,
	#superclass : #ToListNode,
	#category : 'Toplo-Widget-TabPane'
}

{ #category : #initialization }
ToTabNode >> defaultPadding [

	^ (BlInsets top: 1 left: 4 bottom: 1 right: 4)
]
