Class {
	#name : #ToSelectListElement,
	#superclass : #ToListElement,
	#instVars : [
		'groupSelectionModel'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectListElement >> groupSelectionModel [

	^ groupSelectionModel
]

{ #category : #initialization }
ToSelectListElement >> initialize [

	super initialize.
	groupSelectionModel := self newSelectionModel 
]

{ #category : #skin }
ToSelectListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]
