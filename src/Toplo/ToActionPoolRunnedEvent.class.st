Class {
	#name : #ToActionPoolRunnedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceActionLinkPool'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #sending }
ToActionPoolRunnedEvent >> sendTo: anObject [

	anObject actionPoolRunnedEvent: self
]

{ #category : #accessing }
ToActionPoolRunnedEvent >> sourceActionLinkPool [

	^ sourceActionLinkPool
]

{ #category : #accessing }
ToActionPoolRunnedEvent >> sourceActionLinkPool: anActionLinkSet [

	sourceActionLinkPool := anActionLinkSet
]
