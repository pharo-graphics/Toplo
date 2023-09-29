Class {
	#name : #ToStrongSelectionEvent,
	#superclass : #BlEvent,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-infinite'
}

{ #category : #accessing }
ToStrongSelectionEvent class >> indexes: aCollection [ 

	^ self new
		  indexes: aCollection;
		  yourself
]

{ #category : #accessing }
ToStrongSelectionEvent >> indexes [

	^ indexes
]

{ #category : #accessing }
ToStrongSelectionEvent >> indexes: aListOnInteger [

	indexes := aListOnInteger
]

{ #category : #accessing }
ToStrongSelectionEvent >> sendTo: anObject [

	anObject strongSelectionEvent: self 


]
