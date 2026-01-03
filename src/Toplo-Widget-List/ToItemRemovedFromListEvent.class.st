Class {
	#name : #ToItemRemovedFromListEvent,
	#superclass : #ToListItemEvent,
	#instVars : [
		'wasSelected'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #sending }
ToItemRemovedFromListEvent >> sendTo: anObject [

	anObject itemRemovedFromListEvent: self
]

{ #category : #accessing }
ToItemRemovedFromListEvent >> wasSelected [

	^ wasSelected
]

{ #category : #accessing }
ToItemRemovedFromListEvent >> wasSelected: aBoolean [

	wasSelected := aBoolean
]
