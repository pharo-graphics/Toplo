Class {
	#name : #ToCheckLook,
	#superclass : #ToDefaultElementLook,
	#instVars : [
		'checkedImage',
		'indeterminateImage',
		'uncheckedImage',
		'disabledImage'
	],
	#category : #'Toplo-Theme-Look'
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

	anEvent elementDo: [ :e | self syncImageIn: e ]
]

{ #category : #accessing }
ToCheckLook >> disabledImage [

	^ disabledImage
]

{ #category : #accessing }
ToCheckLook >> disabledImage: anImage [

	disabledImage := anImage
]

{ #category : #accessing }
ToCheckLook >> disabledLookEvent: anEvent [

	anEvent elementDo: [ :e |
		| im |
		im := self disabledImage.
		im removeFromParent.
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
ToCheckLook >> initialLookEvent: anEvent [

	anEvent elementDo: [ :e | self syncImageIn: e ]
]

{ #category : #accessing }
ToCheckLook >> syncImageIn: anElement [

	| im |
	im := anElement isChecked
		      ifTrue: [ self checkedImage ]
		      ifFalse: [
			      anElement isUnchecked
				      ifTrue: [ self uncheckedImage ]
				      ifFalse: [ self indeterminateImage ] ].
	im removeFromParent.
	anElement iconImage: im
]

{ #category : #accessing }
ToCheckLook >> uncheckedImage [

	^ uncheckedImage
]

{ #category : #accessing }
ToCheckLook >> uncheckedImage: anImage [

	uncheckedImage := anImage
]
