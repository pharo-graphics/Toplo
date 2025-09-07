Class {
	#name : #ToActionLinkSet,
	#superclass : #Object,
	#instVars : [
		'actionLinks',
		'holder'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToActionLinkSet >> add: anActionLink [

	actionLinks add: anActionLink.
	" record the handler to check that all actions are runned "
	anActionLink
		addedHandler: (anActionLink
				 addEventHandlerOn: ToLinkActionRunnedEvent
				 do: [ :evt | self checkIfAllActionsAreRunned ])
		in: anActionLink
]

{ #category : #initialization }
ToActionLinkSet >> checkIfAllActionsAreRunned [

	| runCountSet |
	" check if all actions are runned 
	(it is true, if all actions have the same runCount) "
	runCountSet := actionLinks collect: [ :al | al runCount ].
	runCountSet size > 1 ifTrue: [ ^ self ].
	" all runCount have the same value, notify that all actions are runned "
	holder dispatchEvent: ToAllLinkActionsRunnedEvent new
]

{ #category : #accessing }
ToActionLinkSet >> holder: anElement [

	holder := anElement
]

{ #category : #initialization }
ToActionLinkSet >> initialize [ 

	super initialize.
	actionLinks := IdentitySet new
]

{ #category : #initialization }
ToActionLinkSet >> remove: anActionLink [

	actionLinks remove: anActionLink
]
