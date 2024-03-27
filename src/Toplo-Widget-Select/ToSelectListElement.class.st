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
	self withUnselectableSelecter.
	self withHiddenSelecter.
	self withDisabledSelecter.
	self
		withAdditionalSelecterWithId: #group
		withEventClass: ToSelectGroupSelectionChangedEvent
]

{ #category : #skin }
ToSelectListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]
