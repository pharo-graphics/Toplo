Class {
	#name : #ToCheckbox,
	#superclass : #ToButton,
	#traits : 'TToCheckable + TToCheckbox',
	#classTraits : 'TToCheckable classTrait + TToCheckbox classTrait',
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #initialization }
ToCheckbox >> defaultEventHandler [ 

	^ ToCheckableEventHandler new 
]

{ #category : #'t - skinable - initialization' }
ToCheckbox >> defaultStyleTags [

	^ { #button. #checkable. #checkbox}
]

{ #category : #initialization }
ToCheckbox >> initialize [

	super initialize.
	self initializeCheckable
]

{ #category : #'accessing sizing' }
ToCheckbox >> largeHeight [ 

	^ 26
]

{ #category : #'accessing sizing' }
ToCheckbox >> middleHeight [ 

	^ 22
]

{ #category : #'accessing sizing' }
ToCheckbox >> smallHeight [ 

	^ 18
]
