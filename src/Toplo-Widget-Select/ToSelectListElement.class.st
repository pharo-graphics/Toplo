Class {
	#name : #ToSelectListElement,
	#superclass : #ToListElement,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectListElement >> groupSelecter [

	^ self additionalSelecterWithId: #group
]

{ #category : #accessing }
ToSelectListElement >> groupSelectionModel [

	^ self groupSelecter selectionModel
]

{ #category : #initialization }
ToSelectListElement >> initialize [

	super initialize.
	ToSelectGroupSelectionModelSelecter on: self
]

{ #category : #skin }
ToSelectListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]
