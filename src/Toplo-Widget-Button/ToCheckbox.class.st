Class {
	#name : #ToCheckbox,
	#superclass : #ToButton,
	#traits : 'TToCheckable + TToCheckbox',
	#classTraits : 'TToCheckable classTrait + TToCheckbox classTrait',
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'t - initialization dresser' }
ToCheckbox >> defaultDresser [

	^ ToCheckableButtonDresser new
]

{ #category : #'t - skinable - initialization' }
ToCheckbox >> defaultStyleTags [

	^ { #button. #checkable. #checkbox}
]

{ #category : #initialization }
ToCheckbox >> initialize [

	super initialize.
	self initializeCheckable.
	self initializeIconImage

]

{ #category : #initialization }
ToCheckbox >> initializeIconImage [

	self iconImage: self uncheckedImage.


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
