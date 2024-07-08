Class {
	#name : #ToSelectListNode,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #accessing }
ToSelectListNode >> isGroup [

	^ self holder isGroup
]
