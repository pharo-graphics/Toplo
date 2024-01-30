Class {
	#name : #ToListStrongSelectionEvent,
	#superclass : #BlEvent,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #accessing }
ToListStrongSelectionEvent class >> indexes: aCollection [ 

	^ self new
		  indexes: aCollection;
		  yourself
]

{ #category : #accessing }
ToListStrongSelectionEvent >> indexes [

	^ indexes
]

{ #category : #accessing }
ToListStrongSelectionEvent >> indexes: aListOnInteger [

	indexes := aListOnInteger
]

{ #category : #accessing }
ToListStrongSelectionEvent >> sendTo: anObject [

	anObject listStrongSelectionEvent: self 


]
