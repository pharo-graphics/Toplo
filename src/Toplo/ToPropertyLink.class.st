Class {
	#name : #ToPropertyLink,
	#superclass : #ToWidgetLink,
	#instVars : [
		'property'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToPropertyLink >> configureToUpdate: aValueOwner fromLinkedObject: anObjectOrValuable [

	self subclassResponsibility 
]

{ #category : #initialization }
ToPropertyLink >> link: aWidget with: anObjectOrValuable reader: aReader writer: aWriter [

	property := ToSmartProperty new
		            reader: aReader;
		            writer: aWriter;
		            yourself.
	self configureToUpdate: aWidget fromLinkedObject: anObjectOrValuable.
	self configureToUpdateLinkedObject: anObjectOrValuable from: aWidget
]

{ #category : #running }
ToPropertyLink >> read: aLinkedObjectOrValuable [

	^ property read: aLinkedObjectOrValuable
]

{ #category : #running }
ToPropertyLink >> read: aLinkedObjectOrValuable for: aLinkCreator [

	| linked |
	linked := aLinkedObjectOrValuable isBlock
		          ifTrue: [ aLinkedObjectOrValuable cull: aLinkCreator ]
		          ifFalse: [ aLinkedObjectOrValuable ].
	^ self read: linked
]

{ #category : #running }
ToPropertyLink >> runWithLinkedObject: anObjectOrValuable from: aTarget onEvent: anEvent withValue: aValue [

	| linked |
	linked := anObjectOrValuable isBlock
		          ifTrue: [ anObjectOrValuable cull: aTarget ]
		          ifFalse: [ anObjectOrValuable ].

	property write: aValue to: linked.
	super
		runWithLinkedObject: linked
		from: aTarget
		onEvent: anEvent
		withValue: aValue
]
