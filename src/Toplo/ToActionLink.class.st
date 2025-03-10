Class {
	#name : #ToActionLink,
	#superclass : #ToWidgetLink,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToActionLink >> link: aTarget with: anObject action: aValuable [

	action := aValuable.
	self configureToUpdateLinkedObject: anObject from: aTarget
]

{ #category : #running }
ToActionLink >> runWithLinkedObject: anObject from: aTarget onEvent: anEvent withValue: aValue [

	action cull: anEvent cull: anObject cull: aValue.
	super
		runWithLinkedObject: anObject
		from: aTarget
		onEvent: anEvent
		withValue: aValue
]
