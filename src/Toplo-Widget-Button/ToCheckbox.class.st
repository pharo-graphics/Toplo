Class {
	#name : #ToCheckbox,
	#superclass : #ToButton,
	#traits : 'TToCheckable + TToCheckbox',
	#classTraits : 'TToCheckable classTrait + TToCheckbox classTrait',
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'t - initialization dresser' }
ToCheckbox >> defaultDresser [

	^ ToCheckableButtonDresser next: ToTripletDresser new
]

{ #category : #'as yet unclassified' }
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
