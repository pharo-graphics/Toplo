"
I'm a generic list 
"
Class {
	#name : #ToGenericFiniteListElement,
	#superclass : #ToGenericListElement,
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #initialization }
ToGenericFiniteListElement >> initialize [

	super initialize.
	self primarySelectionMode selectionOption
		grouped: false;
		beneath: true;
		triggerSelectionState: true.
	self contextMenuSelectionMode selectionOption
		grouped: false;
		beneath: false.
	self matchParent
]

{ #category : #configuration }
ToGenericFiniteListElement >> newToConfiguration [ 

	^ ToBasicFiniteListElementConfiguration new
]
