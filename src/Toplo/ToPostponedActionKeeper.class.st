Class {
	#name : #ToPostponedActionKeeper,
	#superclass : #Object,
	#instVars : [
		'postponed'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #'action launching' }
ToPostponedActionKeeper >> applyOn: aClient [

	postponed do: [ :action | action value: aClient ]
]

{ #category : #initialization }
ToPostponedActionKeeper >> initialize [
	super initialize.
	postponed := OrderedCollection new
	
]

{ #category : #'action launching' }
ToPostponedActionKeeper >> proceed: aBlock [

	postponed add: aBlock
]

{ #category : #initialization }
ToPostponedActionKeeper >> reset [

	postponed reset
]
