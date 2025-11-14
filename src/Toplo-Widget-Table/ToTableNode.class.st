Class {
	#name : #ToTableNode,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #accessing }
ToTableNode >> columns [

	^ self holder listElement columns
]

{ #category : #accessing }
ToTableNode >> dividerAt: anIndex movedBy: aDistance from: aStartLocation [

	| elements first second |
	elements := self children.
	first := self childAt: anIndex.
	second := self childAt: anIndex + 1.
	first width: aStartLocation + aDistance.
	"second width: aStartLocation - aDistance"
]
