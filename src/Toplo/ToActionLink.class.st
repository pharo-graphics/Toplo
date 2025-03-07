Class {
	#name : #ToActionLink,
	#superclass : #ToModelLink,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #'reading-writing' }
ToActionLink >> applyChangeOn: aModel with: aValue [

	action value: aModel value: aValue.
	super applyChangeOn: aModel with: aValue
]

{ #category : #initialization }
ToActionLink >> link: aTarget withModel: aModel action: aValuable [

	action := aValuable.
	self configureToUpdateModel: aModel from: aTarget
]
