Class {
	#name : #ToItemRemovedFromBarEvent,
	#superclass : #ToBarItemEvent,
	#instVars : [
		'wasSelected'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #sending }
ToItemRemovedFromBarEvent >> sendTo: anObject [

	anObject itemRemovedFromBarEvent: self
]

{ #category : #accessing }
ToItemRemovedFromBarEvent >> wasSelected [

	^ wasSelected
]

{ #category : #accessing }
ToItemRemovedFromBarEvent >> wasSelected: aBoolean [

	wasSelected := aBoolean
]
