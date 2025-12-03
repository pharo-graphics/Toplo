Class {
	#name : #ToItemRemovedFromFiniteListEvent,
	#superclass : #ToFiniteListItemEvent,
	#instVars : [
		'wasSelected'
	],
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #sending }
ToItemRemovedFromFiniteListEvent >> sendTo: anObject [

	anObject itemRemovedFromBarEvent: self
]

{ #category : #accessing }
ToItemRemovedFromFiniteListEvent >> wasSelected [

	^ wasSelected
]

{ #category : #accessing }
ToItemRemovedFromFiniteListEvent >> wasSelected: aBoolean [

	wasSelected := aBoolean
]
