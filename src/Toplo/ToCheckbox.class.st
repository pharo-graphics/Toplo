Class {
	#name : #ToCheckbox,
	#superclass : #ToButton,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - initialization dresser' }
ToCheckbox >> defaultDresser [

	^ ToCheckableButtonDresser new
]

{ #category : #'t - skin accessing' }
ToCheckbox >> defaultSkin [ 

	^ ToCheckboxSkin new
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
