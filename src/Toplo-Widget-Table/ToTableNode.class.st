Class {
	#name : #ToTableNode,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #accessing }
ToTableNode >> columns [

	^ self holder listElement columns
]
