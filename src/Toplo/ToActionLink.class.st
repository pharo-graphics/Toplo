Class {
	#name : #ToActionLink,
	#superclass : #ToWidgetLink,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #running }
ToActionLink >> applyChangeOn: aModel with: aValue [

	action cull: aModel cull: aValue.
	super applyChangeOn: aModel with: aValue
]

{ #category : #initialization }
ToActionLink >> link: aTarget withModel: aModel action: aValuable [

	action := aValuable.
	self configureToUpdateModel: aModel from: aTarget
]
