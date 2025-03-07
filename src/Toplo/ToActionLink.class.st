Class {
	#name : #ToActionLink,
	#superclass : #ToWidgetLink,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #running }
ToActionLink >> applyChangeIn: aModel onEvent: anEvent withValue: aValue [

	action cull: anEvent cull: aModel cull: aValue.
	super applyChangeIn: aModel onEvent: anEvent withValue: aValue
]

{ #category : #initialization }
ToActionLink >> link: aTarget withModel: aModel action: aValuable [

	action := aValuable.
	self configureToUpdateModel: aModel from: aTarget
]
