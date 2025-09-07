Class {
	#name : #ToActionLinkSet,
	#superclass : #Object,
	#instVars : [
		'actionLinks'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToActionLinkSet >> add: anActionLink [

	actionLinks add: anActionLink 
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
