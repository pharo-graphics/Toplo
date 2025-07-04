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
ToActionLink >> runWithLinkedObject: anObjectOrValuable from: aTarget onEvent: anEvent withValue: aValue [

	| linked |
	linked := anObjectOrValuable isBlock
		          ifTrue: [ anObjectOrValuable cull: aTarget ]
		          ifFalse: [ anObjectOrValuable ].
	action cull: anEvent cull: linked cull: aValue.
	super
		runWithLinkedObject: linked
		from: aTarget
		onEvent: anEvent
		withValue: aValue
]
