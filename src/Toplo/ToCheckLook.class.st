Class {
	#name : #ToCheckLook,
	#superclass : #ToElementLook,
	#instVars : [
		'checkedImage',
		'indeterminateImage',
		'uncheckedImage'
	],
	#category : #'Toplo-Core-Theme-Looks'
}

{ #category : #accessing }
ToCheckLook >> checkedImage [

	^ checkedImage
]

{ #category : #accessing }
ToCheckLook >> checkedImage: anImage [

	checkedImage := anImage
]

{ #category : #accessing }
ToCheckLook >> clickLookEvent: anEvent [

	anEvent elementDo: [ :e |
		| im |
		im := e isChecked
			      ifTrue: [ self checkedImage ]
			      ifFalse: [
				      e isUnchecked
					      ifTrue: [ self uncheckedImage ]
					      ifFalse: [ self indeterminateImage ] ].
		e iconImage: im ]
]

{ #category : #accessing }
ToCheckLook >> indeterminateImage [

	^ indeterminateImage
]

{ #category : #accessing }
ToCheckLook >> indeterminateImage: anImage [

	indeterminateImage := anImage
]

{ #category : #accessing }
ToCheckLook >> uncheckedImage [

	^ uncheckedImage
]

{ #category : #accessing }
ToCheckLook >> uncheckedImage: anImage [

	uncheckedImage := anImage
]
